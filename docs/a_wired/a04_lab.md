# A-04 | Operations, Dashboards, and Events

## Overview

In this lab we will explore some of the features of CloudVision to manage and operate your campus network.

--8<--
docs/login_cv_md
--8<--

## Intro to Network Hierarchy

Campus networks can be rather extensive in size and their reach, including many sites, buildings, and floors where your precious network gear is deployed. The Network Hierarchy view aligns closely with the same way you'll manage your wireless access points in CV-CUE:

1. Click on the `Network Hierarchy` tab on the left

    ![Campus Studio](./assets/images/a03/hierarchy/01_hierarchy.png)

2. Note your `Network` contains the workshop campus, campus pod, and access-pod as you drill down.
3. Click on `Workshop` to view a summary of all the devices deployed under the top level campus `Workshop`
4. Click on `IDF1` and note we now get more detail about the switches and clients connected to those devices in the `Overview` tab.

    ![Campus Studio](./assets/images/a03/hierarchy/02_hierarchy.png)

5. Click on the `Front Panel` tab to view more detail about what's connected, the capabilities of your switches in the stack, and access to quick actions to make changes on the interfaces.

    ![Campus Studio](./assets/images/a03/hierarchy/03_hierarchy.png)

6. Let's now use Network Hierarchy to drill down into a compliance issue.

### Configuration Compliance

The Network Hierarchy view is one of many ways to visualize your campus, namely to drill down to a specific area of the network to configure or troubleshoot an issue.

to showcase compliance panel and 2 devices should flagged (due to rollback above). This will open the compliance dashboard and we can sync the config from there via Change Control.

1. If you're not already on the `Network Hierarchy` page, click the tab on the left.
2. Click the top level `Network` object, and take note of the `Compliance` panel on the right

    ![Campus Studio](./assets/images/a03/hierarchy/04_hierarchy.png)

3. We have 2 devices that are violating the `Configuration` compliance item

4. Click on `Compliance` and you should see the `Compliance Overview` with our 2 devices out of configuration compliance

5. Let's select your device below and click `Sync Config`

    ![Campus Studio](./assets/images/a03/hierarchy/05_hierarchy.png)

6. This will create a `Change Control` with our two devices

    ![Campus Studio](./assets/images/a03/hierarchy/06_hierarchy.png)

7. Click on the `Review and Approve`

    !!! tip "Why is our configuration out of sync?!"

        Recall CloudVision is designed to act as the "Source of Truth" for your configuration. It contains a designed configuration it considers the standard, driven through configuration in Studios. When we added our Vlan in the previous step, we rolled that change back, and now there is a discrepancy.

        This could be a real life scenario where a VLAN was added, rolled back due to an unforeseen issue, and scheduled to be added at a later date. We need that vlan, we are reminded the device is out of compliance, and possibly for a good reason!

8. Click on `Approve and Execute` when you're ready

    ![Campus Studio](./assets/images/a03/hierarchy/07_hierarchy.png)

9. This is pushing the designed configuration back to the device
10. Let's go back to our `Network Hierarchy` or `Devices > Compliance Overview` and we should see are switches are not in compliance again.

    === "Network Hierarchy"

        ![Campus Studio](./assets/images/a03/hierarchy/08_compliance_1.png)

    === "Compliance Overview"

        ![Campus Studio](./assets/images/a03/hierarchy/08_compliance_2.png)

## Dashboards

Dashboards are an important way to visualize commonly requested information, we've already seen the Campus Health Dashboard a few times in previous labs. This lab section shows you how to navigate the built-in dashboards and customize your own.

### Campus Health Overview

1. Open the Dashboards Section and we will see the Campus Health Overview dashboard is set to our home dashboard.

    !!! tip "Dashboard Home Page"

        CloudVision has a couple features that customize a users experience. There is a built in profile for `Campus Monitoring` that can be applied to a user role, this will set the "Campus Health Overview" dashboard as the primary dashboard. A user can also select any built-in or custom dashboard as the home/primary dashboard.

    ![Campus Studio](./assets/images/a03/dashboards/01_dashboards.png)

2. You’ll be presented with a curated selection of common campus related monitoring tools

    ![Campus Studio](./assets/images/a03/dashboards/02_dashboards.png)

3. Feel free to explore the Campus Health dashboard briefly and then navigate back to the Dashboards landing page by selecting Dashboards in the upper left.

    ![Campus Studio](./assets/images/a03/dashboards/03_dashboards.png)

### Device Health

1. Next, Select the Device Hardware dashboard

    ![Campus Studio](./assets/images/a03/dashboards/04_dashboards.png)

2. By default, this dashboard selects all devices.

    ![Campus Studio](./assets/images/a03/dashboards/05_dashboards.png)

3. Change the dashboard to select only `leaf1a` or `leaf1b` by changing from `device: *` to `device:` to match a single device. Once you’ve selected an individual device, the dashboard will filter to results for only this device.

    ![Campus Studio](./assets/images/a03/dashboards/06_dashboards.png)

