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

Linux, however, says screw all that. You have absolute and complete control over everything you want to control. That does mean that you can just kinda...break it, but that's worth it; anything you could break you have to do pretty intentionally. The downside is that to get that level of control, you have to learn no just the [command line](#command-line-crash-course) but also how operating systems and processes work in general. It's worth it, I promise. You're learning not only a new skill but a whole swath of new terms and ways of thinking about things. It will come, and this is a very, very verbose guide, so you should have a good basis.

For this project, we're use Linux because it's free and pretty light in terms of space and performance; it can run on less powerful hardware, which makes it perfect for Raspberry Pis (and older computers).
## Configuring the Pi
Starting this step I assume that you have a Pi and all its parts, including a microSD running Raspbian (Raspberry Pi OS). 

Make sure the Pi is powered off. Put the SD card into the Pi, connect it to a monitor, keyboard, and mouse, and power it up! You should be greeted by the splash screen and the setup. Go through the setup, but maybe save customizing everything to your liking till after the next section.

Get the Pi on the Wifi or Ethernet, it'll need to access the internet.
### Disabling the GUI (recommended)
> [!NOTE]
> If you're not confident/willing to put in a little brain power to learning command-line editors such as Vim or Nano skip this step!

Running a Graphical User Interface (GUI)--the desktop and visual programs as opposed to pure command line--isn't very taxing for a Pi, but the more processing power we can free up the better. If you choose to skip it, edit files in whatever text editor you like. My Pi shipped with 3 separate ones of varying degrees of complexity.

If you choose to disable the GUI, select "boot into command line", rather than "boot into GUI". This is known as booting "headless". You can always re-enable this if you end up using the Pi for something else by running `sudo raspi-config`.
## Command Line crash course
You're gonna have to know some things about the command line in order to stay sane. 

If you're setting up a server, you've probably messed around with Minecraft commands, such as `/tp`. When you open the chat and type, you're interacting with the server on a command line, not graphically. In this case, non-graphical means that there's no cursor or windows to navigate. 

When running headless Linux, you interact with every* system by typing commands in. The `/tp` command can take "arguments", or targets. `/tp Alice Bob` will teleport target Alice to target Bob. Linux commands sometimes also have arguments. And, like in Minecraft, if you type in a target that doesn't exist, the command will throw an error. If no error is thrown, generally nothing will print. This is good! No output is good output.

In Linux, commands are frequently shortened to representative letters; just like `/tp` for `t`ele`p`ort, Linux has `cp` for `c`o`p`y. Notice that Linux commands do not have a `/` before them. That's because in Minecraft, you can either send text in chat or type commands, so you need a way to distinguish between the two. In Linux, you just type commands.

Let's say you're in a directory[^1] with one text file: `Alice.txt`. If you want to make a copy of `Alice.txt` and store it in `Alice_backup.txt`, you would type `cp Alice.txt Alice_backup.txt`.
[^1]:In Linux, the things we know as folders are referred to as directories. Much like a building directory, a folder is really just a list of files.
### Worked example
Now that you've seen how it flows, let's do a worked example. We're going to make a directory titled `minecraft_servers`, navigate into it, create `DEFAULT_README.txt` file and add some text to it. Then, we'll create a `purpur_defaults` directory, copy the `DEFAULT_README.txt` into it and rename it `README_PURPUR_DEFAULTS.txt` before editing it again. I'll go line by line and explain, then show the entire block at the end.

Note that my command prompt renders here as `quiz@raspberry-pi:~ $ `. The commands are the text after the `$`. Yours may include the current path, something like: `(user)@(machine):~/your/current/path$`. Neither will impact functionality.
<details>
 <Summary>Line by line example</Summary>

 ```
quiz@raspberry-pi:~ $ mkdir minecraft_servers
```
Make a directory in the current directory and title it `minecraft_servers`

```
quiz@raspberry-pi:~ $ cd minecraft_servers/
```
Change to the `minecraft_servers` directory. In this case, the final `/` is optional. It appeared because I actually typed `cd mine<Tab>`, which autocompletes.

```
quiz@raspberry-pi:~ $ ls
```
List all the files in this directory. There's no output because it's empty! We just made it.

```
quiz@raspberry-pi:~ $ touch DEFAULT_README.txt
```
Create the `DEFAULT_README.txt` file. No output is good output, so we assume the file is created succesfully.

```
quiz@raspberry-pi:~ $ ls
DEFAULT_README.txt
```
List all the files in this directory. The output shows that there's just one file, as expected.

