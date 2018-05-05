
# x86_64-pc-linux-gnu
./autogen.sh;
./configure --prefix=`pwd`/depends/x86_64-pc-linux-gnu
make -j4 -k
mkdir -p build/v2.0.0.0/x86_64-pc-linux-gnu;
cp ./src/syndicated ./build/v2.0.0.0/x86_64-pc-linux-gnu/syndicated;
cp ./src/syndicate-tx ./build/v2.0.0.0/x86_64-pc-linux-gnu/syndicate-tx;
cp ./src/syndicate-cli ./build/v2.0.0.0/x86_64-pc-linux-gnu/syndicate-cli;
cp ./src/qt/syndicate-qt ./build/v2.0.0.0/x86_64-pc-linux-gnu/syndicate-qt;
strip ./build/v2.0.0.0/x86_64-pc-linux-gnu/syndicated
strip ./build/v2.0.0.0/x86_64-pc-linux-gnu/syndicate-tx
strip ./build/v2.0.0.0/x86_64-pc-linux-gnu/syndicate-cli
strip ./build/v2.0.0.0/x86_64-pc-linux-gnu/syndicate-qt

cd build/v2.0.0.0/x86_64-pc-linux-gnu;
cd ../../..;

make clean;cd src;make clean;cd ..;

# x86_64-w64-mingw32
./autogen.sh;
./configure --prefix=`pwd`/depends/x86_64-w64-mingw32
make HOST=x86_64-w64-mingw32 -j4 -k;

mkdir -p build/v2.0.0.0/x86_64-w64-mingw32;
cp ./src/syndicated.exe ./build/v2.0.0.0/x86_64-w64-mingw32/syndicated.exe;
cp ./src/syndicate-tx.exe ./build/v2.0.0.0/x86_64-w64-mingw32/syndicate-tx.exe;
cp ./src/syndicate-cli.exe ./build/v2.0.0.0/x86_64-w64-mingw32/syndicate-cli.exe;
cp ./src/qt/syndicate-qt.exe ./build/v2.0.0.0/x86_64-w64-mingw32/syndicate-qt.exe;
strip ./build/v2.0.0.0/x86_64-w64-mingw32/syndicated.exe
strip ./build/v2.0.0.0/x86_64-w64-mingw32/syndicate-tx.exe
strip ./build/v2.0.0.0/x86_64-w64-mingw32/syndicate-cli.exe
strip ./build/v2.0.0.0/x86_64-w64-mingw32/syndicate-qt.exe
## created detached signatures
cd build/v2.0.0.0/x86_64-w64-mingw32;


##/C= 	Country 	GB
##/ST= 	State 	London
##/L= 	Location 	London
##/O= 	Organization 	Global Security
##/OU= 	Organizational Unit 	IT Department
##/CN= 	Common Name 	example.com

openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./syndicate-qt-selfsigned.key -out ./syndicate-qt-selfsigned.crt -subj "/C=AT/ST=Vienna/L=Vienna/O=Development/OU=Core Development/CN=syndicateltd.net";
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./syndicated-selfsigned.key -out ./syndicated-selfsigned.crt -subj "/C=AT/ST=Vienna/L=Vienna/O=Development/OU=Core Development/CN=syndicateltd.net";
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./syndicate-tx-selfsigned.key -out ./syndicate-tx-selfsigned.crt -subj "/C=AT/ST=Vienna/L=Vienna/O=Development/OU=Core Development/CN=syndicateltd.net"; 
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./syndicate-cli-selfsigned.key -out ./syndicate-cli-selfsigned.crt -subj "/C=AT/ST=Vienna/L=Vienna/O=Development/OU=Core Development/CN=syndicateltd.net"; 

osslsigncode sign -certs syndicate-qt-selfsigned.crt -key syndicate-qt-selfsigned.key \
        -n "Syndicate Ltd" -i http://www.syndicateltd.net/ \
        -t http://timestamp.verisign.com/scripts/timstamp.dll \
        -in syndicate-qt.exe -out syndicate-qt-signed.exe

