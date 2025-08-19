# A-03 | Access Interface Configuration

## Overview

This lab will guide you through creating port profiles and applying them to interfaces in your network.

--8<--
docs/snippets/topology.md
<!-- docs/snippets/login_cv.md -->
docs/snippets/workspace.md
--8<--

## Creating Port Profiles

!!! danger "Single Workspace"

    You and your fellow student will work together to create port profiles for your campus fabric in a **single workspace**.

1. From the `Studios` home page, disable the `Active Studios` toggle to display all available CloudVision Studios (which when enabled will only show used/active Studios).

    !!! note "The toggle may already be in the disabled position"

      ![Campus Studios](./assets/images/a02/01_access_config.png)

2. Let's create two port profiles using the `Access Interface Configuration` studio that will be used to provision connected hosts.

    1. Launch the `Access Interface Configuration`
    2. Click `+ Add Port Profile`, name it `Wireless-Access-Point`, and click the arrow on the right

       ![Campus Studios](./assets/images/a02/02_port_profile.png)

    3. Enter the following values on this configuration page, you can leave all other configuration items left as default. See the settings are configured in the screenshot below

        ???+ example "Wireless-Access-Point"

            | Key                  | Value                                        |
            | -------------------- | -------------------------------------------- |
            | Description          | `Wireless-Access-Point`                      |
            | Enable               | Yes                                          |
            | Mode                 | Access                                       |
            | VLANS                | `1##` where `##` is your 2 digit pod number* |
            | Portfast             | Edge                                         |
            | POE Reboot Action    | Maintain                                     |
            | POE Link Down Action | Maintain                                     |
            | POE Shutdown Action  | Power-Off                                    |

            **VLAN pod numbers between 01-12 that was assigned to your lab/Pod. Example: `Pod01` is `VLAN101`, `Pod13` is `VLAN113`*

       ![Campus Studios](./assets/images/a02/03_wireless_ap.png)

    4. Once you are done with configuration, navigate back to `Access interface Configuration` near the top of the page, under the `Quick Actions`

       ![Add Access Interface](./assets/images/a02/04_back.png)

3. Let's add another port profile for our Raspberry Pi, click `Add Port Profile`, name it `Wired-RasPi`, and click the arrow on the right

    ???+ example "Wired-RasPi"

        | Key                      | Value                                        |
        | ------------------------ | -------------------------------------------- |
        | Description              | `Wired-RasPi`                                |
        | Enable                   | Yes                                          |
        | Mode                     | Access                                       |
        | VLANS                    | `1##` where `##` is your 2 digit pod number* |
        | Portfast                 | Edge                                         |
        | 802.1X                   | Enabled                                      |
        | MAC Based Authentication | Yes                                          |
        | POE Reboot Action        | Maintain                                     |
        | POE Link Down Action     | Maintain                                     |
        | POE Shutdown Action      | Power-Off                                    |

        **VLAN pod numbers between 01-12 that was assigned to your lab/Pod. Example: `Pod01` is `VLAN101`, `Pod13` is `VLAN113`*

4. Our port profiles have been staged, click `Review Workspace`

5. We can see the only studio changed is the `Access Interface Configuration`, no configuration on the devices has changed.

    ![Review Workspace](./assets/images/a02/05_review.png)

6. Go ahead and `Submit the Workspace` when you ready

    !!! warning "Note that device configuration has NOT changed after submitting this workspace. If you see something different, create a new workspace and try again or reach out to the event staff."

## Assigning Port Profiles

!!! danger "No Workspace"

    Now that you have port profiles, you can each individually configure ports on your assigned switch! No workspace required here 😄

1. We are going to assign our new port profiles to our switch, specifically assign ports for

      1. `Ethernet1`: our access port for the Raspberry Pi
      2. `Ethernet7`: our access port for the Access Point
      3. `Ethernet9`: our access port for the Access Point

2. CloudVision offers a number of places to configure access interfaces, it doesn't matter which one you choose! These workflows exist in multiple places depending on the type of work you are performing (broad updates, troubleshooting, etc)

    <div class="grid cards" markdown>

    - :material-alert-rhombus-outline:{ .lg .middle } **Studios**

        ---

        If you are already in the `Access Interface Configuration` studio, you can click the quick action to launch the quick action

    - :material-alert-rhombus-outline:{ .lg .middle } **Dashboards**

        ---

        You can launch the quick action directly from the Campus Health Dashboard

    - :material-alert-rhombus-outline:{ .lg .middle } **Network Hierarchy**

        ---

        Within this view, you can dig into a specific Campus, Pod, and Access Pod. Clicking on the `Front Panel` view, you can then configure port profiles on the right.

    </div>

    === "Studios"

        ![Campus Dashboard](./assets/images/a02/06_access_config_3.png)

    === "Campus Dashboard"

        ![Campus Dashboard](./assets/images/a02/06_access_config_1.png)

    === "Network Hierarchy"

        ![Campus Dashboard](./assets/images/a02/06_access_config_2.png)

