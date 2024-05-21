# OpenCore sample for ASUS UX501VW

### I didn't make this repository public, so you can just copy paste everything. It's a sample to show what you need to boot and have most devices working. I don't care if you can't dual boot or your house burns down or whatever.
### This repo should also help GL552VW users, as the hardware is almost the same, just with ROG branding.
#### I plan to update this as new versions of kexts get released.

### Specs
**CPU** [6700HQ](https://ark.intel.com/content/www/us/en/ark/products/88967/intel-core-i7-6700hq-processor-6m-cache-up-to-3-50-ghz.html)  
**RAM** Onboard 8GB + 1 slot, mine has an 8GB stick  
**GPU** HD530 / GTX960M (Disabled)  
**AUDIO** ALC668  
**WLAN** Intel 7265  
**TPD** Elan 1000  
**SSD** WD SN770 1TB

### What works
- Boot
- Sleep
- Wake
- Internal & external displays
- Keyboard
- Touchpad
- USB2/3 (Type-C/TB is disabled - no device to map with)
- Audio
- Battery status
- Bluetooth
- Wifi
- FN keys (but keyboard backlight is dead on mine, HW issue)
- Webcam

### Not working
- PCIe card reader, just use an USB thing
- 960M, disabled with a hotpatch
- iMessage, I wouldn't use it anyway
- AirportItlwm with Mikrotik access points - use older itlwm for now

#### Attributions
- https://github.com/acidanthera
- https://dortania.github.io/
- https://github.com/kprinssu/UX501VW-hackintosh
- https://github.com/OpenIntelWireless
- https://github.com/hieplpvip/AsusSMC

Both the latest AirportItlwm and Itlwm is kind of broken, sees all the SSIDs, but doesn't want to connect to anything, router says invalid rsn group cipher. A detailed bug report will be submitted later, until then I'm using an older version of itlwm, I believe it's 2.2.
