#Home Remote
This repository contains the sources of my Home Remote setup.

After being fed up with using different IR remotes to control my TV, set top box & home cinema, I decided to build a better solution.

I hooked a couple of IR leds to a raspberry pi. The raspberry pi runs a nodejs app which triggers the LEDs on request. I also added an optocoupler, to turn on/off my set top box.



TODO
* add short hardware setup manual
* add short setup manual for Pi and node.js 
   * can be based on: How to setup your Pi and run this at startup: http://weworkweplay.com/play/raspberry-pi-nodejs/
* add short manual on use of the UI
* add infrared receiver + code to simple transfer incoming signals to all outputs (will allow to control hidden devices)

