# C-03 | AGNI and Wired EAP-TLS 802.1X

## Overview

In this lab we enhance the port security to our Raspberry Pi! We will do the following:

- [x] Update our port profile
- [x] Configure our switch to communicate over RadSec to AGNI
- [x] Configure the AGNI EAP-TLS wired policy
- [x] Verify it all works!

--8<--
docs/snippets/topology.md
--8<--

??? tip "Important: Your switches need to be onboarded in AGNI with RadSec before proceeding. Follow the steps here"

    --8<--
    docs/references/radsec_on_eos.md
    --8<--

??? tip "Reminder on logging in and creating a workspace"

    --8<-- "docs/snippets/login_cv.md"

    --8<-- "docs/snippets/workspace.md"

## Update Port Profile

Here we will update our existing raspberry pi port profile to enable 802.1X

!!! danger "Single Workspace"

    You and your fellow student will work together to create the port profile for your campus fabric in a **single workspace**.

1. From the `Studios` home page, disable the `Active Studios` toggle to display all available CloudVision Studios (which when enabled will only show used/active Studios).

    !!! note "The toggle may already be in the disabled position"

      ![Campus Studios](../a_wired/assets/images/a02/01_access_config.png)

2. Let's update the `Wired-RasPi` port profile for our Raspberry Pi and enable 802.1x, click the arrow on the right and enable the following:

    ???+ example "Wired-RasPi"

        | Key                      | Value                                        |
        | ------------------------ | -------------------------------------------- |
        | 802.1X                   | Enabled                                      |
        | MAC Based Authentication | Yes                                          |

3. Our port profiles have been staged, click `Review Workspace`

4. We can see the only studio changed is the `Access Interface Configuration`, we will see the ports assigned are updated.

5. Go ahead and `Submit the Workspace` when you ready

6. Click View `Change Control`

7. Review the Change Control and select `Review and Approve`

8. Toggle the `Execute Immediately` button and select `Approve and Execute`

9. The port is now enabled for 802.1X, let's now get your switch talking back to AGNI.

## Enable RadSec

In this lab you will be configuring RadSec on your lab switches by adding the RadSec configuration to the switches via the Static Configuration Studio.

1. Click on the `Provisioning` menu option, then choose `Studios`.
2. Let's open the `Static Configuration Studio`

   ![Campus Studio](./assets/images/c03/01_radsec.png)

3. Select your respective switch
4. In the `Device Container` window, click on `+ Configlet` followed by `Configlet Library`.

   ![Campus Studio](./assets/images/c03/02_radsec.png)

5. Select the configlet named for your switch, should be `radsec` and click `Assign` to add the configlet to the switch

   ![Campus Studio](./assets/images/c03/03_radsec.png)

6. Click `Review Workspace` to review all the changes proposed to the CloudVision Studio

7. Review the workspace details showing the summary of modified studios, the build status, and the proposed configuration changes for each device. When ready click `Submit Workspace`

    ![Campus Studio](./assets/images/c03/05_radsec.png)

    ??? "What does this configuration do?!"

        Click below on the lines to understand what each line does

        ```yaml
        !
        management security
            ssl profile agni-server #(1)!
                certificate pod00-leaf1a.crt key agni-private.key #(2)!
                trust certificate radsec_ca_certificate.pem #(3)!
        !
        radius-server host radsec.beta.agni.arista.io tls ssl-profile agni-server #(4)!
        !
        aaa group server radius agni-server-group #(5)!
            server radsec.beta.agni.arista.io tls
        !
        aaa authentication dot1x default group agni-server-group
        aaa accounting dot1x default start-stop group agni-server-group
        !
        ```

        1. Create an SSL profile
        2. This is the switch key and certificate, this certificate was generated on EOS, signed by AGNI, and installed in the store.
        3. This is the trusted certificate downloaded from AGNI and installed on the EOS certificate store
        4. This enabled RadSec on the device, configured to using our SSL profile
        5. Create the AAA radius server group, we use this to enforce client authentication via dot1x later on in this lab

8. Click `View Change Control` and review the Change Control, hit `Review and Approve` when ready.

    ![Campus Studio](./assets/images/c03/07_radsec.png)

9. Select `Execute immediately` and click `Approve and Execute`

    ![Campus Studio](./assets/images/c03/08_radsec.png)