3. We're going to use the `Campus Dashboard` option, so click on `Dashboards` on the left side navigation. Locate the `Quick Actions` panel on the lower left of the screen and Click `Access Interface Configuration`

    ![Campus Dashboard](./assets/images/a02/06_access_config_1.png)

4. Select the necessary locations to drill down to your `IDF1`:

      1. Campus: `Workshop`
      2. Campus Pod: `Home Office`
      3. Access Pod: `IDF1`

    ![Campus Dashboard](./assets/images/a02/07_access_ports.png)

5. Let's configure our Access Point port, make sure you identify your assigned switch `pod<##>-leaf1(a|b)`

    !!! warning "Student Device"

        Make sure to select your device, see the tabs below!

        **NOTE**: You will see a slightly different front panel layout, this is the difference between the 710P-12P and the 710P-16P you have in front of you.

    === "Student 1"

         1. Click on port `Ethernet7` on your assigned switch
         2. Choose the `Port Profile` of `Wireless-Access-Point`
         3. Click `Yes` radio button under `Enabled`
         4. Repeat steps 1-3 for port `Ethernet9`
         5. Click `Review`

         ![Campus Dashboard](./assets/images/a02/08_assign_port_1.png)

    === "Student 2"

         1. Click on port `Ethernet7` on your assigned switch
         2. Choose the `Port Profile` of `Wireless-Access-Point`
         3. Click `Yes` radio button under `Enabled`
         4. Repeat steps 1-3 for port `Ethernet9`
         5. Click `Review`

         ![Campus Dashboard](./assets/images/a02/08_assign_port_2.png)

6. You can review the configuration before pushing, but all in the same workflow. Hit `Confirm` to push the access port config when ready!

    ![Campus Dashboard](./assets/images/a02/08_assign_port_3.png)

7. Once the `Change Control` has been executed, click `Configure Additional Inputs` to configure another access port

    ![Campus Dashboard](./assets/images/a02/09_add_inputs.png)

8. Let's now configure our Raspberry Pi port, make sure you identify your assigned switch `pod<##>-leaf1(a|b)`

    !!! warning "Student Device"

        Make sure to select your device, see the tabs below!

        **NOTE**: You will see a slightly different front panel layout, this is the difference between the 710P-12P and the 710P-16P you have in front of you.

    === "Student 1"

         1. Click on port `Ethernet1` on your assigned switch
         2. Choose the `Port Profile` of `Wired-RasPI`
         3. Click `Yes` radio button under `Enabled`

         ![Campus Dashboard](./assets/images/a02/08_assign_port_1.png)

    === "Student 2"

         4. Click on port `Ethernet1` on your assigned switch
         5. Choose the `Port Profile` of `Wired-RasPI`
         6. Click `Yes` radio button under `Enabled`

         ![Campus Dashboard](./assets/images/a02/08_assign_port_2.png)

9. This time Click `Submit`

10. This has pushed the configuration without review! This streamlined the process for low risk changes like access port changes. Once `Change Control` has been executed, click `Finish`

    ![Campus Dashboard](./assets/images/a02/10_finish.png)

11. Quick actions is using the same CloudVision Change Control workflow, the exception here is it's auto approved to allow low risk/impact changes easier. You can view this change control in the `Change Control` tab and see the generated task.

    ![Campus Dashboard](./assets/images/a02/11_review_cc.png)

## Adding a VLAN

Adding a VLAN is a common provisioning task. Let’s use the existing Campus Fabric Studio to add an incremental configuration (add a VLAN). This VLAN will be specific to your pod and not routable outside.

!!! danger "Single Workspace"

    You and your fellow student will work together to create a new VLAN in your campus fabric using a **single workspace**.

1. Once the workspace is created, open the existing `Campus Fabric (L2/L3/EVPN)` studio.

    ![Campus Studio](./assets/images/a03/vlan/01_vlan.png)

    1. Validate that the `Device Selection` still applies to `All Devices`

    2. `Within the Campus Services (Non-VXLAN)` navigate to `Campus: Workshop > Campus-Pod: Home Office` using the arrow :material-greater-than: on the right

    === "Workshop"

        ![Campus Studio](./assets/images/a03/vlan/02_vlan.png)

    === "Home Office"

        ![Campus Studio](./assets/images/a03/vlan/03_vlan.png)

