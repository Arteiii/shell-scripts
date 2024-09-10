#!/bin/bash

SYSTEM_USER="pgadmin"
PGUSER=""
PGPASSWORD=""
PGDATABASE=""

usage() {
    echo "Usage: $0 -u <pg_user> -p <pg_password> -d <pg_database> [-s <system_user>]"
    echo "  -u: PostgreSQL username (required)"
    echo "  -p: PostgreSQL user password (required)"
    echo "  -d: PostgreSQL database name (required)"
    echo "  -s: System user for PostgreSQL isolation (optional, default: pgadmin)"
    exit 1
}

while getopts ":u:p:d:s:" opt; do
  case $opt in
    u) PGUSER="$OPTARG"
    ;;
    p) PGPASSWORD="$OPTARG"
    ;;
    d) PGDATABASE="$OPTARG"
    ;;
    s) SYSTEM_USER="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
        usage
    ;;
    :) echo "Option -$OPTARG requires an argument." >&2
        usage
    ;;
  esac
done

if [ -z "$PGUSER" ] || [ -z "$PGPASSWORD" ] || [ -z "$PGDATABASE" ]; then
    echo "Error: PostgreSQL username, password, and database are required."
    usage
fi

echo "Updating package list..."
sudo apt update -y

echo "Installing PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib

if id "$SYSTEM_USER" &>/dev/null; then
    echo "System user '$SYSTEM_USER' already exists."
else
    echo "Creating new system user: $SYSTEM_USER"
    sudo adduser --system --group --shell /bin/bash $SYSTEM_USER
fi

echo "Adding system user '$SYSTEM_USER' to PostgreSQL group..."
sudo usermod -aG $SYSTEM_USER postgres

echo "Starting PostgreSQL service..."
sudo systemctl start postgresql
sudo systemctl enable postgresql

echo "Creating PostgreSQL user and database..."
sudo -i -u postgres psql -c "CREATE USER $PGUSER WITH PASSWORD '$PGPASSWORD';"
sudo -i -u postgres psql -c "CREATE DATABASE $PGDATABASE OWNER $PGUSER;"
sudo -i -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $PGDATABASE TO $PGUSER;"

echo "Configuring PostgreSQL to allow password-based authentication..."
PG_HBA_FILE="/etc/postgresql/$(psql --version | grep -oP '[0-9]+(\.[0-9]+)+')/main/pg_hba.conf"
sudo sed -i "s/^#.*\(local.*all.*all.*\)peer/\1md5/" "$PG_HBA_FILE"
sudo systemctl restart postgresql

echo "PostgreSQL installation and setup completed."
echo "New system user '$SYSTEM_USER' created for managing PostgreSQL."
echo "PostgreSQL user '$PGUSER' and database '$PGDATABASE' created."