4. Navigate back to the Dashboards landing page by clicking Dashboards in upper left.

### Custom Dashboard

Next, let’s add a new customized dashboard. There are three main constructs we will touch on here:

- **Metrics (Devices)**: telemetry data specific to a device
- **Metrics (Interfaces)**: telemetry data specific to the interfaces of a device
- **Summaries**: a metric or set of metrics summarized into a single view

There is a lot to unpack in dashboards as you have a significant amount of power in customizing the data and look of your dashboard. See how dashboards are quickly created before we get started.

Let's get started:

1. Click the `+ New Dashboard` button.

    ![Campus Studio](./assets/images/a03/dashboards/07_dashboards.png)

2. Provide a useful `Name` for the Dashboard, such as `Pod##-Student#`

    ![Campus Studio](./assets/images/a03/dashboards/08_dashboards.png)

3. Next, let’s add a combination of visualizations that we want to capture
4. First, click the drop down on the upper right and change from `Metrics` to `Summaries`
5. Within the `Summaries` list, click on, or drag the `Events` widget into the dashboard canvas

    ![Campus Studio](./assets/images/a03/dashboards/09_dashboards.png)

6. Within the `Events` tile now added to your dashboard, click the `Configure` button
7. Within the right side menu bar, select the following:

    !!! example "Dashboard Settings"

        | Key              | Value              |
        | ---------------- | ------------------ |
        | View Mode        | Severity Timeline  |
        | Show Active Only | True               |
        | Dataset          | `Access-Pod: IDF1` |

    ![Campus Studio](./assets/images/a03/dashboards/10_dashboards.png)

8. Dismiss the customization menu by clicking the :octicons-x-12: in upper right corner
9. Next, change the `Summaries` menu back to `Metrics`

    ![Campus Studio](./assets/images/a03/dashboards/11_dashboards.png)

10. Within the Metrics menu, click and drag a `Table` and a `Horizon Graph` to the canvas

    !!! tip "Drag the tiles"

        You can drag the tiles around by the respective menu bars and resize each tile using the lower right corner handles.

    ![Campus Studio](./assets/images/a03/dashboards/12_dashboards.png)

11. Let's configure the `Table` first by clicking the then click the three-dots :material-dots-horizontal: menu and click `Configure`

    !!! example "Table Settings"

        | Key         | Value                  |
        | ----------- | ---------------------- |
        | Data Source | Devices                |
        | Metrics #1  | 802.1X Interface Count |
        | Metrics #2  | CPU Utilization        |
        | Metrics #3  | Total Power Granted    |
        | Metrics #4  | ARP Table Size         |
        | Metrics #5  | Boot Time              |

    ![Campus Studio](./assets/images/a03/dashboards/13_dashboards.png)

12. Dismiss the customization menu with the :octicons-x-12: button in upper right
13. Now let's configure the `Horizon Graph` by clicking the then click the three-dots :material-dots-horizontal: menu and click `Configure`

    !!! example "Horizon Graph Settings"

        Target your student device below!

        | Key                   | Value                           |
        | --------------------- | ------------------------------- |
        | Data Source           | Interfaces                      |
        | View Type             | Multiple Metrics for One Source |
        | Interface (device)    | `pod##-leaf1`                  |
        | Interface (interface) | `Ethernet1`                     |
        | Metrics #1            | Bitrate In                      |
        | Metrics #2            | Bitrate Out                     |
        | Metrics #3            | Operational Status              |
        | Metrics #4            | Interface Authentication State  |

    ![Campus Studio](./assets/images/a03/dashboards/14_dashboards.png)

14. Dismiss the customization menu with the :octicons-x-12: button in upper right
15. You can resize and drag the components around, but you should have a new dashboard that looks something like this.

    ![Campus Studio](./assets/images/a03/dashboards/15_dashboards.png)

16. Save and completed the dashboard customization by clicking the `Done` button in upper menu bar

## Events

In this section, we will explore the Events stream and the tools and filters to help process and manage critical errors versus informational data.

1. First, open `Events` from the menu bar

    ![Campus Studio](./assets/images/a03/events/01_events.png)

2. Next, select a different time frame for the summary visualization, click the current time selection and change this to `1 Hour`

    ![Campus Studio](./assets/images/a03/events/02_events.png)

3. You can also toggle between a bar graph and event count display

    === "Events Graph"

        ![Campus Studio](./assets/images/a03/events/03_events.png)

    === "Events Table"

        ![Campus Studio](./assets/images/a03/events/04_events.png)

4. Focusing on the `Event List` next, Note the `Export` button to download the current Event list as CSV. Notice you can download `All Events` or only `Selected`

    ![Campus Studio](./assets/images/a03/events/05_events.png)

5. Next, select the Gear :octicons-gear-24: icon to toggle `Event List Roll Up`. This setting combines repeated events into groups. Toggle this On and Off, watch the effect this has on the list of Events.

    ![Campus Studio](./assets/images/a03/events/06_events.png)

