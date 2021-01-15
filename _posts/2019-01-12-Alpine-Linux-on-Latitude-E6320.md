---
layout: post
title: Alpine Linux on Latitude E6320
slug: latitude-e6320-b43-driver
excerpt: Getting wireless working on the Latitutde E6320 with Alpine Linux
---

## The issue

If you install Alpine Linux on the E6320 bare metal, you'll need to install the B43 driver to enable networking. You'll need to get the driver from the [non-free repository](https://wiki.alpinelinux.org/wiki/Aports_tree). Attempting to build and install this driver didn't work for me - incorrect version. Installing the incorrect version just didn't let the device show up.

## Solution

You'll need to modify the corresponding APKBUILD to point to a newer version. Changing the following, then building the package again solves the issue.

```diff
--- a/non-free/b43-firmware/APKBUILD
+++ b/non-free/b43-firmware/APKBUILD
@@ -3,5 +3,5 @@
pkgname=b43-firmware
-pkgver=4.150.10.5
+pkgver=5.100.138
pkgrel=1
pkgdesc="Firmware for b43 driver"
url="http://linuxwireless.org/en/users/Drivers/b43#firmware_installation
@@ -17,4 +17,4 @@
build() {
    install -d "$pkgdir"/lib/firmware
    b43-fwcutter -w "$pkgdir"/lib/firmware \
-       "$srcdir"/broadcom-wl-$pkgver/driver/wl_apasta_mimo.o
+       "$srcdir"/broadcom-wl-$pkgver/linux/wl_apasta.o
@@ -22,1 +22,1 @@
-md5sums="0c6ba9687114c6b598e8019e262d9a60  broadcom-wl-4.150.10.5.tar.bz2"
+md5sums="f4e357b09eaf5d8b1f1920cf3493a555  broadcom-wl-5.100.138.tar.bz2"
```
