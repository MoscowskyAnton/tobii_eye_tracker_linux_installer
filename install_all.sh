#!/usr/bin/env bash

wget -P  /tmp http://archive.ubuntu.com/ubuntu/pool/main/g/glibc/multiarch-support_2.27-3ubuntu1.2_amd64.deb
sudo dpkg -i /tmp/multiarch-support_2.27-3ubuntu1.2_amd64.deb

LIB_DIR=./lib


sudo apt --fix-broken install gconf2 gconf-service libappindicator1 libsqlcipher0 ./deps/libuv0.10_0.10.22-2_amd64.deb libpthread-stubs0-dev build-essential


# Tested on  Ubuntu 20.04 LTS

# Install Tobii USB Host (mandatory) that handles connections to the tracker:
sudo dpkg -i tobiiusbservice_l64U14_2.1.5-28fd4a.deb

# Install Tobii Engine daemon (recommended) that offers extended functionality
sudo dpkg -i tobii_engine_linux-0.1.6.193_rc-Linux.deb

#Install Tobii Config (recommended) to do screen setup and calibration:
sudo dpkg -i tobii_config_0.1.6.111_amd64.deb

#Install Stream Engine Client library to develop for your eye tracker:
if [[ ! -e "${LIB_DIR}" ]]; then
    mkdir ${LIB_DIR}
    tar -xzvf stream_engine_linux_3.0.4.6031.tar.gz -C ${LIB_DIR}
else
    echo "${LIB_DIR} already exist. Continue..."
fi

sudo mkdir /usr/lib/tobii
sudo cp -pR ${LIB_DIR}/lib/x64/*.so /usr/lib/tobii/
sudo cp ./tobii.conf /etc/ld.so.conf.d/
sudo mkdir /usr/include/tobii
sudo cp -R ${LIB_DIR}/include/tobii/* /usr/include/tobii

sudo apt install ./TobiiProEyeTrackerManager-2.1.0.deb

echo "Done instalation"