osslsigncode sign -certs syndicated-selfsigned.crt -key syndicated-selfsigned.key \
        -n "Syndicate Ltd" -i http://www.syndicateltd.net/ \
        -t http://timestamp.verisign.com/scripts/timstamp.dll \
        -in syndicated.exe -out syndicated-signed.exe

osslsigncode sign -certs syndicate-tx-selfsigned.crt -key syndicate-tx-selfsigned.key \
        -n "Syndicate Ltd" -i http://www.syndicateltd.net/ \
        -t http://timestamp.verisign.com/scripts/timstamp.dll \
        -in syndicate-tx.exe -out syndicate-tx-signed.exe

osslsigncode sign -certs syndicate-cli-selfsigned.crt -key syndicate-cli-selfsigned.key \
        -n "Syndicate Ltd" -i http://www.syndicateltd.net/ \
        -t http://timestamp.verisign.com/scripts/timstamp.dll \
        -in syndicate-cli.exe -out syndicate-cli-signed.exe

mv syndicate-qt-signed.exe syndicate-qt.exe;
mv syndicated-signed.exe syndicated.exe;
mv syndicate-tx-signed.exe syndicate-tx.exe;
mv syndicate-cli-signed.exe syndicate-cli.exe;

cd ../../..;
make clean;cd src;make clean;cd ..;

# i686-w64-mingw32
./autogen.sh;
./configure --prefix=`pwd`/depends/i686-w64-mingw32
make HOST=i686-w64-mingw32 -j4 -k;

mkdir -p build/v2.0.0.0/i686-w64-mingw32;
cp ./src/syndicated.exe ./build/v2.0.0.0/i686-w64-mingw32/syndicated.exe;
cp ./src/syndicate-tx.exe ./build/v2.0.0.0/i686-w64-mingw32/syndicate-tx.exe;
cp ./src/syndicate-cli.exe ./build/v2.0.0.0/i686-w64-mingw32/syndicate-cli.exe;
cp ./src/qt/syndicate-qt.exe ./build/v2.0.0.0/i686-w64-mingw32/syndicate-qt.exe;
strip ./build/v2.0.0.0/i686-w64-mingw32/syndicated.exe
strip ./build/v2.0.0.0/i686-w64-mingw32/syndicate-tx.exe
strip ./build/v2.0.0.0/i686-w64-mingw32/syndicate-cli.exe
strip ./build/v2.0.0.0/i686-w64-mingw32/syndicate-qt.exe
## created detached signatures
cd build/v2.0.0.0/i686-w64-mingw32;

##/C= 	Country 	GB
##/ST= 	State 	London
##/L= 	Location 	London
##/O= 	Organization 	Global Security
##/OU= 	Organizational Unit 	IT Department
##/CN= 	Common Name 	example.com

openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./syndicate-qt-selfsigned.key -out ./syndicate-qt-selfsigned.crt -subj "/C=AT/ST=Vienna/L=Vienna/O=Development/OU=Core Development/CN=syndicateltd.net";
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./syndicated-selfsigned.key -out ./syndicated-selfsigned.crt -subj "/C=AT/ST=Vienna/L=Vienna/O=Development/OU=Core Development/CN=syndicateltd.net";
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./syndicate-tx-selfsigned.key -out ./syndicate-tx-selfsigned.crt -subj "/C=AT/ST=Vienna/L=Vienna/O=Development/OU=Core Development/CN=syndicateltd.net"; 
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./syndicate-cli-selfsigned.key -out ./syndicate-cli-selfsigned.crt -subj "/C=AT/ST=Vienna/L=Vienna/O=Development/OU=Core Development/CN=syndicateltd.net"; 

osslsigncode sign -certs syndicate-qt-selfsigned.crt -key syndicate-qt-selfsigned.key \
        -n "Syndicate Ltd" -i http://www.syndicateltd.net/ \
        -t http://timestamp.verisign.com/scripts/timstamp.dll \
        -in syndicate-qt.exe -out syndicate-qt-signed.exe

