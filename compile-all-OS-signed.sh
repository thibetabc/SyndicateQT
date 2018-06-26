
# x86_64-pc-linux-gnu
./autogen.sh;
./configure --prefix=`pwd`/depends/x86_64-pc-linux-gnu
make -j4 -k
mkdir -p build/v2.0.0.0/x86_64-pc-linux-gnu;
cp ./src/walled ./build/v2.0.0.0/x86_64-pc-linux-gnu/walled;
cp ./src/walle-tx ./build/v2.0.0.0/x86_64-pc-linux-gnu/walle-tx;
cp ./src/walle-cli ./build/v2.0.0.0/x86_64-pc-linux-gnu/walle-cli;
cp ./src/qt/walle-qt ./build/v2.0.0.0/x86_64-pc-linux-gnu/walle-qt;
strip ./build/v2.0.0.0/x86_64-pc-linux-gnu/walled
strip ./build/v2.0.0.0/x86_64-pc-linux-gnu/walle-tx
strip ./build/v2.0.0.0/x86_64-pc-linux-gnu/walle-cli
strip ./build/v2.0.0.0/x86_64-pc-linux-gnu/walle-qt

cd build/v2.0.0.0/x86_64-pc-linux-gnu;
cd ../../..;

make clean;cd src;make clean;cd ..;

# x86_64-w64-mingw32
./autogen.sh;
./configure --prefix=`pwd`/depends/x86_64-w64-mingw32
make HOST=x86_64-w64-mingw32 -j4 -k;

mkdir -p build/v2.0.0.0/x86_64-w64-mingw32;
cp ./src/walled.exe ./build/v2.0.0.0/x86_64-w64-mingw32/walled.exe;
cp ./src/walle-tx.exe ./build/v2.0.0.0/x86_64-w64-mingw32/walle-tx.exe;
cp ./src/walle-cli.exe ./build/v2.0.0.0/x86_64-w64-mingw32/walle-cli.exe;
cp ./src/qt/walle-qt.exe ./build/v2.0.0.0/x86_64-w64-mingw32/walle-qt.exe;
strip ./build/v2.0.0.0/x86_64-w64-mingw32/walled.exe
strip ./build/v2.0.0.0/x86_64-w64-mingw32/walle-tx.exe
strip ./build/v2.0.0.0/x86_64-w64-mingw32/walle-cli.exe
strip ./build/v2.0.0.0/x86_64-w64-mingw32/walle-qt.exe
## created detached signatures
cd build/v2.0.0.0/x86_64-w64-mingw32;


##/C= 	Country 	GB
##/ST= 	State 	London
##/L= 	Location 	London
##/O= 	Organization 	Global Security
##/OU= 	Organizational Unit 	IT Department
##/CN= 	Common Name 	example.com

openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./walle-qt-selfsigned.key -out ./walle-qt-selfsigned.crt -subj "/C=AT/ST=Vienna/L=Vienna/O=Development/OU=Core Development/CN=walleltd.net";
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./walled-selfsigned.key -out ./walled-selfsigned.crt -subj "/C=AT/ST=Vienna/L=Vienna/O=Development/OU=Core Development/CN=walleltd.net";
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./walle-tx-selfsigned.key -out ./walle-tx-selfsigned.crt -subj "/C=AT/ST=Vienna/L=Vienna/O=Development/OU=Core Development/CN=walleltd.net"; 
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./walle-cli-selfsigned.key -out ./walle-cli-selfsigned.crt -subj "/C=AT/ST=Vienna/L=Vienna/O=Development/OU=Core Development/CN=walleltd.net"; 

osslsigncode sign -certs walle-qt-selfsigned.crt -key walle-qt-selfsigned.key \
        -n "Walle Ltd" -i http://www.walleltd.net/ \
        -t http://timestamp.verisign.com/scripts/timstamp.dll \
        -in walle-qt.exe -out walle-qt-signed.exe

osslsigncode sign -certs walled-selfsigned.crt -key walled-selfsigned.key \
        -n "Walle Ltd" -i http://www.walleltd.net/ \
        -t http://timestamp.verisign.com/scripts/timstamp.dll \
        -in walled.exe -out walled-signed.exe

osslsigncode sign -certs walle-tx-selfsigned.crt -key walle-tx-selfsigned.key \
        -n "Walle Ltd" -i http://www.walleltd.net/ \
        -t http://timestamp.verisign.com/scripts/timstamp.dll \
        -in walle-tx.exe -out walle-tx-signed.exe

osslsigncode sign -certs walle-cli-selfsigned.crt -key walle-cli-selfsigned.key \
        -n "Walle Ltd" -i http://www.walleltd.net/ \
        -t http://timestamp.verisign.com/scripts/timstamp.dll \
        -in walle-cli.exe -out walle-cli-signed.exe

mv walle-qt-signed.exe walle-qt.exe;
mv walled-signed.exe walled.exe;
mv walle-tx-signed.exe walle-tx.exe;
mv walle-cli-signed.exe walle-cli.exe;

cd ../../..;
make clean;cd src;make clean;cd ..;

# i686-w64-mingw32
./autogen.sh;
./configure --prefix=`pwd`/depends/i686-w64-mingw32
make HOST=i686-w64-mingw32 -j4 -k;

