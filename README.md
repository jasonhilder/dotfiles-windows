# Dotfiles Windows :)

## Setup Steps

#### Set execution policy
```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### Install Scoop
```
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```
scoop should be the first place to get applications, if not available do the normal route.

#### Configure git
```
git config --global user.name "user name"

git config --global user.email "your_email@example.com"
```
Then setup ssh keys etc etc...

#### Get the repo
```
cd ~

git clone git@github.com:jasonhilder/dotfiles-windows.git dotfiles
```

#### Copy config files and profile settings

```
cd ~\dotfiles

.\setup.ps1
```

#### Install scoop apps

Scoop makes life easy and linux like, setting up paths etc as well as exporting all installed apps as json for an easy import 

```
scoop import .\scoop_apps.json
```

### Software installed without scoop

Generally software that has auto updates like browsers, or things I found don't work as expected with my setup and scoop.

[Firefox](https://www.mozilla.org/en-US/firefox/developer/)

[Steam](https://store.steampowered.com/about)

SDL I had to make a work around I have a local_libs folder in my home directory where these are linked for local dev, each of the following sdl2 libs have been downloaded as the mingw varient to work with my toolchain.
SDL2
SDL2_image
SDL2_mixer
SDL2_ttf
SDL2_net

