#!/bin/bash

sudo apt install -y gnupg postgresql-common apt-transport-https lsb-release wget &&
yes | sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh &&
sudo echo "deb https://packagecloud.io/timescale/timescaledb/ubuntu/ $(lsb_release -c -s) main" | sudo tee /etc/apt/sources.list.d/timescaledb.list &&
wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | sudo apt-key add - &&
sudo apt update &&
sudo apt install -y timescaledb-2-postgresql-14 &&
sudo timescaledb-tune --quiet --yes &&
sudo systemctl restart postgresql &&
sudo apt-get install -y postgresql-client
