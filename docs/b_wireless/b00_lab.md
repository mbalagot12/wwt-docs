# B-00 | Arista Wireless Setup

## Overview

The Arista Wireless AP management plane (CV-CUE) is hosted within Arista’s public cloud presence, worldwide. In order to complete this lab section, a default gateway is pre-configured by event staff to facilitate internet connectivity.

!!! note "Arista Wireless Ports & Protocols"

    For more information on the TCP/UDP ports and protocols involved for management functions, see the links below:

    - [AP Wireless Manager Communication](https://wifihelp.arista.com/post/access-point-wireless-manager-communication){target="_blank"}
    - [TCP/UDP Ports Used by Arista Wireless](https://wifihelp.arista.com/post/tcp-and-udp-ports-used-by-arista-wi-fi-products){target="_blank"}

--8<--
docs/snippets/login_cvcue.md
--8<--

Go to the Arista CloudVision CUE portal via: https://launchpad.wifi.arista.com/{target="_blank"}

## 01 | Launchpad

Launchpad is the portal to access your Arista cloud services including WiFi Management (CV-CUE) and AGNI (Network Access Control). When you open the launcher, you are presented with management applications on the Dashboard menu and access controls with the Admin menu.

Dashboard Applications Summary:

- **CV-CUE (CloudVision WiFI):** Wireless management and monitoring
- **Canvas:** Access portal splash pages, and marketing Campaign management.
- **Guest Manager:** Analyze and report on user activity within your environment.
- **Nano:** Manage your environment from your smartphone
- **Packets:** An online packet capture (.pcap) debug tool allowing you to examine the association and packet information.
- **WiFi Resources:** Includes documentation and over 6 ½ hours of training, also included.
- **WiFi Device Registration:** Process for importing APs onto your account
- **AGNI (Beta):** Arista Guardian for Network Identity (Network Access Control)

### WiFi Device Registration

**In light of time, we have done this for you**. However, we will review how Arista Access Points are onboarded through Launchpad.

!!! tip "These steps have already been done for you!"

    Arista AP serial numbers are automatically assigned to the user’s CV-CUE staging area when purchased. In addition, specific devices can be registered for management using the WiFi Device Registration  function, accessible from Launchpad Dashboard.

Device registration requires both the:

- [x] Serial Number
- [x] Registration Key

This information found on the back of the APs. Additionally, a CSV containing this information can be uploaded for bulk registration operations.

Within the Import Function you can provide individual AP serials and keys or upload a CSV.

## 02 | CV-CUE Access

CloudVision CUE - Cognitive Unified Edge, provides the management plane and monitoring functions for the Arista WiFi solution.

1. You should have clicked on the `CV-CUE (CloudVision WiFi)` Tile in the LaunchPad from the Dashboard menu.

2. When the CV-CUE interface launches, you are presented with an initial dashboard to monitor your wireless environment at a glance, we will revisit these metrics later in the lab. Since this is a new setup the initial dashboard screen will be mostly empty.

3. Use the left menu bar to select monitoring and configuration functions.

4. Take careful note of the Locations Hierarchy indicator throughout the user interface. This indicates which container you are monitoring or configuring.

5. The primary menu navigation functions are the following:

      - **Dashboard**: Alerts, Client Access, Infrastructure health, Application Experience, and WIPS
      - **Monitor**: Monitor and explore Clients, APs, Radios, SSIDs, Application traffic, Tunnels
      - **Configure**: WiFi SSIDs, APs and Radios, Tunnels, RADIUS, and WIPS settings
      - **Troubleshoot**: Client connection test, packet trace, live debug logs, historic logging
      - **Engage**: User insights, Presence, Usage, 3rd party integrations
      - **Floor Plans**: Floor layouts and AP location map view
      - **Reports**: Detailed information for Infrastructure APs/Radios, Client Connectivity and Experience, WIPS detections
      - **System**: Locations Hierarchy, AP Groups, 3rd party server settings, keys and certificates

In addition to the menu bar navigation and Locations Hierarchy, the UI provides a common Search bar, Metric summary, and Help button throughout workflows.

!!! tip "🎉 CONGRATS! You have completed this lab! 🎉"

    [:material-login: LET'S GO TO THE NEXT LAB!](./b01_lab.md){ .md-button .md-button--primary }

--8<-- "includes/abbreviations.md"
