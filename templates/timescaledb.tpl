#!/bin/bash

sudo apt install -y gnupg postgresql-common apt-transport-https lsb-release wget
yes | sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
sudo echo "deb https://packagecloud.io/timescale/timescaledb/ubuntu/ $(lsb_release -c -s) main" | sudo tee /etc/apt/sources.list.d/timescaledb.list
wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | sudo apt-key add -
sudo apt update
sudo apt install -y timescaledb-2-postgresql-14
sudo systemctl restart postgresql
sudo apt-get install -y postgresql-client
sudo ln -s /usr/lib/postgresql/14/bin/* /usr/bin/
sudo mkdir /timescaledb_data
sudo mkfs -t ext4 /dev/xvdh
sudo mount /dev/xvdh /timescaledb_data
sudo chown -R postgres:postgres /timescaledb_data
sudo systemctl stop postgresql
sudo -u postgres mkdir /timescaledb_data/main
sudo -u postgres initdb -D /timescaledb_data/main
sudo -u postgres timescaledb-tune -conf-path /timescaledb_data/main/postgresql.conf --quiet --yes
sudo -u postgres sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /timescaledb_data/main/postgresql.conf
sudo -u postgres sed -i 's/127.0.0.1\/32/0.0.0.0\/0   /g' /timescaledb_data/main/pg_hba.conf
sudo -u postgres pg_ctl -D /timescaledb_data/main -l /timescaledb_data/main/logfile start
sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'du21@2023';"
sudo -u postgres sed -i 's/trust/scram-sha-256/g' /timescaledb_data/main/pg_hba.conf
sudo -u postgres pg_ctl -D /timescaledb_data/main -l /timescaledb_data/main/logfile restart
