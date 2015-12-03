#Home Remote
This repository contains the sources of my Home Remote setup.

After being fed up with using different IR remotes to control my TV, set top box & home cinema, I decided to build a better solution.

I hooked a couple of IR leds to a raspberry pi. The raspberry pi runs a nodejs app which triggers the LEDs on request.

##installation

I've installed a regular version of osmc to the raspberry pi. And followed the following steps to get my custom remote up and running:

###nodejs

Open up a terminal (through ssh, or on the device itself), update + upgrade the fresh osmc system and install node:

```bash
$ sudo apt-get update
$ sudo apt-get upgrade
$ sudo apt-get install nodejs
```

Check if the node installation was successful, by trying to retrieve the node version:

```bash
$ node -v
```

If that doesn't work, try the nodejs command:

```bash
$ nodejs -v
```

If you needed to use nodejs instead of node, you'll have to create an alias, by running the ln command:

```bash
$ sudo ln -s /usr/bin/nodejs /usr/bin/node
```

After running `node -v` you should see the version number. Mine was v0.10.29.

###npm

You'll also need npm (node package manager). Installation is as simple as running the following command:

```bash
$ curl -L https://npmjs.org/install.sh | sudo sh
```

After that, npm should work:

```bash
$ npm -v
```

It should print the npm version. Mine was 3.5.0.

###putting the project on the pi

Copy the nodejs folder somewhere in your home directory on the pi. Mine sits in /home/osmc/nodejs

Create a lircd.conf file with your IR remote codes. Check out some examples in the raspberrypi/remotes directory of this repo. Link that lircd.conf file in /etc/lirc/lircd.conf.

###hooking up IR leds

I'm sending out infrared commands using lirc_node. More about that in the section below. You'll need to hook up infrared leds for that to work.

Check which gpio ports are used by lirc. On my system (pi zero using OSMC) it was using GPIO pin 17. I found this pin configuration in the OSMC settings screens.

###lirc / irsend issue?

On my system (pi zero running OSMC) irsend would not work out of the box, because it was using another socket.

Test if irsend works, by listing the available commands:

```bash
$ irsend LIST "tv" ""
```

if that doesn't work, try with including the lirc socket:

```bash
irsend -d /run/lirc/lircd-lirc0 LIST "tv" ""
```

You'll see that including this socket connection is an option of my lirc_node fork, and is used in raspberrypi/nodejs/app.js

###launch at startup

Finally, you'll want to launch the nodejs application at startup. Open up /etc/rc.local as root, and add the following line:

```bash
su osmc -c 'node /home/osmc/nodejs/app.js' < /dev/null &
```

I'm running osmc, on a regular pi, the user will probably by pi.