---
sidebar_position: 1
---


BigBlueButton 2.5 is production ready.  We have tools to make it easy for you, a system administrator, to install BigBlueButton on a dedicated Linux server. This document shows you how to install.

# Before you install

We recommend installing BigBlueButton with a 'clean' and dedicated Ubuntu 20.04 64-bit server with no prior software installed. If you want to upgrade from an earlier version of BigBlueButton like 2.3 or 2.4, we recommend setting up a clean server for BigBlueButton 2.5 on Ubuntu 20.04 and, after setup, [migrate over your existing recordings](/admin/customize.html#transfer-published-recordings-from-another-server).

A 'clean' server does not have any previous web servers installed (such as apache) or web applications (such as plesk or webadmin) that are [binding to port 80/443](/support/faq.html#we-recommend-running-bigbluebutton-on-port-80443). By 'dedicated' we mean that this server won't be used for anything else besides BigBlueButton (and possibly BigBlueButton-related applications such as [Greenlight](/greenlight/gl-install.html)).

## Minimum server requirements

For production, we recommend the following minimum requirements

- Ubuntu 20.04 64-bit OS running Linux kernel 5.x
- Latest version of docker installed
- 16 GB of memory with swap enabled
- 8 CPU cores, with high single-thread performance
- 500 GB of free disk space (or more) for recordings, or 50GB if session recording is disabled on the server.
- TCP ports 80 and 443 are accessible
- UDP ports 16384 - 32768 are accessible
- 250 Mbits/sec bandwidth (symmetrical) or more
- TCP port 80 and 443 are **not** in use by another web server or reverse proxy
- A hostname (such as bbb.example.com) for setup of a SSL certificate
- IPv4 and IPv6 address

If you install BigBlueButton on a virtual machine in the cloud, we recommend you choose an instance type that has dedicated CPU.  These are usually called "compute-intensive" instances.  On Digital Ocean we recommend the c-8 compute intensive instances (or larger). On AWS we recommend c5a.2xlarge (or larger).  On Hetzner we recommend the AX51 servers or CCX32 instances.

If you are setting up BigBlueButton for local development on your workstation, you can relax some of the above requirements as there will only be few users on the server. Starting with the above requirements, you can reduce them as follows

- 4 CPU cores/8 GB of memory
- Installation on a local VM container
- 50G of disk space
- IPv4 address only

Regardless of your environment, the setup steps will include configuring a SSL certificate on the nginx server. Why?  All browsers now require a valid SSL certificate from the web server when a page requests access to the user's webcam or microphone via web real-time communications (WebRTC). If you try to access a BigBlueButton server with an IP address only, the browsers will block BigBlueButton client from accessing your webcam or microhone.

## Pre-installation checks

Got a Ubuntu 20.04 64-bit server ready for installation?  Great! But, before jumping into the installation section below, let's do a few quick configuration checks to make sure your server meets the minimum requirements.

Doing these checks will significantly reduce the chances you'll hit a problem during installation.

First, check that the locale of the server is `en_US.UTF-8`.

```bash
$ cat /etc/default/locale
LANG="en_US.UTF-8"
```

If you don't see `LANG="en_US.UTF-8"`, enter the following commands to set the local to `en_US.UTF-8`.

```bash
$ sudo apt-get install -y language-pack-en
$ sudo update-locale LANG=en_US.UTF-8
```

and then logout and login again to your SSH session -- this will reload the locale configuration for your session. Run the above command `cat /etc/default/locale` again. Verify you see only the single line `LANG="en_US.UTF-8"`.

Note: If you see an additional line `LC_ALL=en_US.UTF-8`, then remove the entry for `LC_ALL` from `/etc/default/locale` and logout and then log back in once more.

Next, do `sudo systemctl show-environment` and ensure you see `LANG=en_US.UTF-8` in the output.

```bash
$ sudo systemctl show-environment
LANG=en_US.UTF-8
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

If you don't see this, do `sudo systemctl set-environment LANG=en_US.UTF-8` and run the above `sudo systemctl show-environment` again and confirm you see `LANG=en_US.UTF-8` in the output.

Next, check that your server has (at least) 16G of memory using the command `free -h`. Here's the output from one of our test servers.

```bash
$ free -h
              total        used        free      shared  buff/cache   available
Mem:            15G        3.1G        1.0G        305M         11G         12G
Swap:            0B          0B          0B
```

Here it shows 15G of memory (that's close enough as the server has 16 gigabytes of memory).

If you see a value for `Mem:` in the `total` column less than 15G, then your server has insufficient memory to run BigBlueButton in production. You need to increase the server's memory to (at least) 16G. (As stated above, if your running this in a development environment, 8G is fine.)

Next, check that the server has Ubuntu is 20.04 as its operating system.

```bash
$  cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=20.04
DISTRIB_CODENAME=focal
DISTRIB_DESCRIPTION="Ubuntu 20.04.4 LTS"
```

Next, check that your server is running the 64-bit version of Ubuntu 20.04.

```bash
$ uname -m
x86_64
```

Next, check that your server supports IPv6.

```bash
$ ip addr | grep inet6
inet6 ::1/128 scope host
...
```

If you do not see the line `inet6 ::1/128 scope host` then after you install BigBlueButton you will need to modify the configuration for FreeSWITCH to [disable support for IPv6](/support/troubleshooting.html#freeswitch-fails-to-bind-to-port-8021).

Next, check that your server is running Linux kernel 5.x.

```bash
$ uname -r
5.4.x-xx-generic
```

Next, check that your server has (at least) 8 CPU cores

```bash
$ grep -c ^processor /proc/cpuinfo
8
```

Sometimes we get asked "Why are you only supporting Ubuntu 20.04 64-bit?". The answer is based on choosing quality over quantity. Long ago we concluded that its better for the project to have solid, well-tested, well-documented installation for a specific version of Linux that works really, really well than to try and support may variants of Linux and have none of them work well.

At the moment, the requirement for docker may preclude running 2.5 within some virtualized environments; however, it ensures libreoffice runs within a restricted sandbox for document conversion.  We are exploring if we can run libreoffice within systemd (such as systemd-nspawn).

# Install

To install BigBlueButton, use [bbb-install-2.5.sh](https://github.com/bigbluebutton/bbb-install/blob/master/bbb-install-2.5.sh) script.