6. Next, utilizing the Event Filters on the right pane is important to reduce the amount of data displayed.

    ???+ "Filter Settings"

        | Key      | Value                      |
        | -------- | -------------------------- |
        | Severity | `Critical`, `Error`        |
        | Type #1  | `Unexpected Link Shutdown  |
        | Type #2  | `Device Clock Out of Sync` |

    ![Campus Studio](./assets/images/a03/events/07_events.png)

7. Acknowledge and Unacknowledging events
    1. To acknowledge from the filtered event list, select specific events and Acknowledge them.

        ![Campus Studio](./assets/images/a03/events/08_events.png)

    2. Adding a note is optional, select the `Acknowledge` button to mark these selected events.

        ![Campus Studio](./assets/images/a03/events/09_events.png)

    3. Acknowledged events are not deleted from the event list, only flagged as acknowledged and can be referenced by changing the filtered `Acknowledgement State`. Click `Acknowledgement State` and select `Acknowledged`

        ![Campus Studio](./assets/images/a03/events/10_events.png)

    4. Un-acknowledging an event can be done in the same way, click the box to the left of the `Acknowledged event`, and click `Unacknowledge` at the top of the event list.

        ![Campus Studio](./assets/images/a03/events/11_events.png)

8. Events and filtering lab section complete!

### Customize Notifications

In this lab, you will configure CloudVision to send an email alert to an email address using the built-in “SendGrid” email service. There are other notification systems natively supported in CloudVision, but we'll focus on email for this lab (Example: email, chat, SNMP, Syslog, etc).

1. Configure `SendGrid` email service.
2. If you are not already, click on the `Events` menu option.
3. Click on the `Notifications` button in the top right of the screen.

    ![Campus Studio](./assets/images/a03/notify/01_notify.png)

4. Check the system status for the `Config back-end` and `Relay back-end`

    !!! warning "Status Unknown!?"

        Before receivers and notifications are configured, the status will be “Unknown”.

    === "Status Unknown"

        ![Campus Studio](./assets/images/a03/notify/02_notify.png)

    === "Status Ready"

        ![Campus Studio](./assets/images/a03/notify/03_notify.png)

5. Now, configure the SendGrid receiver by clicking on `Receivers` in the menu, then click on the `Add Receiver` button. Name the receiver `SendGrid for Campus ATD`, then click the `Add Configuration` button and select `SendGrid` from the menu options.

    ![Campus Studio](./assets/images/a03/notify/04_notify_1.png)

6. Type in `cvaas-alerts@arista.com` in the email address field. This is a shared email address that you can receive emails at during this lab and check the `Send notification when events are resolved` checkbox. Click the `Save` button in the upper right hand side of the screen to save your new receiver.

    ![Campus Studio](./assets/images/a03/notify/04_notify_2.png)

7. Once you are happy with receiver’s configuration, click the `Save` button at the top of the screen

8. Next, configure a `Rule` to use the new receiver. Click on the `Rules` menu option, then click `Add Rule`

    ![Campus Studio](./assets/images/a03/notify/05_notify.png)

9. Configure `Rule Conditions` for this rule. Click on the `+ Device` button, then choose your switch from the `Device` drop down box.

    === "Add Device"

        ![Campus Studio](./assets/images/a03/notify/06_notify.png)

    === "Select Device"

        ![Campus Studio](./assets/images/a03/notify/07_notify.png)

10. Now click on the `+ Event Type` button. Add `Event Types` by choosing them from the drop down box as shown in the image below:

    === "Add Event"

        ![Campus Studio](./assets/images/a03/notify/08_notify.png)

    === "Select Event"

        ![Campus Studio](./assets/images/a03/notify/09_notify.png)

11. Select all of the severity options by clicking on the `+ Severity` button and choosing the options from the drop down box.

    ![Campus Studio](./assets/images/a03/notify/10_notify.png)

12. Next, choose your new `SendGrid for Campus ATD` receiver from the `Receiver` dropdown box, select the `Continue Checking Rules` box, and save your changes by clicking on the `Save` button.

    !!! tip "SAVE the changes!!"

        Make sure to save your changes in this screen with the Save button along the top of your screen.

    ![Campus Studio](./assets/images/a03/notify/11_notify.png)

13. Now lets test your new receiver and rule

14. Click on the `Status` menu option. Configure the `Test Notification Sender` by changing the `Event Type` to be `Device Stopped Streaming` and selecting your switch from the `Device` drop down box. Click the `Send Test Notification` button.

    === "Send Notification"

        ![Campus Studio](./assets/images/a03/notify/12_notify.png)

    === "Notification Sent"

        ![Campus Studio](./assets/images/a03/notify/13_notify.png)

15. After a minute or two, you should receive the email alert at the email address you configured in the Receiver

    ![Campus Studio](./assets/images/a03/notify/14_notify.png)

16. You can remove your event receiver to avoid additional emails before continuing!

!!! tip "🎉 CONGRATS! You have completed the Wired labs! 🎉"

--8<-- "includes/abbreviations.md"
