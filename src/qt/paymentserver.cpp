// Copyright (c) 2009-2012 The Bitcoin developers
// Distributed under the MIT/X11 software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#include <QApplication>

#include "paymentserver.h"

#include "bitcoinunits.h"
#include "guiutil.h"
#include "guiconstants.h"
#include "ui_interface.h"
#include "util.h"

#include <QByteArray>
#include <QDataStream>
#include <QDebug>
#include <QFileOpenEvent>
#include <QHash>
#include <QLocalServer>
#include <QLocalSocket>
#include <QStringList>
#include <QUrl>

using namespace boost;

const int BITCOIN_IPC_CONNECT_TIMEOUT = 1000; // milliseconds
const QString BITCOIN_IPC_PREFIX("Syndicate:");

//
// Create a name that is unique for:
//  testnet / non-testnet
//  data directory
//
static QString ipcServerName()
{
    QString name("SyndicateQt");

    // Append a simple hash of the datadir
    // Note that GetDataDir(true) returns a different path
    // for -testnet versus main net
    QString ddir(GetDataDir(true).string().c_str());
    name.append(QString::number(qHash(ddir)));

    return name;
}

//
// This stores payment requests received before
// the main GUI window is up and ready to ask the user
// to send payment.
//
static QStringList savedPaymentRequests;

//
// Sending to the server is done synchronously, at startup.
// If the server isn't already running, startup continues,
// and the items in savedPaymentRequest will be handled
// when uiReady() is called.
//
// Warning: ipcSendCommandLine() is called early in init,
// so don't use "emit message()", but "QMessageBox::"!
//
void PaymentServer::ipcParseCommandLine(int argc, char* argv[])
{
    for (int i = 1; i < argc; i++) {
        QString arg(argv[i]);
        if (arg.startsWith("-"))
            continue;

        // If the Syndicate: URI contains a payment request, we are not able to detect the
        // network as that would require fetching and parsing the payment request.
        // That means clicking such an URI which contains a testnet payment request
        // will start a mainnet instance and throw a "wrong network" error.
        if (arg.startsWith(BITCOIN_IPC_PREFIX, Qt::CaseInsensitive)) // Syndicate: URI
        {
            savedPaymentRequests.append(arg);

            SendCoinsRecipient r;
            if (GUIUtil::parseBitcoinURI(arg, &r) && !r.address.isEmpty()) {
                CBitcoinAddress address(r.address.toStdString());

                if (address.IsValid(Params(CChainParams::MAIN))) {
                    SelectParams(CChainParams::MAIN);
                } else if (address.IsValid(Params(CChainParams::TESTNET))) {
                    SelectParams(CChainParams::TESTNET);
                }
            }
        } else {
            // Printing to debug.log is about the best we can do here, the
            // GUI hasn't started yet so we can't pop up a message box.
            qWarning() << "PaymentServer::ipcSendCommandLine : Payment request file does not exist: " << arg;
        }
    }
}

//
// Sending to the server is done synchronously, at startup.
// If the server isn't already running, startup continues,
// and the items in savedPaymentRequest will be handled
// when uiReady() is called.
//
bool PaymentServer::ipcSendCommandLine()
{
    bool fResult = false;

    const QStringList& args = qApp->arguments();
    for (int i = 1; i < args.size(); i++)
    {
        if (!args[i].startsWith(BITCOIN_IPC_PREFIX, Qt::CaseInsensitive))
            continue;
        savedPaymentRequests.append(args[i]);
    }

    foreach (const QString& arg, savedPaymentRequests)
    {
        QLocalSocket* socket = new QLocalSocket();
        socket->connectToServer(ipcServerName(), QIODevice::WriteOnly);
        if (!socket->waitForConnected(BITCOIN_IPC_CONNECT_TIMEOUT))
            return false;

        QByteArray block;
        QDataStream out(&block, QIODevice::WriteOnly);
        out.setVersion(QDataStream::Qt_4_0);
        out << arg;
        out.device()->seek(0);
        socket->write(block);
        socket->flush();

        socket->waitForBytesWritten(BITCOIN_IPC_CONNECT_TIMEOUT);
        socket->disconnectFromServer();
        delete socket;
        fResult = true;
    }
    return fResult;
}

PaymentServer::PaymentServer(QApplication* parent) : QObject(parent), saveURIs(true)
{
    // Install global event filter to catch QFileOpenEvents on the mac (sent when you click bitcoin: links)
    parent->installEventFilter(this);

    QString name = ipcServerName();

    // Clean up old socket leftover from a crash:
    QLocalServer::removeServer(name);

    uriServer = new QLocalServer(this);

    if (!uriServer->listen(name))
        qDebug() << tr("Cannot start Syndicate: click-to-pay handler");
    else
        connect(uriServer, SIGNAL(newConnection()), this, SLOT(handleURIConnection()));
}

bool PaymentServer::eventFilter(QObject *object, QEvent *event)
{
    // clicking on bitcoin: URLs creates FileOpen events on the Mac:
    if (event->type() == QEvent::FileOpen)
    {
        QFileOpenEvent* fileEvent = static_cast<QFileOpenEvent*>(event);
        if (!fileEvent->url().isEmpty())
        {
            if (saveURIs) // Before main window is ready:
                savedPaymentRequests.append(fileEvent->url().toString());
            else
                emit receivedURI(fileEvent->url().toString());
            return true;
        }
    }
    return false;
}

void PaymentServer::uiReady()
{
    saveURIs = false;
    foreach (const QString& s, savedPaymentRequests)
        emit receivedURI(s);
    savedPaymentRequests.clear();
}

void PaymentServer::handleURIConnection()
{
    QLocalSocket *clientConnection = uriServer->nextPendingConnection();

    while (clientConnection->bytesAvailable() < (int)sizeof(quint32))
        clientConnection->waitForReadyRead();

    connect(clientConnection, SIGNAL(disconnected()),
            clientConnection, SLOT(deleteLater()));

    QDataStream in(clientConnection);
    in.setVersion(QDataStream::Qt_4_0);
    if (clientConnection->bytesAvailable() < (int)sizeof(quint16)) {
        return;
    }
    QString message;
    in >> message;

    if (saveURIs)
        savedPaymentRequests.append(message);
    else
        emit receivedURI(message);
}

void PaymentServer::setOptionsModel(OptionsModel *optionsModel)
{
    this->optionsModel = optionsModel;
}
