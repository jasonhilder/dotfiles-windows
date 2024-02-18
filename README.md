# Dotfiles Windows

## Setup Steps

#### Open terminal as admin

#### Install Chocolatey
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

#### Set execution policy
```
Set-ExecutionPolicy Unrestricted
```

#### Install git
```
choco install git
```

#### Configure git
```
git config --global user.name "user name"

git config --global user.email "your_email@example.com"
```

#### Configure ssh and add to github
```
ssh-keygen -o -t rsa -C "email@address.com"

cd ~/.ssh

cat id_rsa.pub
```

#### Get the repo
```
cd ~

git clone git@github.com:jasonhilder/dotfiles-windows.git
```

#### Copy config files and profile settings

```
cd ~\dotfiles-windows

.\setup.ps1
```

#### install chocolatey packages
```
choco install .\system_packages\packages.config
```

### Stuff installed without chocolatey

* Rust (rustup)
* Raylib