```
quiz@raspberry-pi:~ $ vim DEFAULT_README.txt
```
This launches into the Vim editor, which has a learning curve the size and shape of a brick wall. [My attempt at a tutorial](#vim-crash-course). Your favourite online resource probably has a tutorial.

For now, just hit `<i>` and then type this: `This is a [version] server running: [plugins].` Then hit <Ctrl+C>` before typing: `:wq`. Hit `<Enter>` to save and quit.

This enters `i`nsert mode which lets you type text as normal. You then exit insert mode with `<Ctrl+C>`. Now in `Normal` mode, you send Vim a command with `:`. The command is `w`rite and `q`uit, using `<Enter>` to send.

```
quiz@raspberry-pi:~ $ mkdir purpur_defaults
```
Make a directory in the current directory and title it `purpur_defaults`

```
quiz@raspberry-pi:~ $ cp DEFAULT_README.txt purpur_defaults/
```
Copy the `DEFAULT_README.txt` from this directory and place it in `purpur_defaults`. When the destination filename is unspecified, it will use the source filename. 

You could also replace the second argument `purpur_defaults/` with `purpur_defaults/README_PURPUR_DEFAULTS.txt` which would copy `DEFAULT_README.txt` and store it in `purpur_defaults/` with the name `README_PURPUR_DEFAULTS.txt`. Doing so would remove the need for the `mv` command that happens next.

```
quiz@raspberry-pi:~ $ cd purpur_defaults/
```
Change to the `purpur_defaults` directory. This is technically optional; all commands can operate on files that are in other directories, it's just more typing. 

Eg: `cp minecraft_servers/DEFAULT_README.txt minecraft_servers/purpur_defaults/` vs the cp command above.

```
quiz@raspberry-pi:~ $ mv DEFAULT_README.txt README_PURPUR_DEFAULTS.txt
```
Move `DEFAULT_README.txt` to the file `README_PURPUR_DEFAULTS.txt`, effectively renaming it.

```
quiz@raspberry-pi:~ $ vim README_PURPUR_DEFAULTS.txt
```
Edit the new README with Vim. Press `<i>` to enter `i`nsert mode. Edit the text to say: `This is a Purpur server running full defaults. Do not edit this directory!`. Exit `i`nsert mode (`<Ctrl+C>`) then save and exit (`:wq<Enter>`).

```
quiz@raspberry-pi:~ $ cat README_PURPUR_DEFAULTS.txt
This is a Purpur server running full defaults. Do not edit this directory!
```
This prints the contents of `README_PURPUR_DEFAULTS.txt` to the console. Just a verification that our changes saved.

```
quiz@raspberry-pi:~ $ cd ..
```
Change directory up to the parent folder, which is `minecraft_servers`.

```
quiz@raspberry-pi:~ $ ls
DEFAULT_README.txt  purpur_defaults
```
List the contents of the current directory. You can see the first README we created, as well as the `purpur_defaults` directory. They should be colour-coded, for me blue is a directory and no color is a file.

```
quiz@raspberry-pi:~ $ ls purpur_defaults/
README_PURPUR_DEFAULTS.txt
```
List the contents of the `purpur_defaults/` directory. You can see the second README.


&nbsp;

With that, you've done it! You've survived your first journey into the Linux command line. Take a break and have some water, it can only get easier.
</details>
<details>
<Summary>Full command block</Summary>
 
```
quiz@raspberry-pi:~ $ mkdir minecraft_servers
quiz@raspberry-pi:~ $ cd minecraft_servers/
quiz@raspberry-pi:~ $ ls
quiz@raspberry-pi:~ $ touch DEFAULT_README.txt
quiz@raspberry-pi:~ $ ls
DEFAULT_README.txt
quiz@raspberry-pi:~ $ vim DEFAULT_README.txt
quiz@raspberry-pi:~ $ mkdir purpur_defaults
quiz@raspberry-pi:~ $ cp DEFAULT_README.txt purpur_defaults/
quiz@raspberry-pi:~ $ cd purpur_defaults/
quiz@raspberry-pi:~ $ mv DEFAULT_README.txt README_PURPUR_DEFAULTS.txt
quiz@raspberry-pi:~ $ vim README_PURPUR_DEFAULTS.txt
quiz@raspberry-pi:~ $ cat README_PURPUR_DEFAULTS.txt
This is a Purpur server running full defaults. Do not edit this directory!
quiz@raspberry-pi:~ $ cd ..
quiz@raspberry-pi:~ $ ls
DEFAULT_README.txt  purpur_defaults
quiz@raspberry-pi:~ $ cd purpur_defaults/
quiz@raspberry-pi:~ $ ls purpur_defaults/
README_PURPUR_DEFAULTS.txt
```

</details>

### Command line quick reference

`.` refers to the current directory. `..` is the directory above the current.

`<Tab>` will auto complete.

All flags are optional.

|Command | Flags | Targets| Usage|
|---|---|---|---|
| `cp` |`-r`ecursive|`SOURCE` `DESTINATION` | Copy file `source` to file `destination`. `-r` will copy directories.|
| `mv` |`-n`o clobber|`SOURCE` `DESTINATION`| Move file `source` to file `destination`.<br>This can also be used to "rename" files.<br>`-n` will prevent you from overwriting an existing file.|
| `ls` |`-a`ll<br>`-l`ong|`[FILE]`| | Lists files in the current directory. |
| `cd` ||`DESTINATION`|Change directory to `destination`.|
|`touch`||`DESTINATION`| Create file `destination`|
|`mkdir`||`DIRECTORY`|Create directory `destination`|
|`cat`||`FILE`|Print the **entire** contents of `destination` to the console.<br>Will con`cat`enate the file contents to the standard output, (which is the console).|
|`less`||`FILE`|Display a paginated version of `destination`'s contents.<br>\`<Space>` will jump a page and \`<q>` will exit.<br>\<Arrow keys> will move line by line.|

## Downloading .jar files and initizalizing the server on your workstation
> [!NOTE] This step assumes you have access to any other computer that isn't the Pi. If that isn't the case, follow these instructions on your Pi.
> I completed them on my Windows workstation.

### First run
Get the [.jar file from Purpur](https://purpurmc.org/docs/purpur/#downloads). I ran the latest supported version, which is 1.20.6. Make a folder called `Minecraft_server` and put the .jar in it. Open the Terminal app or just Command Prompt. `cd` into the `Minecraft_server` directory. `touch start.bat` to create a BATCH (Windows scripting) file. Edit the .bat in notepad and put the following code inside it. **Make sure you change the .jar name.**

```
java -Xms4096M -Xmx4096M -jar SERVER_NAME.jar --nogui
```

This uses `java` to open `SERVER_NAME.jar` with `4096M` of memory allocated (4GB) and with `no-gui`. The first time this .bat is run, it will generate a world and begin running it locally. Afterwards, it'll just start the server without re-generating anything.

Start the server by typing `start.ba<Tab>` and hitting enter. The server will spool up in about 30 seconds.

### Finding a good starting area
Launch Minecraft with the same version and Direct Connect to `localhost`. Run around and see if you like the spawn area. If you don't:
1. Stop the server by typing `/stop` in Minecraft or `stop` into the server console.
2. Delete the `world` folder that was created
3. Re-run the .bat and reconnect

### Pre-generating the world with Chunky
Once you've found a starting area you like, complete the following steps (copied verbatim from [that server optimization guide from earlier](https://github.com/YouHaveTrouble/minecraft-optimization?tab=readme-ov-file#map-pregen)):

------------
Map pregeneration, thanks to various optimizations to chunk generation added over the years is now only useful on servers with terrible, single threaded, or limited CPUs. Though, pregeneration is commonly used to generate chunks for world-map plugins such as Pl3xMap or Dynmap.

If you still want to pregen the world, you can use a plugin such as [Chunky](https://github.com/pop4959/Chunky) to do it. Make sure to set up a world border so your players don't generate new chunks! Note that pregenning can sometimes take hours depending on the radius you set in the pregen plugin. Keep in mind that with Paper and above your tps will not be affected by chunk loading, but the speed of loading chunks can significantly slow down when your server's cpu is overloaded.

It's key to remember that the overworld, nether and the end have separate world borders that need to be set up for each world. The nether dimension is 8x smaller than the overworld (if not modified with a datapack), so if you set the size wrong your players might end up outside of the world border!

**Make sure to set up a vanilla world border (`/worldborder set [diameter]`), as it limits certain functionalities such as lookup range for treasure maps that can cause lag spikes.**

------------

I set up a 1000 block radius with Chunky. That's a good enough size that you can sprint all out for a bit before hitting the border.

### Getting your completed files onto the Pi
Once Chunky is complete, shut down the server.
I SCPed it from my workstation to the Pi, but you can do it however you'd like, WGET or a flashdrive work fine. Make a directory to keep all the Minecraft stuff in. I called mine `mc`.
## Tuning the server
What makes a server perform better is a mystical and arcane formula, known only to Microsoft and [this guy, who wrote a full optimization guide!](https://github.com/YouHaveTrouble/minecraft-optimization).
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
