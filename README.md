# Shine Lite

A basic lite CRUD application framework for RShiny application development with a SQlite back end.

## Setup

I started developing this on a vanilla Ubuntu VM abd tried to capture all the things needed to get it up and running.

```sh
# Run this from your terminal (not console)
# Install all these OS binaries or you will get caught during the renv restore
sudo apt install build-essential
sudo apt install libcurl4-openssl-dev
sudo apt install libfontconfig1-dev
sudo apt install libharfbuzz-dev libfribidi-dev
sudo apt install libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev
sudo apt install libxml2-dev
```

Start with the initial install of renv.

```R
install.packages('renv')
```

Now install everything else with a renv restore

```R
renv::restore()
```

Let's just check the space on the VM

```sh
# Run this from your terminal (not console)
df -h
```

```log
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           1.1G  2.0M  1.1G   1% /run
/dev/sda3        78G   14G   61G  19% /
tmpfs           5.2G     0  5.2G   0% /dev/shm
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
/dev/sda2       512M  6.1M  506M   2% /boot/efi
tmpfs           1.1G  100K  1.1G   1% /run/user/1007
```

We also need the dev tools package to make all functions available.

```R
devtools::load_all(".")
```

Initialise the sqlite db in development environment.

```sh
# Run this from your terminal (not console)
export env=dev
db_path="/u01/data/shinelite/dev/todo_app.db"
sqlite3 $db_path <<EOF
CREATE TABLE IF NOT EXISTS todos (
    id INTEGER PRIMARY KEY,
    todo TEXT,
    done BOOLEAN DEFAULT FALSE
);
EOF
```

## The Renvironment

Create a `.Renviron` file in the root of the cloned repository and populate it with this:

```ini
env=dev
```

## Run the RShiny application in dev mode

```R
runApp('R')
```

Remember to add the two most important things to your new todo list:

![](man/img/shinelite.png)