mkdir -p build/v2.0.0.0/i686-w64-mingw32;
cp ./src/walled.exe ./build/v2.0.0.0/i686-w64-mingw32/walled.exe;
cp ./src/walle-tx.exe ./build/v2.0.0.0/i686-w64-mingw32/walle-tx.exe;
cp ./src/walle-cli.exe ./build/v2.0.0.0/i686-w64-mingw32/walle-cli.exe;
cp ./src/qt/walle-qt.exe ./build/v2.0.0.0/i686-w64-mingw32/walle-qt.exe;
strip ./build/v2.0.0.0/i686-w64-mingw32/walled.exe
strip ./build/v2.0.0.0/i686-w64-mingw32/walle-tx.exe
strip ./build/v2.0.0.0/i686-w64-mingw32/walle-cli.exe
strip ./build/v2.0.0.0/i686-w64-mingw32/walle-qt.exe
## created detached signatures
cd build/v2.0.0.0/i686-w64-mingw32;

##/C= 	Country 	GB
##/ST= 	State 	London
##/L= 	Location 	London
##/O= 	Organization 	Global Security
##/OU= 	Organizational Unit 	IT Department
##/CN= 	Common Name 	example.com

openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./walle-qt-selfsigned.key -out ./walle-qt-selfsigned.crt -subj "/C=AT/ST=Vienna/L=Vienna/O=Development/OU=Core Development/CN=walleltd.net";
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./walled-selfsigned.key -out ./walled-selfsigned.crt -subj "/C=AT/ST=Vienna/L=Vienna/O=Development/OU=Core Development/CN=walleltd.net";
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./walle-tx-selfsigned.key -out ./walle-tx-selfsigned.crt -subj "/C=AT/ST=Vienna/L=Vienna/O=Development/OU=Core Development/CN=walleltd.net"; 
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./walle-cli-selfsigned.key -out ./walle-cli-selfsigned.crt -subj "/C=AT/ST=Vienna/L=Vienna/O=Development/OU=Core Development/CN=walleltd.net"; 

osslsigncode sign -certs walle-qt-selfsigned.crt -key walle-qt-selfsigned.key \
        -n "Walle Ltd" -i http://www.walleltd.net/ \
        -t http://timestamp.verisign.com/scripts/timstamp.dll \
        -in walle-qt.exe -out walle-qt-signed.exe

osslsigncode sign -certs walled-selfsigned.crt -key walled-selfsigned.key \
        -n "Walle Ltd" -i http://www.walleltd.net/ \
        -t http://timestamp.verisign.com/scripts/timstamp.dll \
        -in walled.exe -out walled-signed.exe

osslsigncode sign -certs walle-tx-selfsigned.crt -key walle-tx-selfsigned.key \
        -n "Walle Ltd" -i http://www.walleltd.net/ \
        -t http://timestamp.verisign.com/scripts/timstamp.dll \
        -in walle-tx.exe -out walle-tx-signed.exe

osslsigncode sign -certs walle-cli-selfsigned.crt -key walle-cli-selfsigned.key \
        -n "Walle Ltd" -i http://www.walleltd.net/ \
        -t http://timestamp.verisign.com/scripts/timstamp.dll \
        -in walle-cli.exe -out walle-cli-signed.exe

mv walle-qt-signed.exe walle-qt.exe;
mv walled-signed.exe walled.exe;
mv walle-tx-signed.exe walle-tx.exe;
mv walle-cli-signed.exe walle-cli.exe;

cd ../../..;
make clean;cd src;make clean;cd ..;

# arm-linux-gnueabihf
./autogen.sh;
./configure --prefix=`pwd`/depends/arm-linux-gnueabihf
make HOST=arm-linux-gnueabihf -j4 -k;

mkdir -p build/v2.0.0.0/arm-linux-gnueabihf;
cp ./src/walled ./build/v2.0.0.0/arm-linux-gnueabihf/walled;
cp ./src/walle-tx ./build/v2.0.0.0/arm-linux-gnueabihf/walle-tx;
cp ./src/walle-cli ./build/v2.0.0.0/arm-linux-gnueabihf/walle-cli;
cp ./src/qt/walle-qt ./build/v2.0.0.0/arm-linux-gnueabihf/walle-qt;
strip ./build/v2.0.0.0/arm-linux-gnueabihf/walled
strip ./build/v2.0.0.0/arm-linux-gnueabihf/walle-tx
strip ./build/v2.0.0.0/arm-linux-gnueabihf/walle-cli
strip ./build/v2.0.0.0/arm-linux-gnueabihf/walle-qt
# created detached signatures
cd build/v2.0.0.0/arm-linux-gnueabihf;
cd ../../..;
make clean;cd src;make clean;cd ..;

# aarch64-linux-gnu
./autogen.sh;
./configure --prefix=`pwd`/depends/aarch64-linux-gnu
make HOST=aarch64-linux-gnu -j4 -k;

mkdir -p build/v2.0.0.0/aarch64-linux-gnu;
cp ./src/walled ./build/v2.0.0.0/aarch64-linux-gnu/walled;
cp ./src/walle-tx ./build/v2.0.0.0/aarch64-linux-gnu/walle-tx;
cp ./src/walle-cli ./build/v2.0.0.0/aarch64-linux-gnu/walle-cli;
cp ./src/qt/walle-qt ./build/v2.0.0.0/aarch64-linux-gnu/walle-qt;
strip ./build/v2.0.0.0/aarch64-linux-gnu/walled
strip ./build/v2.0.0.0/aarch64-linux-gnu/walle-tx
strip ./build/v2.0.0.0/aarch64-linux-gnu/walle-cli
strip ./build/v2.0.0.0/aarch64-linux-gnu/walle-qt
# created detached signatures
cd build/v2.0.0.0/aarch64-linux-gnu;
cd ../../..;
make clean;cd src;make clean;cd ..;
