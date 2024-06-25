# raspberry-craft
A guide and starting files for running a Minecraft server on a Raspberry Pi 5 using [Purpur](https://purpurmc.org/docs/purpur/), [`GNU Screen*`](https://www.gnu.org/software/screen/) and some scripts. At the end of this guide, you should have a Raspberry Pi that will launch a GNU Screen session on reboot. That Screen session will display the server output, current RAM/CPU usage and a blank terminal. You will then be able to remotely access the Screen session using SSH from any other computer on the network. 

\* Technically it's just called Screen, but trying to Google for that is one of Dante's Circles.
## Required materials
* Raspberry Pi 5 (other models may work, but RAM may be a limiting factor). I purchased the [Complete Kit from Vilros for $150](https://vilros.com/products/raspberry-pi-5?variant=40082990399582).
  * Additional hardware for the Pim including:
    * Power supply
    * Case with active cooling
    * Mouse + keyboard with USB A
    * microSD for the Pi's storage
      * A method to program the SD
    * Micro HDMI to [HDMI/DVI/other] cable
* Some basic knowledge of: (recommended, but this is a good way to learn!)
  * Linux command line
  * Vim
* A main computer for remotely accessing the Pi (completely optional, but you will not be able to play Minecraft on the Pi)
## Configuring the Pi
Starting this step I assume that you have a Pi and all its parts, including a microSD running Raspbian (Raspberry Pi OS). Put the SD card into the Pi, connect it to a monitor, keyboard, and mouse, and power it up! You should be greeted by the splash screen and the setup. Go through the setup and select what you'd like for the most part, but make sure to select "boot into command line", rather than "boot into GUI". Running the GUI takes processing power that we won't be using for this project. You can always re-enable this if you end up using the Pi for something else.

Get the Pi on the Wifi or Ethernet, it'll need to access the internet next.
## Command Line crash course
You're gonna have to know some things about the command line in order to stay sane. 
## Downloading .jar files and initizalizing the server
Get the [.jar file from Purpur](https://purpurmc.org/docs/purpur/#downloads). I SCPed it from my workstation to the Pi, but you can do it however you'd like, WGET or a flashdrive work fine. Make a directory to keep all the Minecraft stuff in. I called mine `mc`.
## Tuning the server
## Port fowarding the router
## Optional extras
### Simple startup script
### GNU Screen
#### What is it and why do we want it?
#### Installing GNU Screen
#### GNU Screen crash course
#### Configuring your GNU Screen
### Advanced startup script (now with 100% more Screen!)
### Backups
#### Why?
#### How?
