# Configuring AGNI Tacacs

## Overview

This lab is intended to use the Campus Workshop to showcase how to configure TACACS+ with AGNI. There are many online resources available, this will only include the basics of what's required.

## AGNI Configuration

### Arista Cloud Gateway (AGNI)

Login into AGNI to begin this lab, you will create the Arista Cloud Gateway.

1. Under the `Configuration` section, click on `Access Devices > Cloud Gateways`
2. Add the gateway with the settings below

    ???+ "ACG Settings"

        | Setting             |  Student 1   |
        | ------------------- | :----------: |
        | Name                | `ATD-POD01`  |
        | Location            | `Locations`  |
        | TACACS+ Termination |   Enabled    |
        | Shared Secret Name  |   `Access`   |
        | Value               | `Arista!123` |

3. Be sure to copy the generated `Token` value, this will used in our EOS configuration

    !!! warning "Token Generation"

        The token can only be viewed this one time, if you forget to copy you must regenerate the token.

4. Verify the settings and click `Add Cloud Gateway` when complete
5. That's it, there is now a ACG instance configured for all devices

### ACG Connection (CVP)

Configuring your switches for Tacacs is easy as applying a configlet to all or select devices. We're going to use studios to demonstrate

1. Login to CloudVision
2. Navigate to `Provisioning > Studios`
3. Click on `Create Workspace` and name it whatever you'd like
4. Next, select `Static Configuration`
5. Select only your device and click `+ Configlet > Configlet Library`, select the `tacacs` configuration

    !!! tip "Apply to all devices"

        You could apply the configuration at the container `Workshop`. This container has the device tag `Device: All Devices`, this means all devices would inherit this configuration without the need to go to each device. You could also create your own container and leverage any tag query to target specific subset of devices.
6. Once the configlet is applied, click on `Review Workspace`
7. Validate the configuration is correct and `Submit Workspace`
8. Click on `Change Control` and `Approve and Execute` the change

### ACG Connection (EOS)

Whil we used cloudvision to configure the device, you can also log directly into the switch

1. Login to the switch
2. Cloud Gateway should have been downloaded and installed on the switch. You can verify on EOS by running the following command

    ```yaml
    show extensions:
    show boot-extensions:
    ```

    ```yaml
    POD00-LEAF1A[12:07:37]#show extensions
    Name                                 Version/Release      Status       Extension
    ------------------------------------ -------------------- ------------ ---------
    AristaCloudGateway-1.0.2-1.swix      1.0.2/1              A, I, B      1


    A: available | NA: not available | I: installed | F: forced | B: install at boot
    S: valid signature | NS: invalid signature
    The extensions are stored on internal flash (flash:)

    POD00-LEAF1A[12:07:38]#show boot-extensions
    AristaCloudGateway-1.0.2-1.swix
    ```

3. Let's add the configuration to start the ACG daemon

    ```yaml
    daemon AristCloudGateway
        exec /usr/bin/acg
        option AGNI_API_TOKEN value {{ your_agni_acg_token }}
        no shutdown
    ```

    ```yaml title="Example Output"
    This is an EosSdk application
    Full agent name is 'acg-AristCloudGateway'
    ```

4. You can verify the configuration works as expected

    ```yaml
    trace monitor acg
    ```

    ```yaml title="Example Output"
    POD00-LEAF1A[12:23:54]#trace monitor acg
    --- Monitoring /var/log/agents/acg-AristCloudGateway-30753 ---
    2025/02/04 12:23:58 DEBUG [swix] AGNI_API_TOKEN(md5sum) : 76938f1bb8fc5517c01c106d1febdaf0
    2025/02/04 12:23:58 DEBUG [swix] ENABLE_DEBUG_LOG : false
    2025/02/04 12:23:58 DEBUG [swix] AGNI_ACG_TACACS_PORT : 49
    2025/02/04 12:23:58 DEBUG [swix] AGNI_ACG_ENABLE_DHCP : false
    2025/02/04 12:23:58 DEBUG [swix] AGNI_ACG_VRF : default
    2025/02/04 12:23:58 DEBUG [swix] acg service started
    2025/02/04 12:23:58 DEBUG [swix] acg service started [pid=30809]
    2025/02/04 18:24:03 INFO acg - dhcp module is disabled
    2025/02/04 18:24:03 INFO tacacs - started gateway at 0.0.0.0:49
    2025/02/04 18:24:03 INFO websocket - connected successfully to wss://beta.agni.arista.io/acg/connect
    ```

5. You can look in AGNI under the `Access Devices > Cloud Gateways` and now see the status is green :green_circle:

## TACACS Configuration

### TACACS Profile

1. Configure a Tacacs Profile under `Device Administration > TACACS+ Profiles`
2. Create a new profile with the basic settings

    ???+ "TACACS Profile Settings"

        | Setting                       |          Value          |
        | ----------------------------- | :---------------------: |
        | Name                          |     `network-admin`     |
        | Description                   | `Network Administrator` |
        | Privilege Level               |           15            |
        | Allow Enabled                 |         Enabled         |
        | Action for unmatched commands |         Permit          |

3. Next add a Service Attribute using these settings

    ???+ "TACACS Profile Settings"

        | Setting        |        Value        |
        | -------------- | :-----------------: |
        | Select Service |       `shell`       |
        | Attribute #1   | `priv-lvl` = `15` |

4. Click `Add TACACS+ Profile` when complete

### Access Policy

1. Configure a Access Policy under `Device Administration > Access Policy`
2. Create a new profile with the basic settings

    ???+ "TACACS Profile Settings"

        | Setting                      |   Value   |
        | ---------------------------- | :-------: |
        | Enable Device Administration |  Enabled  |
        | Authorized User Groups       | Employees |
        | Device Login Pass Validity   |    30     |

3. Next, create a policy by selecting `Add Policy`

    ???+ "TACACS Profile Settings"

        | Setting     |              Value              |
        | ----------- | :-----------------------------: |
        | Name        |          network-admin          |
        | Description  |      Network Administrator      |
        | Policy Type |             TACACS+             |
        | Status      |             Enabled             |
        | Condition   |  `User:Group` `is` `Employees`  |
        | Action      | `TACACSProfile` `network-admin` |

4. Click `Add Policy`
5. End of this section

### User Add

Typically this would be populated via an identity management platform, here we will add a static user.

1. User > Users
2. Add User
3. User Groups
4. Add user to Employees
5. Update User Groups

## EOS Tacacs Configuration

1. Use the following configuration

    ```yaml
    tacacs-server policy unknown-mandatory-attribute ignore
    !
    tacacs-server host 0.0.0.0 key Arista!123
    !
    aaa group server tacacs+ agni-tacacs
        server 0.0.0.0
    !
    aaa authentication login default local group agni-tacacs
    aaa authorization exec default local group agni-tacacs
    aaa authorization commands all default local group agni-tacacs
    ```

2.

show users detail
