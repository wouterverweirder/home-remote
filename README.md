#Home Remote
This repository contains the sources of my Home Remote setup.

After being fed up with using different IR remotes to control my TV, set top box & home cinema, I decided to build a better solution.

I hooked a couple of IR leds to a raspberry pi. The raspberry pi runs a nodejs app which triggers the LEDs on request. I also added an optocoupler, to turn on/off my set top box.