# vlc-htsp-plugin

This fork is based on https://github.com/BtbN/vlc-htsp-plugin. The plugin
offers a full-functional "Tvheadend HTSP" overview, located in the section
of network sources.

## Compatibility

At the moment, the plugin is only compatible with Linux systems. Enabling
compatibility with other OSes is planned.

## Installation

### Linux

Prebuilt binaries are not yet available. At the time being, you need a somewhat
up-to-date `g++` compiler, GNU make and (surprise) root privileges.

Just run the following commands:
* `make`
* `sudo make install`

## Configuration

Open the advanced settings, search for "htsp" and enter your connection
credentials. After that, VLC should be able to show you an overview of
the channels your HTSP server exposes.

## I want my feet back!

Please do not get frustrated if anything goes wrong:

* "`make` fails"
* "VLC crashed"
* documentation is unclear
* ...

In this case, feel free to create an issue or pull request.
