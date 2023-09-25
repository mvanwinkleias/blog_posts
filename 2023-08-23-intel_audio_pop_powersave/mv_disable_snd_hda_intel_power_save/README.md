# mv_disable_snd_hda_intel_power_save

Disables snd_hda_intel power_save

## License

copyright (C) 2017 Author, Institution

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

See 

* http://www.gnu.org/licenses/

## Description

There are a couple of web sites that describe the issue:  Intel sound cards
might have power disabled to them in order to save power.  But, that means
that every time they reactivate you hear a "pop" sound.

So, a solution is to install a configuration file to disable the power
saving feature.

* https://major.io/p/stop-audio-pops-on-intel-hd-audio/

```
# echo 0 > /sys/module/snd_hda_intel/parameters/power_save
```

> This setting will last until you reboot. You can make it permanent by adding this text to /etc/modprobe.d/audio_disable_powersave.conf:
> ```options snd_hda_intel power_save=0```
> If you’re a laptop user and you want power savings but fewer pops, you could increase the delay to a more acceptable number. For example, setting it to 60 would mean
> that the card will power down after 60 seconds of silence. 

# Supplemental Documentation

Supplemental documentation for this project can be found here:

* [Supplemental Documentation](./doc/index.md)

# Installation

Ideally stuff should run if you clone the git repo, and install the deps specified
in either "DEBIAN/control" or "RPM/specfile.spec"

Optionally, you can build a package which will install the binaries in

* /opt/IAS/bin/mv-disable-snd-hda-intel-power-save/

# Building a Package

## Requirements

### All Systems

* fakeroot

### Debian

* build-essential

### RHEL based systems

* rpm-build

## Export a specific tag (or just the project directory)

## Supported Systems

### Debian packages

```
  fakeroot make package-deb
```

### RHEL Based Systems

```
fakeroot make package-rpm
```