10. The change control will execute and apply all the RadSec configuration changes to the device. This will enable RadSec connectivity between the switch and AGNI.

    <!-- !!! tip "Automating Certificates"

        The switch and AGNI certs were generated, signed, and installed using automation before hand. Specifically ansible and leveraging both the switch eAPI and AGNI API. You can read more on how this role works [EOS AGNI Radsec (GitHub)](https://github.com/carl-baillargeon/eos_agni_radsec/tree/main){target="_blank"}

    ![Campus Studio](./assets/images/c03/09_radsec.png)

11. See the [Configuring RadSec](../references/radsec_on_eos.md) in EOS for additional information. -->

--8<--
docs/snippets/login_agni.md
--8<--

## Create Wired EAP-TLS Network and Segment

1. Click on `Access Devices > Devices` to confirm the RadSec connection is up.

    ![Campus Studio](./assets/images/c03/agni/01_agni.png)

2. In this section we will create a Network and Segment in CloudVision AGNI to utilize a certificate based TLS authentication method on a wired connection with a Raspberry Pi.
3. Click on `Networks` and select `+ Add Network`

    ![Campus Studio](./assets/images/c03/agni/02_agni.png)

4. Before configuring the network, see `Access Device Group`, click on the `+` to create a new device group.

    ???+ example "Network Settings"
        | Field                       |  Student 1   |  Student 2   |
        | --------------------------- | :----------: | :----------: |
        | Name                        |   WIRED-A    |   WIRED-A    |
        | Description                 |   WIRED-A    |   WIRED-A    |
        | Available Devices (`+ Add`) | pod##-leaf1  | pod##-leaf1  |

5. Fill in and select the Following fields on the `Add Network` page.

    ???+ example "Network Settings"

        | Field                          |           Student 1           |           Student 2           |
        | ------------------------------ | :---------------------------: | :---------------------------: |
        | Name                           |         ATD-##-WIRED          |         ATD-##-WIRED          |
        | Connection Type                |             Wired             |             Wired             |
        | Access Device Group            |            WIRED-A            |            WIRED-A            |
        | Status                         |            Enabled            |            Enabled            |
        | Authentication type            | Client Certificate (EAP-TLS)  | Client Certificate (EAP-TLS)  |
        | Fallback to mac Authentication |            Enabled            |            Enabled            |
        | MAC Authentication Type        | Allow Registered Clients Only | Allow Registered Clients Only |
        | Onboarding                     |            Enabled            |            Enabled            |
        | Authorized User Groups         |            Arista             |            Arista             |

    ![Campus Studio](./assets/images/c03/agni/03_agni.png)

6. When done, click on `Add Network` at the bottom of the screen.
7. Next, click on `Segments` and then `+ Add Segment`

    ![Campus Studio](./assets/images/c03/agni/04_agni.png)

8. Configure the network segment with the following settings:

    ???+ example "Segment Settings"

        | Field        |                           Student 1                           |                           Student 2                           |
        | ------------ | :-----------------------------------------------------------: | :-----------------------------------------------------------: |
        | Name         |                         ATD-##-WIRED                         |                         ATD-##-WIRED                         |
        | Description  |                         ATD-##-WIRED                         |                         ATD-##-WIRED                         |
        | Condition #1 |                `Network:Name is ATD-##A-WIRED`                |                `Network:Name is ATD-##-WIRED`                |
        | Condition #2 | `Network:Authentication Type is Client Certificate (EAP-TLS)` | `Network:Authentication Type is Client Certificate (EAP-TLS)` |
        | Action #1    |                        `Allow Access`                         |                        `Allow Access`                         |

    ![Campus Studio](./assets/images/c03/agni/06_agni.png)

9. Finally, select `Add Segment` at the bottom of the page.

10. You should now be able to expand and review your segment.

    ![Campus Studio](./assets/images/c03/agni/07_agni.png)

11. Next, click on `Sessions` to see if your ATD Raspberry Pi has a connection via the Wired connection.

    ![Campus Studio](./assets/images/c03/agni/07_agni.png)

    !!! note "Client Certificate"

        The Client Certificate has already been applied to the Raspberry Pi.

## Validate and Verify Wired EAP-TLS Device

### AGNI

1. Once the device is connected you will be able to view the status of the connection and additional session details if you click on the Eye to the right of the device.
2. AGNI will then display more in depth session information regarding the device and connection.

### CloudVision Endpoint Overview

Show Endpoint Overview, search for a device on the students pod, sflow will be enabled, should be able to see more info about authentication, traffic flows, and

### EOS CLI

You can also validate the session on the switch by issuing the following commands in the switch CLI

```yaml
show dot1x host
show dot1x host mac d83a.dd98.6183 detail
```

```yaml hl_lines="4 8 10-12"
pod00-leaf1a#show dot1x host
Port      Supplicant MAC Auth  State                   Fallback               VLAN
--------- -------------- ----- ----------------------- ---------------------- ----
Et2       d83a.dd98.6183 EAPOL SUCCESS                 NONE

pod00-leaf1a#show dot1x host mac d83a.dd98.6183 detail
Operational:
Supplicant MAC: d83a.dd98.6183
User name: aristaatd01@outlook.com
Interface: Ethernet2
Authentication method: EAPOL
Supplicant state: SUCCESS
Fallback applied: NONE
Calling-Station-Id: D8-3A-DD-98-61-83
Reauthentication behaviour: DO-NOT-RE-AUTH
Reauthentication interval: 0 seconds
VLAN ID:
Accounting-Session-Id: 1x00000004
Captive portal:
AAA Server Returned:
Arista-WebAuth:
Class: Rcnlkerh9ci3s72u197e0|C4151a596-baab-444b-a4fd-ad40946d8b5f
Filter-Id:
Framed-IP-Address: 192.168.101.21 sourceArp
NAS-Filter-Rule:
Service-Type: None
Session-Timeout: 86400 seconds
Termination-Action: RADIUS-REQUEST
Tunnel-Private-GroupId:
Arista-PeriodicIdentity:
```

!!! tip "🎉 CONGRATS! You have completed the Security labs! 🎉"

--8<-- "includes/abbreviations.md"
