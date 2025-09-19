# A-02 | Provisioning a Campus Fabric

## Overview

In this lab you will be onboarding your switch using CloudVision Studios, adding your new campus leaf switch to an existing Campus Fabric.

Your environment has been pre-configured with a sample Campus to assist with these new concepts. Studios is equipped with flexible constructs that give you the ability to describe your campus footprint. These will be common throughout this workshop:

- **Campus Fabrics**: Your campus `Workshop` has been created, this would be equivalent to a site or region.
- **Campus Pod**: Your pod `Home Office` could be a building or MDF
- **Access Pod**: Your access pod `IDF1` could be a floor or IDF

??? example "Show me an example!"

    CloudVision Network Hierarchy gives a better visual representation of how this might look in a real environment.

    ![Network Hierarchy](./assets/images/a01/00_hierarchy.png)

The switch in front of you is in Zero-Touch Provisioning (ZTP) mode as they would come from the factory. We will take this new switch from out of the box to provisioned without the use of CLI or the trusty console cable.

??? tip "Out with the console cable"

    Zero-Touch Provisioning in this lab is performed using a bootstrap script delivered over DHCP option 67. This tells your device where to begin streaming for onboarding, you can read more on the [CloudVision Help Center](https://www.cv-prod-us-central1-b.arista.io/help/articles/ZGV2aWNlcy5kZXZpY2VSZWdpc3RyYXRpb24ub25ib2FyZA==#onboard-devices){target="_blank"}

--8<--
docs/snippets/topology.md
docs/snippets/login_cv.md
docs/snippets/workspace.md
--8<--

## Onboarding Device

## Workshop Lab Access Point and Switch Serial Numbers

{{ read_csv('data/lab_assignment.csv',colalign=("left","center","center","center"), usecols=['Email','CVaaS Orgname','AP#1','AP#2']) }}

1. Navigate to the `Devices` tab on the left and let's look at the `Inventory`. There should be two devices with their `Streaming` status as `Active`. Identify your serial number (`Device ID`) and associated hostname (`Device`). We will use these to choose which switch is `leaf1a` and `leaf1b`

    !!! danger "Single Workspace"

        You and your fellow student will work together to onboard your switch pair in a **single workspace**.

        Your CloudVision is tied to **your pod**, anywhere it says `pod-##` you will replace with your assigned pod number.

    !!! tip "What's that hostname?"

        The ZTP process used here will use the DHCP ip address as a suffix and produce a `sw-X.X.X.X` hostname. This is a good indication a switch is in ZTP.

    ![Campus Fabric Studio](./assets/images/a01/01_device_inventory.png)

2. Navigate to the Network Fabric Studio `Campus Fabric (L2/L3/EVPN)`

    !!! tip "Active Studios"

        If you do not see the studios option below, there is a toggle on the right hand side you can toggle "off" the `Active Studios` to show all.

    ![Campus Fabric Studio](./assets/images/a01/03_studio_campus_fabric.png)

3. Click on the `Add Campus Devices` to launch the workflow

    ![Campus Add Devices](./assets/images/a01/05_add_campus_devices.png)

4. This workflow will take you through onboarding the device, follow the tabs below to complete the onboarding process.

    === "Step 1"

        Select the `Workshop > Home Office > IDF1` and add your assigned device from the `Available Devices`

        ![Campus Add Devices](./assets/images/a01/06_add_device_qa_step1.png)

    === "Step 2"

        In the `Role Assignment` click on the `Hostname` field and name your switch `pod##-leaf1X`. Where ## is your pod number and `X` is either student A or B. Also select the role as `Leaf` and `Continue`

        ![Campus Set Device Hostname and ROle](./assets/images/a01/06_add_device_qa_step2.png)

    === "Step 3"

        Validate your `Inband Management Subnet` and `Inband Management VLAN` match your assigned pod number, this will already be configured for you.

        - **Subnet**: `10.1.#.0/24` where `#` is the pod number
        - **VLAN**: `1##` where `#` is the pod number

        ![Campus Add Management Network](./assets/images/a01/06_add_device_qa_step3.png)

    === "Step 4"

        This is a review of what you have configured to onboard your device, click on `Build Workspace` when you are ready.

        ![Campus Review Changes](./assets/images/a01/06_add_device_qa_step4.png)

    === "Step 5"

        During this step, the Quick Action is adding your devices to the Studios inventory anf generating configuration for your new MLAG pair. If we had selected an EOS image, a task would have been created to upgrade the device during our onboarding.

        ![Campus Review Changes](./assets/images/a01/06_add_device_qa_step5.png)

5. The workflow is completing several steps to onboard the device, click `Review Workspace` to explore

    ![Campus Review Workspace](./assets/images/a01/07_review_workspace.png)

6. We should see the detailed view of what's changing

    ![Campus Add Devices](./assets/images/a01/08_review_detail.png)

7. In the workspace note the top leaf `Summary` box, there are several studios modified:
    1. `Inventory and Topology`: Devices selected are simply added to the Campus inventory
    2. `Campus Fabric (L2/L3/EVPN)`: Devices we're added to their respective Campus Access Pod `IDF1` and will inherit configuration from that part of the campus.

8. Let's leave this for now and navigate back to `Studios` home page and next we add some base configuration.

    !!! tip "You may need to click twice"

        Studios will take you back to where you left off, you may need to click `Studios` on the side bar twice, or select `Studios` near the top left of your screen.

    ![Return to Studios](./assets/images/a01/09_return_studios.png)

## Applying Configuration

1. Click on `Static Configuration`

    ![Campus Static Configuration Studio](./assets/images/a01/10_static_studio.png)

2. Let's add our new devices to this studio using the steps below

    === "Add Devices Step 1"

        Click on the `Add +` and select `Devices`

        ![Campus Add Device](./assets/images/a01/11_add_devices_1.png)

    === "Add Devices Step 2"

        Select your devices you recently added through the workflow

        ![Campus Add Device](./assets/images/a01/11_add_devices_2.png)

3. Now let's add our base configuration to these devices, this will include items like logging, banners, etc. for the lab. Use the steps below

    !!! tip "Device Configuration"

        Here the base device configuration was generated for these devices before hand and include additional configuration for the workshop. This was done using [Arista Validated Designs (AVD)](https://avd.arista.com/5.1/index.html){target="_blank"}

    === "Add Config Step 1"

        Select a device and on the left and click the `+ Configlet` to the right and select `Configlet Library`

        ![Campus Add Config](./assets/images/a01/12_add_config_1.png)

    === "Add Config Step 2 (Leaf1A)"

        Select the correct configuration for the device selected.

        ![Campus Add Config](./assets/images/a01/12_add_config_2.png)

    === "Add Config Step 3"

        Ensure the configuration has applied!

        ![Campus Add Config](./assets/images/a01/12_add_config_3.png)

    === "Add Config Step 4 (Leaf1B)"

        Do the same for the other leaf, selecting the correct configuration file.

        ![Campus Add Config](./assets/images/a01/12_add_config_4.png)

4. Let's now review our workspace and the changes we've made by clicking on `Review Workspace`

    ![Campus Config Review](./assets/images/a01/15_review.png)

5. You can review the configuration changes to the devices

    ??? info "What happens to the ZTP Configuration?!"

        We are replacing the Zero Touch configuration with a combination of base configuration (generated using AVD) and some dynamic configuration using Campus Studios

    ![Campus Final Review](./assets/images/a01/16_workspace_review.png)

6. Click `Submit Workspace` to generate the Change Control

    ![Campus Final Review](./assets/images/a01/17_view_cc.png)

7. Click on `View Change Control` and let's explore executing a change control in the next section.

## Executing a Change Control

1. Within the Change Control, you can review the configurations as we just did in the workspace. This is geared towards encouraging or enforcing review of changes prior to execution.

    ![Campus Final Review](./assets/images/a01/18_change_control.png)

2. When you are ready, you can review `Review and Approve` at the top right, select the `Execute Immediately` toggle, and `Approve and Execute`.

    ??? tip "I approved my own change?!"

        Yes, for this workshop you can approve your own change. In `Settings > General Settings` the toggle for `Non-Author Change Control Review` can be enabled enforce a change control review from a "non-author".

    ![Campus Final Review](./assets/images/a01/19_review_approve.png)

3. Let's explore what is going on during the execution of the change control, while this is happening, feel free to click `Logs` near the top right to watch what's happening.

    === "CC Start"

        So what is the device doing?! There are a number of things that device goes through through a ZTP onboard

        1. The device configuration will be applied to the device
        2. The switch will reboot to bring the device out of ZTP mode (this will take about 10 mins)
        3. We did not upgrade the device, but if we had, software upgrade would then take place and reboot once more.

        ![Campus Final Review](./assets/images/a01/20_task_1.png)

    === "CC Finish"

        Now that change control has finished, you will see a summary of any tasks that failed.

        ![Campus Final Review](./assets/images/a01/20_task_2.png)

    === "CC Device Logs"

        There are a number of logs you can review, the list is long, but great detail about what's going on behind the scenes.

        ![Campus Final Review](./assets/images/a01/20_task_3.png)

4. You can now return the `Devices` tab on the left and see our devices should be streaming with it's new hostname!

    ![Campus Final Review](./assets/images/a01/21_device_review.png)

5. That's it! Your new campus switch went from out of the box ZTP mode to a configured member of the Campus fabric. We're going to explore further changes to this switch in the next lab!

!!! tip "🎉 CONGRATS! You have completed this lab! 🎉"

    [:material-login: LET'S GO TO THE NEXT LAB!](./a03_lab.md){ .md-button .md-button--primary }

--8<-- "includes/abbreviations.md"