2. We are going to add a new VLAN and add to the `Home Office` Campus POD.

    1. Click the `+ Add VLAN` button

    2. Add the `VLAN 2##`, where `##` is your pod number and click the right arrow :material-greater-than:

        ![Campus Studio](./assets/images/a03/vlan/04_vlan.png)

    3. Customize the new VLAN by giving it a `Name`
    4. Add the VLAN to the Access-Pod by clicking `+ Add Pod` and selecting `IDF1`

        ![Campus Studio](./assets/images/a03/vlan/05_vlan.png)

    5. Let's click `Review Workspace` to submit the staged changes.

3. Review and Submit Workspace

    1. Notice that the Studio is adding the VLAN to the two devices within the Pod.

        !!! tip "Pruning VLANS"

            Outside of this lab topology, when you add vlans to a Layer 2 leaf like this, Studios will generate the necessary configuration to trunk the new VLAN to the spines or upstream MLAG pair when using LSS.

        ??? warning "No changes?!"

            If you are not seeing any proposed changes, make sure you selected an `Access-Pod` within the VLAN configuration. (See step 2e)

    2. Once you review the changes, click `Submit Workspace`

        ![Campus Studio](./assets/images/a03/vlan/06_vlan.png)

    3. Click View `Change Control`

        ![Campus Studio](./assets/images/a03/vlan/07_vlan.png)

    4. Review the Change Control and select `Review and Approve`

        ![Campus Studio](./assets/images/a03/vlan/08_vlan.png)

    5. Toggle the `Execute Immediately` button and select `Approve and Execute`

        ![Campus Studio](./assets/images/a03/vlan/09_vlan.png)

4. Verify the VLAN has been added to the device configuration by using the Device `Comparison` function.

    1. Click `Devices`, the click on `Comparison`, and select a `Time Comparison`

        ![Campus Studio](./assets/images/a03/vlan/10_vlan.png)

    2. Choose a device from the list, such as `leaf1a`

    3. Select a time period, for example `30 minutes ago` and click the `Compare` button

        ![Campus Studio](./assets/images/a03/vlan/11_vlan.png)

    4. The first screen presented shows the overview, navigate to the `Configuration` tab on the left

        ![Campus Studio](./assets/images/a03/vlan/12_vlan.png)

    5. Select the Configuration section

        !!! tip "Timeseries in CloudVision"

            We expect the configuration changed within the last 30 minutes, but all streaming data from the switch (including configuration) is stored in a timeseries database. So anything from routing table, MAC, ARP, and more is accessible for historical review and comparisons like this!

        ![Campus Studio](./assets/images/a03/vlan/13_vlan.png)

5. Lab section completed! In the next lab section you will see how to roll back a previous change control

## Rollback a Change Control

There is no question at some point in  your career, there has been a situation you've been asked to roll back a configuration change and restore back to previous state. You may need to do this for all devices affected by a change, or only a subset of devices under troubleshooting.

CloudVision Change Controls are built with this flexibility in mind, granular change management per device or fleet-wide. Specifically targeting actions or tasks that have taken place can be identified and rolled back when needed.

1. Let’s roll back the change control we used to add a VLAN via Studios.

2. First go to `Provisioning` then `Change Control`. Select the change control corresponding to your VLAN addition

    ![Campus Studio](./assets/images/a03/cc/01_cc.png)

3. Click the `Rollback` button

    ![Campus Studio](./assets/images/a03/cc/02_cc.png)

4. In the next screen, select the top list check mark to select all the devices and click `Create Rollback Change Control`

    ![Campus Studio](./assets/images/a03/cc/03_cc.png)

5. Verify the Configuration Changes section by clicking `Diff Summary`  Once you have reviewed the change, click the `Review and Approve` button

    ![Campus Studio](./assets/images/a03/cc/04_cc.png)

6. Again, you'll be presented with one more opportunity to review the changes. Select `Execute Immediately` if not already toggled on and `Approve and Execute`

    ![Campus Studio](./assets/images/a03/cc/05_cc.png)

7. Monitor the change control for completion to ensure the added VLAN is cleaned up on all switches.

    === "Start"

        ![Campus Studio](./assets/images/a03/cc/06_cc.png)

    === "Finish"

        ![Campus Studio](./assets/images/a03/cc/07_cc.png)

8. You have now successfully added a VLAN through Studios and then rolled back that change across all switches.

!!! tip "🎉 CONGRATS! You have completed this lab! 🎉"

    [:material-login: LET'S GO TO THE NEXT LAB!](./a04_lab.md){ .md-button .md-button--primary }

--8<-- "includes/abbreviations.md"
