# **amcfwm**
AsusWRT-Merlin - Custom Firmware Manager

_Inspired By RMerlins [Original Script](https://raw.githubusercontent.com/RMerl/asuswrt-merlin.ng/master/tools/build-all)_

## **Features**
* Can configure default Ubuntu 20.04 VM
* Interactive menu
* Configurable settings
* No hard-coded settings/variables
* Daily build cronjob if git changes detected
* POSIX compliance

![AMCFWM Menu](https://i.imgur.com/Y7m5sLA.png)
![AMCFWM Settings Menu](https://i.imgur.com/jfZA1zF.png)
![AMCFWM Build Process](https://i.imgur.com/jpFzJlA.png)

&nbsp;

&nbsp;

## **Installation**

1. Download amcfwm
```
mkdir -p "$HOME/amcfwm" && curl -s "https://raw.githubusercontent.com/Adamm00/am_cfwm/master/amcfwm.sh" -o "$HOME/amcfwm/amcfwm.sh" && chmod 755 "$HOME/amcfwm/amcfwm.sh"
```
2. Setup VM Enviorment
```
sh $HOME/amcfwm/amcfwm.sh install
```
3. Setup Firmware/Toolchain Git Repo
```
sh $HOME/amcfwm/amcfwm.sh repo
```

&nbsp;

&nbsp;

## **Ubuntu 20.04.2 LTS Download Links**

**ISO** - <https://releases.ubuntu.com/20.04.2.0/ubuntu-20.04.2.0-desktop-amd64.iso>

**Torrent** - <https://releases.ubuntu.com/20.04/ubuntu-20.04.2.0-desktop-amd64.iso.torrent>

&nbsp;

&nbsp;

## **Usage**
amcfwm provides both a user interactive menu, and command line interface for those who prefer it.

#### **Menu**
To open the menu its as simple as typing;

```
amcfwm
```

#### **CLI**

```
( amcfwm install ) Setup VM Enviorment For Compiling
( amcfwm repo ) Setup Firmware/Toolchain Git Repos

( amcfwm build ) Build Configured Firmware Images If Updates Available

( amcfwm settings srcloc /path/to/location ) Change Location Of The Original Source Code
( amcfwm settings stageloc /path/to/location ) Change Location Of Built Images
( amcfwm settings finalloc admin@router.asus.com:/mnt/sda1/Share ) Change Remote Location To SCP Compiled Firmware Images
( amcfwm settings sshport 22 ) Change Remote Location SSH Port

( amcfwm settings buildrev enable|disable ) Enable/Disable Git Revision In Firmware Name
( amcfwm settings rsynctree enable|disable ) Enable/Disable Rsync Tree From Central Source Tree Before Build
( amcfwm settings cleanuptree enable|disable ) Enable/Disable Make Clean Before Build
( amcfwm settings forcebuild enable|disable ) Enable/Disable Force Building Firmware Images If No Updates Detected
( amcfwm settings buildcron enable|disable ) Enable/Disable Daily Build Cronjob

( amcfwm settings transferzip enable|disable ) Enable/Disable Transferring Of .zip Files
( amcfwm settings transfertrx enable|disable ) Enable/Disable Transferring Of .trx Files
( amcfwm settings transferw enable|disable ) Enable/Disable Transferring Of .w Files
( amcfwm settings transfertxt enable|disable ) Enable/Disable Transferring Of .txt Files

( amcfwm settings bac68 enable|disable ) Enable/Disable Building Of AC68U Image
( amcfwm settings bac88 enable|disable ) Enable/Disable Building Of AC88U Image
( amcfwm settings bac3100 enable|disable ) Enable/Disable Building Of AC3100 Image
( amcfwm settings bac5300 enable|disable ) Enable/Disable Building Of AC5300 Image
( amcfwm settings bac86 enable|disable ) Enable/Disable Building Of AC86U Image
( amcfwm settings bax88 enable|disable ) Enable/Disable Building Of AX88U Image
( amcfwm settings bax58 enable|disable ) Enable/Disable Building Of AX58U Image
( amcfwm settings bax56 enable|disable ) Enable/Disable Building Of AX56U Image
( amcfwm settings bax86 enable|disable ) Enable/Disable Building Of AX86U Image
( amcfwm settings bgtac2900 enable|disable ) Enable/Disable Building Of GT-AC2900 Image
( amcfwm settings bgtax11000 enable|disable ) Enable/Disable Building Of GT-AX11000 Image
( amcfwm settings bax68 enable|disable ) Enable/Disable Building Of AX68U Image
( amcfwm settings bgtaxe11000 enable|disable ) Enable/Disable Building Of GT-AXE11000 Image
( amcfwm settings bac68v4 enable|disable ) Enable/Disable Building Of AC68U_V4 Image
( amcfwm settings bgtax6000 enable|disable ) Enable/Disable Building Of GT-AX6000 Image
( amcfwm settings bxt12 enable|disable ) Enable/Disable Building Of XT12 Image
( amcfwm settings bgtaxe11000 enable|disable ) Enable/Disable Building Of GT-AXE11000 Image
( amcfwm settings bgtax11000pro enable|disable ) Enable/Disable Building Of GT-AX11000_PRO Image
( amcfwm settings bax86pro enable|disable ) Enable/Disable Building Of AX86U_PRO Image

( amcfwm settings webhookurl www.google.com/webhookurl ) Enable/Disable Webhook Notifications

( amcfwm settings reset ) Reset All Settings To Default

( amcfwm cleanup ) Remove Inactive Build Directories

( amcfwm update ) Standard Update Check - If Nothing Detected Exit
( amcfwm update check ) Check For Updates Only - Wont Update If Detected
( amcfwm update -f ) Force Update Even If No Changes Detected

( amcfwm uninstall ) Uninstall AMCFWM
```

&nbsp;

&nbsp;

## **Donate**

This script will always be open source and free to use, but if you want to support future development you can do so by [Donating With PayPal.](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=BPN4LTRZKDTML)

&nbsp;

&nbsp;

_Note:_ Support will only be provided for questions relating to this script, not general VM/Linux/Compiling questions. If you are unfamiliar with working in a Linux environment this script probably isn't aimed at you.
