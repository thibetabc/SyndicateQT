
Debian
====================
This directory contains files used to package walled/walle-qt
for Debian-based Linux systems. If you compile walled/walle-qt yourself, there are some useful files here.

## walle: URI support ##


walle-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install walle-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your walleqt binary to `/usr/bin`
and the `../../share/pixmaps/walle128.png` to `/usr/share/pixmaps`

walle-qt.protocol (KDE)

