# Black Hole Zone Generator

> A really simple set of tools to automate the generation of black hole Bind zones for known malicious hosts.

DNS black holing is a simple and effective way of preventing malicious traffic on your network. Usually this is done by
 maintaining a list of entries in your systems `hosts` file but you can easily protect a whole network in a single place
 by offloading the responsibility to a single Bind server.

## Installation

All that's needed is to run the included install script:

```sh
./install.sh
```

## Usage

The blackhole lists are created & updated by running the following:

```sh
./run.sh
```

This repo comes with a predefined set of host sources in `sources.csv`. This could easily be expanded with additional 
 sources to suit your needs.

## Meta

Distributed under the GNU General Public License v3.0 license. See [`LICENSE`](https://github.com/moebrowne/bind-blackhole/blob/develop/LICENCE) for more information.