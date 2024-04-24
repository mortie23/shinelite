# Shine Lite

## Notes

```sh
sudo apt install build-essential
sudo apt install libcurl4-openssl-dev
sudo apt install libfontconfig1-dev
sudo apt install libharfbuzz-dev libfribidi-dev
sudo apt install libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev
sudo apt install libxml2-dev
```

```R
install.packages('renv')
```

Before

```sh
df -h
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           1.1G  2.0M  1.1G   1% /run
/dev/sda3        78G   14G   61G  18% /
tmpfs           5.2G     0  5.2G   0% /dev/shm
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
/dev/sda2       512M  6.1M  506M   2% /boot/efi
tmpfs           1.1G  112K  1.1G   1% /run/user/1007
```

After

```sh
df -h
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           1.1G  2.0M  1.1G   1% /run
/dev/sda3        78G   14G   61G  19% /
tmpfs           5.2G     0  5.2G   0% /dev/shm
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
/dev/sda2       512M  6.1M  506M   2% /boot/efi
tmpfs           1.1G  100K  1.1G   1% /run/user/1007
```

```R
renv::restore()
```


```log

renv: Project Environments for R

Welcome to renv! It looks like this is your first time using renv.
This is a one-time message, briefly describing some of renv's functionality.

renv will write to files within the active project folder, including:

  - A folder 'renv' in the project directory, and
  - A lockfile called 'renv.lock' in the project directory.

In particular, projects using renv will normally use a private, per-project
R library, in which new packages will be installed. This project library is
isolated from other R libraries on your system.

In addition, renv will update files within your project directory, including:

  - .gitignore
  - .Rbuildignore
  - .Rprofile

Finally, renv maintains a local cache of data on the filesystem, located at:

  - "~/.cache/R/renv"

This path can be customized: please see the documentation in `?renv::paths`.

Please read the introduction vignette with `vignette("renv")` for more information.
You can browse the package documentation online at https://rstudio.github.io/renv/.
Do you want to proceed? [y/N]: y

- "~/.cache/R/renv" has been created.
It looks like you've called renv::restore() in a project that hasn't been activated yet.
How would you like to proceed? 

1: Activate the project and use the project library.
2: Do not activate the project and use the current library paths.
3: Cancel and resolve the situation another way.
```


need dev tools to make all functions available

