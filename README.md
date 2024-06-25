# raspberry-craft
A guide and starting files for running a Minecraft server on a Raspberry Pi 5 using [Purpur](https://purpurmc.org/docs/purpur/), [`GNU Screen`](https://www.gnu.org/software/screen/)* and some scripts. At the end of this guide, you should have a Raspberry Pi that will launch a GNU Screen session on reboot. That Screen session will display the server output, current RAM/CPU usage and a blank terminal. You will then be able to remotely access the Screen session using SSH from any other computer on the network. 

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
    * Ethernet cable (highly recommended)
* Some basic knowledge of: (recommended, but this is a good way to learn!)
  * Linux command line
  * Vim
* A main computer for remotely accessing the Pi (completely optional, but you will not be able to play Minecraft on the Pi)
### So what's the deal with Linux?
> [!NOTE]
> This section is intended for people who haven't really used Linux or don't really get what it's about. If that's not you, skip this!
> 
> It's probably the most opinionated part of this guide, so please put down your pitchforks.

Linux fits in a weird spot in the OS spectrum. On one hand you have Apple's macOS which aims to deliver every user a perfect experience. As a result, there's relatively limited customization. Windows is a bit more freedom of customization and control at the expense of reliability. I love my Windows box but there's a non-zero chance that something won't work the way it should.

Linux, however, says screw all that. You have absolute and complete control over everything you want to control. That does mean that you can just kinda...break it, but that's worth it; anything you could break you have to do pretty intentionally. The downside is that to get that level of control, you have to learn the [command line](#command-line-crash-course). We use Linux because it's pretty light in terms of space and performance; it can run on less powerful hardware, which makes it perfect for Raspberry Pis (and older computers).
## Configuring the Pi
Starting this step I assume that you have a Pi and all its parts, including a microSD running Raspbian (Raspberry Pi OS). Put the SD card into the Pi, connect it to a monitor, keyboard, and mouse, and power it up! You should be greeted by the splash screen and the setup. Go through the setup, but maybe save customizing everything to your liking till after the next section.

Get the Pi on the Wifi or Ethernet, it'll need to access the internet.
### Disabling the GUI (recommended)
> [!NOTE]
> If you're not confident/willing to put in a little brain power to learning command-line editors such as Vim or Nano skip this step!

Running a Graphical User Interface (GUI)--the desktop and visual programs as opposed to pure command line--isn't very taxing for a Pi, but the more processing power we can free up the better. If you choose to skip it, edit files in whatever text editor you like. My Pi shipped with 3 separate ones of varying degrees of complexity.

If you choose to disable the GUI, select "boot into command line", rather than "boot into GUI". This is known as booting "headless". You can always re-enable this if you end up using the Pi for something else by running `sudo raspi-config`.
## Command Line crash course
You're gonna have to know some things about the command line in order to stay sane. 

If you're setting up a server, you've probably messed around with Minecraft commands, such as `/tp`. When you open the chat and type, you're interacting with the server on a command line, not graphically. In this case, non-graphical means that there's no cursor or windows to navigate. 

When running headless Linux, you interact with every* system by typing commands in. The `/tp` command can take "arguments", or targets. `/tp Alice Bob` will teleport target Alice to target Bob. Linux commands sometimes also have arguments. And, like in Minecraft, if you type in a target that doesn't exist, the command will throw an error.

In Linux, commands are frequently shortened to representative letters; just like `/tp` for `t`ele`p`ort, Linux has `cp` for `c`o`p`y. Notice that Linux commands do not have a `/` before them. That's because in Minecraft, you can either send text in chat or type commands, so you need a way to distinguish between the two. In Linux, you just type commands.

Let's say you're in a directory[^1] with one text file: `Alice.txt`. If you want to make a copy of `Alice.txt` and store it in `Alice_backup.txt`, you would type `cp Alice.txt Alice_backup.txt`.


When you type commands in Linux, you type them after the command prompt. This is formatted as such: `<user_name>@<machine-name>~:`. Mine is `quiz@raspberry-pi~:`. If you were to type `cp EULA.txt EULA-copy.txt` and hit Enter

[^1]:In Linux, the things we know as folders are referred to as directories. Much like a building directory, a folder is really just a list of files.
### Command line quick reference
`.` refers to the current directory. `..` is the directory above the current.
|Command | Flags | Targets| Usage|
|---|---|---|---|
| `cp` ||`[path/to/source] [path/to/destination]` | Copy file `source` to file `destination` |
| `mv` ||`[path/to/source] [path/to/destination]` | Move file `source` to file `destination`.<br>This can also be used to "rename" files. |
| `ls` |`-a`[ll]<br>`-l`[ong]|| | Lists files in the current directory. |
| `cd` ||`[path/to/destination]`|Change directory to `destination`.|
|`touch`||`[path/to/destination]`| Create file `destination`|
|`mkdir`||`[path/to/destination]`|Create directory `destination`|
|`cat`||`[path/to/destination]`|Print the **entire** contents of `destination` to the console.<br>Will con`cat`enate the file contents to the standard output, (which is the console).|

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