osslsigncode sign -certs syndicated-selfsigned.crt -key syndicated-selfsigned.key \
        -n "Syndicate Ltd" -i http://www.syndicateltd.net/ \
        -t http://timestamp.verisign.com/scripts/timstamp.dll \
        -in syndicated.exe -out syndicated-signed.exe

osslsigncode sign -certs syndicate-tx-selfsigned.crt -key syndicate-tx-selfsigned.key \
        -n "Syndicate Ltd" -i http://www.syndicateltd.net/ \
        -t http://timestamp.verisign.com/scripts/timstamp.dll \
        -in syndicate-tx.exe -out syndicate-tx-signed.exe

osslsigncode sign -certs syndicate-cli-selfsigned.crt -key syndicate-cli-selfsigned.key \
        -n "Syndicate Ltd" -i http://www.syndicateltd.net/ \
        -t http://timestamp.verisign.com/scripts/timstamp.dll \
        -in syndicate-cli.exe -out syndicate-cli-signed.exe

mv syndicate-qt-signed.exe syndicate-qt.exe;
mv syndicated-signed.exe syndicated.exe;
mv syndicate-tx-signed.exe syndicate-tx.exe;
mv syndicate-cli-signed.exe syndicate-cli.exe;

cd ../../..;
make clean;cd src;make clean;cd ..;

# arm-linux-gnueabihf
./autogen.sh;
./configure --prefix=`pwd`/depends/arm-linux-gnueabihf
make HOST=arm-linux-gnueabihf -j4 -k;

mkdir -p build/v2.0.0.0/arm-linux-gnueabihf;
cp ./src/syndicated ./build/v2.0.0.0/arm-linux-gnueabihf/syndicated;
cp ./src/syndicate-tx ./build/v2.0.0.0/arm-linux-gnueabihf/syndicate-tx;
cp ./src/syndicate-cli ./build/v2.0.0.0/arm-linux-gnueabihf/syndicate-cli;
cp ./src/qt/syndicate-qt ./build/v2.0.0.0/arm-linux-gnueabihf/syndicate-qt;
strip ./build/v2.0.0.0/arm-linux-gnueabihf/syndicated
strip ./build/v2.0.0.0/arm-linux-gnueabihf/syndicate-tx
strip ./build/v2.0.0.0/arm-linux-gnueabihf/syndicate-cli
strip ./build/v2.0.0.0/arm-linux-gnueabihf/syndicate-qt
# created detached signatures
cd build/v2.0.0.0/arm-linux-gnueabihf;
cd ../../..;
make clean;cd src;make clean;cd ..;

# aarch64-linux-gnu
./autogen.sh;
./configure --prefix=`pwd`/depends/aarch64-linux-gnu
make HOST=aarch64-linux-gnu -j4 -k;

mkdir -p build/v2.0.0.0/aarch64-linux-gnu;
cp ./src/syndicated ./build/v2.0.0.0/aarch64-linux-gnu/syndicated;
cp ./src/syndicate-tx ./build/v2.0.0.0/aarch64-linux-gnu/syndicate-tx;
cp ./src/syndicate-cli ./build/v2.0.0.0/aarch64-linux-gnu/syndicate-cli;
cp ./src/qt/syndicate-qt ./build/v2.0.0.0/aarch64-linux-gnu/syndicate-qt;
strip ./build/v2.0.0.0/aarch64-linux-gnu/syndicated
strip ./build/v2.0.0.0/aarch64-linux-gnu/syndicate-tx
strip ./build/v2.0.0.0/aarch64-linux-gnu/syndicate-cli
strip ./build/v2.0.0.0/aarch64-linux-gnu/syndicate-qt
# created detached signatures
cd build/v2.0.0.0/aarch64-linux-gnu;
cd ../../..;
make clean;cd src;make clean;cd ..;
