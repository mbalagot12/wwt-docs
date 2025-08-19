# C-04 | Best in Class WIPS

## Overview

## WIPS Wireless Intrusion Prevention System

Arista Wireless Intrusion Prevention System (WIPS) leverages RF broadcast and protocol properties including packet formats like probe requests and beacons common to all 802.11 standards(including 802.11ac and 802.11ax) to detect and prevent unauthorized access.

!!! info "More Information"

    For more information about how Arista’s WIPS feature works, refer to this whitepaper: https://www.arista.com/assets/data/pdf/Whitepapers/Arista-Marker-Packet-Whitepaper.pdf

Wi-Fi threats include an ever changing landscape of vulnerabilities, such as:

- :octicons-x-circle-fill-12: Rogue APs
- :octicons-x-circle-fill-12: Unauthorized BYOD Client
- :octicons-x-circle-fill-12: Misconfigured APs
- :octicons-x-circle-fill-12: Client misassociation
- :octicons-x-circle-fill-12: Unauthorized association
- :octicons-x-circle-fill-12: Ad-hoc connections
- :octicons-x-circle-fill-12: Honeypot AP or evil twin “Pineapple”
- :octicons-x-circle-fill-12: AP MAC spoofing
- :octicons-x-circle-fill-12: DoS attack
- :octicons-x-circle-fill-12: Bridging client

### Configure WIPS

Let's go ahead and configure WIPS on our Access Point

1. In the menu on the left hand side of the screen, navigate to `Monitor > WIPS`
2. Click on `Access Points` and `Clients` in the menu at the top of the screen and explore if any Rogue APs or Clients are connected to other APs in the area.
3. Access points that have been detected by WIPS but are not managed within Arista CV-CUE, they are designated as Rogue or External Access Points.
4. Next, let’s explore the information we can gather about the wireless environment using Arista’s WIPS.
5. Select `Monitor > WIPS`
6. In the simple lab environment, only your pod’s single AP is part of your managed wireless infrastructure. All of the other access points and clients on the network are like crowded neighbors or businesses in a shared office work space.
7. Under Monitor, WIPS, Access Points you can see all of the detected Rogue Access points. From this screen you can reclassify, set auto-prevention, add to ban list, name or move the AP.

    !!! info "Additional Information"

        Additional information about WIPS AP classification and [Wireless Intrusion Prevention Techniques](https://www.arista.com/en/ug-cv-cue/cv-cue-wireless-intrusion-prevention-techniques)

<div class="grid cards" markdown>

- :material-access-point:{ .lg .middle } **Authorized APs**

    ---

    Access Points (APs) that are wired to the corporate network and are compliant with the Authorized Wireless LAN (WLAN) configuration defined by the Administrator in CV-CUE are classified as Authorized APs. Typically, these will be Arista APs, but the administrator can configure the Authorized WiFi policies for any AP vendors.

</div>

<div class="grid cards" markdown>

- :material-access-point-network-off:{ .lg .middle } **Rogue Access Point**

    ---

    APs that are wired to the corporate network and do not follow the Authorized WiFi configuration defined in CV-CUE are classified as Rogue APs.

    Even if this AP is disconnected from the network, it will continue to be classified as a Rogue. These APs are a potential threat to the corporate environment and can be used for intrusion into the corporate network over Wi-Fi. It is recommended to enable Intrusion Prevention for Rogue APs so that Wi-Fi communication with these APs is always disrupted. Using the Location Tracking ability of Arista WIPS, Rogue APs should be tracked down and physically removed from the network.
    Rogue APs are displayed in Red rows on the console.

</div>

<div class="grid cards" markdown>

- :material-access-point-minus:{ .lg .middle } **External Access Point**

    ---

    APs that are not wired to your corporate network are classified as External APs.
    Through the connectivity tests performed by the WIPS Sensors, Wireless Manager is able to determine that these APs are not connected to the wired network. These are neighboring APs that share the same spectrum as the Authorized APs and may cause interference with your Authorized WLAN. A site survey and channel optimization should be performed to reduce radio interference from the External APs. These APs are not always a threat and hence they should not be quarantined/prevented by default, as it would disrupt neighboring Wi-Fi activity. Intrusion Prevention policies can be configured to prevent Authorized clients from connecting to External APs.

    A Rogue Access point can be reclassified, moved or named from the 3-dots menu for each detected AP.

    Within an existing campus WiFi environment or one with a mix of wireless solutions, these discovered APs can be explicitly allowed to show the most accurate security profile.

    For this lab you do not need to authorize any APs.

</div>

### Classify and Prevent Individual client

Next, let’s use the WIPS system to identify and prevent an example problematic client from connecting to your network.

1. Navigate to `WIPS > Clients`
2. Find your smartphone device connected to the previous PSK SSID. Reconnect if it has been disconnected.
3. Since this client is associated with the correct PSK for the SSID, it is automatically classified as `Authorized`.
4. Next, click the 3-dots menu for the device, `Change Classification`, `Rogue`
5. Now, sort the clients menu by Classification column (left) and find the red marked Rogue device.
6. Next, Select the 3-dots menu for the Rogue client and click “Prevent This Device”
7. Click Prevent to start the WIPS prevention mechanism to disrupt the selected client from sending and receiving traffic.
8. Try to connect to a public website with your test client device with the prevention setting enabled versus disabled (be sure to disable backup wireless/LTE radios).
9. The test device should fail to connect to other devices through the protected WiFi network when prevention is active.
10. When you are finished, STOP the client prevention

    !!! danger "STOP Client Protection"
        🛑 When you are finished, **STOP** the client prevention so that you can use this test device in upcoming labs, optionally. 🛑

--8<-- "includes/abbreviations.md"
