# OpenCore template for ASUS UX501VW

### I didn't make this repository public, so you can just copy paste everything. It's a guide to show what you need to boot and have most devices working. I don't care if you can't dual boot or your house burns down or whatever.
### This repo should also help GL552VW users, as the hardware almost the same, just with ROG branding.
#### I plan to update this as new versions of kexts get released. If you need help, feel free to @me on [Discord](https://discord.gg/u8V7N5C) or [Reddit](https://www.reddit.com/r/hackintosh/). Same username, no private messages.

### Specs
**CPU** [6700HQ](https://ark.intel.com/content/www/us/en/ark/products/88967/intel-core-i7-6700hq-processor-6m-cache-up-to-3-50-ghz.html)  
**RAM** Onboard 8GB + 1 slot, mine has an 8GB stick  
**GPU** HD530 / GTX960M (Disabled)  
**AUDIO** ALC668  
**WLAN** Intel 7265  
**TPD** Elan 1000  
**SSD** Whatever SATA is in there (NVMe should work)

### What works
- Boot
- Sleep
- Wake
- Internal & external displays
- Keyboard
- Touchpad (not perfect, but more than usable)
- USB2/3 (Type-C/TB is disabled - no device to map with)
- Audio
- Battery status (sometimes it doesn't see it's charging but I don't care)
- Bluetooth
- FN keys (but keyboard backlight is dead on mine, HW issue)

### Not working
- PCIe card reader, just use an USB thing
- 960M, disabled with a hotpatch

#### Attributions
- https://github.com/acidanthera
- https://dortania.github.io/
- https://github.com/kprinssu/UX501VW-hackintosh
- https://github.com/OpenIntelWireless
- https://github.com/hieplpvip/AsusSMC
