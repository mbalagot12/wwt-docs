# Configuring your Arista Switch and Access Points for Home Use

## Overview

This document provides a guide to configure your Arista switch for home use, including setting up wired and wirelesourss network connectivity and management access.

## Prerequisites

- An Arista switch (e.g., Arista 710P-12P)
- Console cable or SSH access to the switch
- Home network details (IP address, subnet mask, gateway IP, DNS server IP)

## Step 1: Connect to the Switch

1. Connect your computer to the switch using a console cable or SSH.
2. Open a terminal emulator (e.g., PuTTY, Tera Term) and connect to the switch's console port or SSH into the switch.
3. Log in to the switch using the default username and password (arista/arista).

## Step 2: Configure Basic Network Connectivity

1. Enter global configuration mode by typing `configure`.
2. Configure a VLAN for management access using the `vlan` command. For example:
    ```
    vlan 10
    name Management
    ```
3. Configure VLAN 20 and VLAN 30 for guest and IoT networks respectively:
    ```
    vlan 20
    name Guest
    exit
    vlan 30
    name IoT
    exit
    ```
3. Configure the switch's hostname using the `hostname` command. For example:
    ```
    hostname MyAristaSwitch
    ```
4. Configure the switch's IP address, subnet mask, and default gateway using the `interface ethernet5` command. For example:
    ```
    interface ethernet5
    switchport access vlan 10
    ```
5. Assign an IP address to the VLAN interface:
    ```
    interface vlan 10
    ip address 10.10.1.1 255.255.255.0
    exit
    ```
6. Set the default gateway. This is your home router's IP address:
    ```
    ip route 0.0.0.0/0 10.10.1.254
    ```
7. Save the configuration:
    ```
    write
    ```
## Step 3: Configure DHCP Services 

1. Configure DHCP pool for VLAN 10:
    ```
    dhcp server
    dns server ipv4 8.8.8.8
    subnet 10.10.1.0/24
      range 10.10.1.40 10.1.1.250
      lease time 0 days 12 hours 0 minutes
      default-gateway 10.10.1.1
    exit
    ```
2. Enable DHCP pool for VLAN 20:
    ```
    dhcp server
    dns server ipv4 8.8.8.8
    subnet 10.20.1.0/24
      range 10.20.1.40 10.20.1.250
      lease time 0 days 12 hours 0 minutes:
      default-gateway 10.20.1.1
    exit
    ```
3. Enable DHCP pool for VLAN 30:
    ```
    dhcp server
    dns server ipv4 8.8.8.8
    subnet 10.30.1.0/24
      range 10.30.1.40 10.30.1.250
      lease time 0 days 12 hours 0 minutes:
      default-gateway 10.30.1.1
    exit
    ```
4. Save the configuration:
    ```
    write
    ```

## Step 4: Configure your access points

1. Connect your access points to the switch interface ethernet 7 or ethernet 9.
2. Configure interface ethernet 7 or ethernet 9 as a trunk port to allow multiple VLANs:
    ```
    interface ethernet7
    switchport mode trunk
    switchport trunk allowed vlan add 10,20,30
    exit
    ```
3. Save the configuration:
    ```
    write
    ```

## Step 5: Login to CV-CUE Launchpad

1. Login to the [Arista Launchpad](https://launchpad.wifi.arista.com/){target="_blank"} for your lab.
2. Click on the `CV-CUE (CloudVision WiFi)` Tile in the LaunchPad from the Dashboard menu.
3. Click on `Configure > WiFi` and click on `Add SSID`
4. Configure your SSID and security settings. Configure the SSID to use the appropriate VLAN (e.g., VLAN 10 for management, VLAN 20 for guest, VLAN 30 for IoT).
5. Click on `Save` to apply the changes.
