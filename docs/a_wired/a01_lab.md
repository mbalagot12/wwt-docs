# A-01 | Explore EOS

## Overview

In this lab, you'll learn how to log into an Arista switch and explore configuration. All Arista switches, whether they’re used in data center, campus, WAN, or other environments, run on Arista's Extensible Operating System (EOS). We’ll also cover MLAG, how to configure it, and how to troubleshoot issues!

Let’s take a closer look at the EOS interface—while it might feel familiar, it’s also distinctly unique!

## Completely Different, Totally Familiar

Let's log into the workshop spine switches.

???+ tip "I have a console cable or WiFi"

    If you have a console cable, feel free to console into your switch. The switch is in ZTP, you can explore the same commands! You may also use the `WiFi` to connect to the spine switches. The spine switch is running configuration your switch will not contain, but login using `admin`, hit Enter and type in `enable` to start exploring

1. Login to the spine using the address below and the username `student#`, password `Arista123`.

    ```yaml
    # Student 1
    ssh student1@10.1.100.2

    # Student 2
    ssh student2@10.1.100.3
    ```

2. First thing, let's validate you are on the spine switch and explore the hardware.

    ```yaml
    show version
    ```

    ???+ quote "Example Output"

        ```yaml title="Example Output" hl_lines="1 3 7-8 14"
        Arista CCS-722XPM-48ZY8-F #(1)!
        Hardware version: 11.01
        Serial number: HBG23270736 #(2)!
        Hardware MAC address: ac3d.9450.afc6
        System MAC address: ac3d.9450.afc6

        Software image version: 4.31.5M #(3)!
        Architecture: i686 #(4)!
        Internal build version: 4.31.5M-38783123.4315M
        Internal build ID: a514fb70-598b-4084-975c-4f5978421b10
        Image format version: 3.0
        Image optimization: Strata-4GB

        Uptime: 4 hours and 58 minutes #(5)!
        Total memory: 3952960 kB
        Free memory: 2054376 kB
        ```

        1. The full switch model
        2. The serial number of the switch
        3. Current EOS image running
        4. This EOS software is a 32-bit version, Arista EOS is also provided in a 64-bit version
        5. The current uptime

3. Let's explore the hardware in a bit more detail. Text output is great, but imagine you have been asked to pull all device information programmatically. Tools like [TextFSM](https://github.com/google/textfsm) are common to parse unstructured data, wouldn't it be great if this data was structured? Try validating this command will also render as `json`.

    ```yaml
    show inventory
    show inventory | json
    ```

    ??? quote "Example Output"

        ```yaml title="Example Output" hl_lines="4 8 13 16 37 39"
        System information
            Model                    Description
            ------------------------ ----------------------------------------------------
            CCS-722XPM-48ZY8         48 2.5GBase-T PoE & 8-port SFP28 MacSec Switch #(1)!

            HW Version  Serial Number  Mfg Date   Epoch
            ----------- -------------- ---------- -----
            11.01       HBG23270736    2023-07-14 01.00 #(2)!

        System has 2 power supply slots
            Slot Model            Serial Number
            ---- ---------------- ----------------
            1    PWR-1021-AC-RED  GGJT36P13J0 #(3)!
            2    Not Inserted

        System has 3 fan modules
            Module  Number of Fans  Model            Serial Number
            ------- --------------- ---------------- ----------------
            1       1               FAN-7000-F       N/A
            2       1               FAN-7000-F       N/A
            3       1               FAN-7000-F       N/A

        System has 65 ports
            Type               Count
            ------------------ ----
            Management         1
            Switched           52
            SwitchedBootstrap  4
            Fabric             8

        System has 56 switched transceiver slots
            Port Manufacturer     Model            Serial Number    Rev
            ---- ---------------- ---------------- ---------------- ----
            1    Arista Networks  CCS-722XPM-48ZY8
            2    Arista Networks  CCS-722XPM-48ZY8
            ...
            49   Arista Networks  SFP-10G-SR       ACW1710002F0     20
            50   Not Present
            51   Arista Networks  SFP-10G-SR       XTH16080010E     0002 #(5)!
            52   Not Present
            53   Not Present
            54   Not Present
            55   Not Present
            56   Not Present

        System has 1 storage device
            Mount      Type Model                Serial Number Rev Size (GB)
            ---------- ---- -------------------- ------------- --- ---------
            /mnt/flash eMMC Smart Modular 16GP1A 801f4198      1.0 8
        ```

        1. More information about this switch platform capabilities
        2. You can see when this switch was manufactured and hardware versioning
        3. Power supply details, like model and serial number
        4. If you have fan modules, similar detail to that of power supplies
        5. Get optics manufacturer, serial number, and model

4. Let's explore the interfaces and what's connected. Take note
      1. [x] Your pod has one connection to the spine (we're not in a full mesh)
      2. [x] Workshop access point and raspberry pi (lab guides) are connected
      3. [x] MLAG interfaces
      4. [x] Your POD is configured as part of a Port-Channel

    ```yaml
    show interfaces status
    ```

    ??? quote "Example Output"

        ```yaml title="Example Output" hl_lines="2-3 29-30 32-33 35"
        Port       Name       Status       Vlan      Duplex Speed  Type         Flags Encapsulation
        Et1        POD01      connected    in Po101  a-full a-1G   2.5GBASE-T
        Et2        POD01      notconnect   in Po101  auto   auto   2.5GBASE-T
        Et3        POD02      connected    trunk     auto   auto   2.5GBASE-T
        Et4        POD02      notconnect   trunk     auto   auto   2.5GBASE-T
        Et5        POD03      connected    trunk     auto   auto   2.5GBASE-T
        Et6        POD03      notconnect   trunk     auto   auto   2.5GBASE-T
        Et7        POD04      connected    trunk     auto   auto   2.5GBASE-T
        Et8        POD04      notconnect   trunk     auto   auto   2.5GBASE-T
        Et9        POD05      connected    trunk     auto   auto   2.5GBASE-T
        Et10       POD05      notconnect   trunk     auto   auto   2.5GBASE-T
        Et11       POD06      connected    trunk     auto   auto   2.5GBASE-T
        Et12       POD06      notconnect   trunk     auto   auto   2.5GBASE-T
        Et13       POD07      connected    trunk     auto   auto   2.5GBASE-T
        Et14       POD07      notconnect   trunk     auto   auto   2.5GBASE-T
        Et15       POD08      connected    trunk     auto   auto   2.5GBASE-T
        Et16       POD08      notconnect   trunk     auto   auto   2.5GBASE-T
        Et17       POD09      connected    trunk     auto   auto   2.5GBASE-T
        Et18       POD09      notconnect   trunk     auto   auto   2.5GBASE-T
        Et19       POD10      connected    trunk     auto   auto   2.5GBASE-T
        Et20       POD10      notconnect   trunk     auto   auto   2.5GBASE-T
        Et21       POD11      connected    trunk     auto   auto   2.5GBASE-T
        Et22       POD11      notconnect   trunk     auto   auto   2.5GBASE-T
        Et23       POD12      connected    trunk     auto   auto   2.5GBASE-T
        Et24       POD12      notconnect   trunk     auto   auto   2.5GBASE-T
        Et25       POD13      connected    trunk     auto   auto   2.5GBASE-T
        Et26       POD13      notconnect   trunk     auto   auto   2.5GBASE-T
        ...
        Et33       ATD_WiFi   disabled     100       auto   auto   2.5GBASE-T
        Et34       ATD_PI     disabled     100       auto   auto   2.5GBASE-T
        ...
        Et47       MLAG       connected    in Po1000 auto   auto   5GBASE-T
        Et48       MLAG       connected    in Po1000 auto   auto   5GBASE-T
        ...
        Po101      POD01      connected    trunk     full   2G     N/A
        Po102      POD02      connected    trunk     full   unconf N/A
        Po103      POD03      connected    trunk     full   unconf N/A
        Po104      POD04      connected    trunk     full   unconf N/A
        Po105      POD05      connected    trunk     full   unconf N/A
        Po106      POD06      connected    trunk     full   unconf N/A
        Po107      POD07      connected    trunk     full   unconf N/A
        Po108      POD08      connected    trunk     full   unconf N/A
        Po109      POD09      connected    trunk     full   unconf N/A
        Po110      POD10      connected    trunk     full   unconf N/A
        Po111      POD11      connected    trunk     full   unconf N/A
        Po112      POD12      connected    trunk     full   unconf N/A
        Po113      POD13      connected    trunk     full   unconf N/A
        Po1000     MLAG       connected    trunk     full   20G    N/A
        ```

5. Try some filtering of our output, there are some familiar filtering options like `include`, `exclude`, `begin`, etc, but as we go through this workshop we will explore further!

    !!! warning "Read Only Mode"

        You have read only on the spines, which excludes access to EOS' underlying Linux subsystem. You will have full access to this in the workshop, where you can leverage tools like `grep`, `awk`, `sed`, etc to filter content further.

    ```yaml
    show interfaces status | ?
    show interfaces status | inc POD01
    show interfaces | inc MTU|Eth
    show interfaces | sec Ethernet(25|26)
    ```

    ```yaml title="Example Output" hl_lines="3-5 10"
    LINE      Filter command by common Linux tools such as grep/awk/sed/wc
    append    Append redirected output to URL
    begin     Start output at the first matching line
    exclude   Do not print lines matching the given pattern
    include   Print lines matching the given pattern
    json      Produce JSON output for this command
    no-more   Disable pagination for this command
    nz        Include only non-zero counters
    redirect  Redirect output to URL
    section   Include sections that match
    tee       Copy output to URL
    ```

6. The spines in this workshop will act as our gateway for the various pods, let's validate our ip addressing and the virtual router addresses (gateways).

    ```yaml
    show ip interface brief
    show ip virtual-router
    ```

    ??? quote "Example Output"

        ```yaml title="Example Output: interface brief"
                                                                                        Address
        Interface         IP Address             Status       Protocol           MTU    Owner
        ----------------- ---------------------- ------------ -------------- ---------- -------
        Ethernet49        192.168.254.1/31       up           up                9214
        Management1       unassigned             down         down              1500
        Vlan100           10.1.100.2/24          up           up                9214
        Vlan101           10.1.1.2/24            up           up                9214
        Vlan102           10.1.2.2/24            up           up                9214
        Vlan103           10.1.3.2/24            up           up                9214
        Vlan104           10.1.4.2/24            up           up                9214
        Vlan105           10.1.5.2/24            up           up                9214
        Vlan106           10.1.6.2/24            up           up                9214
        Vlan107           10.1.7.2/24            up           up                9214
        Vlan108           10.1.8.2/24            up           up                9214
        Vlan109           10.1.9.2/24            up           up                9214
        Vlan110           10.1.10.2/24           up           up                9214
        Vlan111           10.1.11.2/24           up           up                9214
        Vlan112           10.1.12.2/24           up           up                9214
        Vlan113           10.1.13.2/24           up           up                9214
        Vlan4094          192.168.255.1/30       up           up                9214
        ```

        ```yaml title="Example Output: virtual-router"
        IP virtual router is configured with MAC address: 00:1c:73:00:00:01
        IP virtual router address subnet routes not enabled
        IP router is not configured with Mlag peer MAC address
        MAC address advertisement interval: 30 seconds

        Protocol: U - Up, D - Down, T - Testing, UN - Unknown
                NP - Not Present, LLD - Lower Layer Down

        Interface       Vrf           Virtual IP Address       Protocol       State
        --------------- ------------- ------------------------ -------------- ------
        Vl100           default       10.1.100.1               U              active
        Vl101           default       10.1.1.1                 U              active
        Vl102           default       10.1.2.1                 U              active
        Vl103           default       10.1.3.1                 U              active
        Vl104           default       10.1.4.1                 U              active
        Vl105           default       10.1.5.1                 U              active
        Vl106           default       10.1.6.1                 U              active
        Vl107           default       10.1.7.1                 U              active
        Vl108           default       10.1.8.1                 U              active
        Vl109           default       10.1.9.1                 U              active
        Vl110           default       10.1.10.1                U              active
        Vl111           default       10.1.11.1                U              active
        Vl112           default       10.1.12.1                U              active
        Vl113           default       10.1.13.1                U              active
        ```

7. Ok, let's look at all the LLDP information, note the models and EOS version details and interesting command `atdpods`. Explore the aliases configured on this device.

    ```yaml
    show lldp neighbors detail
    acwspods
    show aliases
    ```

    ??? quote "Example Output"

        ```yaml title="Example Output: LLDP Detail"
        Last table change time   : 0:00:02 ago

        Number of table inserts  : 51
        Number of table deletes  : 35
        Number of table drops    : 0
        Number of table age-outs : 0

        Port          Neighbor Device ID       Neighbor Port ID    TTL
        ---------- ------------------------ ---------------------- ---
        Et1           sw-10.1.1.51             Ethernet15          120
        Et3           sw-10.1.2.42             Ethernet15          120
        Et5           sw-10.1.3.40             Ethernet15          120
        Et7           sw-10.1.4.41             Ethernet15          120
        Et9           sw-10.1.5.40             Ethernet15          120
        Et11          sw-10.1.6.41             Ethernet15          120
        Et13          sw-10.1.7.41             Ethernet15          120
        Et15          sw-10.1.8.40             Ethernet15          120
        Et17          sw-10.1.9.41             Ethernet15          120
        Et19          sw-10.1.10.41            Ethernet15          120
        Et21          sw-10.1.11.40            Ethernet15          120
        Et23          sw-10.1.12.40            Ethernet15          120
        Et25          sw-10.1.13.40            Ethernet15          120
        Et33          Arista_18:66:BF          3086.2d18.66bf      120
        Et47          SPINE02                  Ethernet47          120
        Et48          SPINE02                  Ethernet48          120
        Et49          CORE01                   Ethernet49          120
        ```

        ```yaml title="Example Output: atdpods"
        Interface Ethernet1 detected 1 LLDP neighbors:
           - System Description: "Arista Networks EOS version 4.31.6M running on an Arista Networks CCS-710P-12"
        Interface Ethernet51 detected 1 LLDP neighbors:
           - System Description: "Arista Networks EOS version 4.31.6M running on an Arista Networks CCS-720XP-48ZC2"
        Interface Ethernet52 detected 1 LLDP neighbors:
           - System Description: "Arista Networks EOS version 4.31.6M running on an Arista Networks CCS-720XP-48ZC2"
        ```

        ```yaml title="Example Output: aliases"
        acwspods        sh lldp neighbors detail | inc (detected 1|System Descr)
        c               bash clear
        sh-acg          trace monitor acg
        sh-streaming    show agent TerminAttr logs | tail
        ```

8. Let's look at traffic on our interfaces, let's also leverage the `watch` command with the `nz` (non-zero) command to monitor rates.

    ```yaml
    show int counters rates
    show int counters rates | nz
    watch 1 diff show int counters rates | nz
    ```

9. Sometimes it's the little things that make a big difference! This was a brief introduction into the CLI. All features start in EOS, with respective show and configuration commands. We'll further explore the symbiotic relationship between EOS and CloudVision!

    ???+ tip "Wait! There's more!"

        If you're interested in exploring more fun EOS commands, we published the [Arista EOS Tips for Network Operators](https://tech-library.arista.com/eos/eos_ops/). If you would like access, ask your Arista team for more information!

        There are many more commands like:

        - Configuration sessions
        - CLI command finder
        - Event handlers
        - Event monitor
        - Packet captures
        - Scheduler
        - Tech Support Bundles/Checkpoints
        - So much more

## MLAG & VARP

Arista's Multi-Chassis Link Aggregation (MLAG) is a technology that allows two physical switches to act as a single logical switch. By syncing the control plane without the need for proprietary cabling or protocols, it provides an active-active, non-blocking redundancy between multiple pairs of switches.

Let's explore the configuration and how to troubleshoot

1. From the switch run the `show mlag` command to validate the high level state

    ```yaml
    show mlag
    ```

    ???+ quote "Example Output"

        ```yaml title="Example Output" hl_lines="2-4 5 10-11 21-23"
        MLAG Configuration:
        domain-id                          :                MLAG
        local-interface                    :            Vlan4094
        peer-address                       :       192.168.255.2
        peer-link                          :      Port-Channel11
        hb-peer-address                    :             0.0.0.0
        peer-config                        :          consistent

        MLAG Status:
        state                              :              Active
        negotiation status                 :           Connected
        peer-link status                   :                  Up
        local-int status                   :                  Up
        system-id                          :   ae:3d:94:50:af:c6
        dual-primary detection             :            Disabled
        dual-primary interface errdisabled :               False

        MLAG Ports:
        Disabled                           :                   0
        Configured                         :                   0
        Inactive                           :                  13
        Active-partial                     :                   0
        Active-full                        :                   0
        ```

2. You can also dive deeper in using the `show mlag detail`

    ```yaml
    show mlag detail
    ```

    ???+ quote "Example Output"

        ```yaml title="Example Output" hl_lines="3-4 14-15"
        ...
        MLAG Detailed Status:
        State                           :              primary
        Peer State                      :            secondary
        State changes                   :                    2
        Last state change time          :          4:56:38 ago
        Hardware ready                  :                 True
        Failover                        :                False
        Failover Cause(s)               :              Unknown
        Last failover change time       :                never
        Secondary from failover         :                False
        Peer MAC address                :    ac:3d:94:50:d2:aa
        Peer MAC routing supported      :                 True
        Reload delay                    :          300 seconds
        Non-MLAG reload delay           :          300 seconds
        Peer ports errdisabled          :                False
        Lacp standby                    :                False
        Configured heartbeat interval   :              4000 ms
        Effective heartbeat interval    :              4000 ms
        Heartbeat timeout               :             60000 ms
        Last heartbeat timeout          :                never
        Heartbeat timeouts since reboot :                    0
        UDP heartbeat alive             :                 True
        Heartbeats sent/received        :            4499/4450
        Peer monotonic clock offset     :   -56.025806 seconds
        Agent should be running         :                 True
        P2p mount state changes         :                    1
        Fast MAC redirection enabled    :                 True
        Interface activation interlock  :         unconfigured
        ```

3. Let's look at the configuration to enable MLAG, first run the command to show the block of mlag configuration

    ```yaml
    show running-config section mlag configuration
    ```

    ???+ quote "Example Output"

        ```yaml title="Example Output"
        mlag configuration
            domain-id MLAG #(1)!
            local-interface Vlan4094 #(2)!
            peer-address 169.254.0.0 #(3)!
            peer-address heartbeat 10.1.1.4 #(4)!
            peer-link Port-Channel11 #(5)!
            dual-primary detection delay 5 action errdisable all-interfaces
            reload-delay mlag 300
            reload-delay non-mlag 330
        ```

        1. MLAG domain is locally significant to the MLAG pair of switches, this can be any descriptor. Whether it's simply `MLAG` like shown or the name of say a pod: `POD01`
        2. The local interface used to peer to the MLAG neighbor, this will always be an SVI
        3. The MLAG neighbors address that resides within the `local-interface` subnet
        4. This is an optional configuration called [Dual Primary Detection](https://www.arista.com/en/support/toi/eos-4-23-1f/14406-mlag-dual-primary-detection-and-release-updates){target="_blank"}, you can read more on this topic.
        5. The peer link is the layer 2 port-channel used to trunk our MLAG vlans, we'll explore below how that's configured.

4. Let's take a closer look at the peer link itself

    ```yaml
    run show run interface Eth25-26; show run int Port-Channel1000; show port-channel 1000 detailed
    ```

    ???+ quote "Example Output"

        ```yaml title="Example Output" hl_lines="4 14-15"
        !
        interface Ethernet25
            description MLAG
            channel-group 25mode active
        !
        interface Ethernet26
            description MLAG
            channel-group 25 mode active
        !
        interface Port-Channel25
            description MLAG_spine2_Ethernet25
            switchport mode trunk
            switchport trunk group MLAG
        !
        Port Channel Port-Channel25 (Fallback State: Unconfigured):
        Minimum links: unconfigured
        Minimum speed: unconfigured
        Current weight/Max weight: 2/8
        Active Ports:
            Port             Time Became Active       Protocol       Mode         Weight    State
            ---------------- ------------------------ -------------- ------------ ------------ -----
            Ethernet25       11:51:27                 LACP           Active         1       Rx,Tx
            Ethernet26       9:24:02                  LACP           Active         1       Rx,Tx

        
        ```

5. The port-channel is using a `trunk group`, lets look at that trunk group

    !!! tip "Linux Sub-system"

        On top of the typical `includes`, `section`, `begin`, etc we commonly use to filter output. You also have access to many of the linux sub-system commands like `grep`, `sed`, `awk`, etc to filter and manipulate the output.

    ```yaml
    show vlan trunk group | grep -E "MLAG|Groups|-"
    ```

    ```yaml title="Example Output" hl_lines="3"
    VLAN     Trunk Groups
    ----     ----------------------------------------------------------------------
    4094     MLAG
    ```

6. Note that `vlan 4094` is a part of that trunk group, trunk groups are used to ensure those vlans assigned to trunk group `MLAG` are pruned from all interfaces except those explicitly configured. In this case `Port-Channel11` is assigned the trunk group, therefore it's the only interface forwarding `Vlan 4094`.

7. Let's look at the peering SVI `Vlan4094`

    ```yaml
    show running-config interfaces vlan 4094
    ```

    ```yaml title="Example Output: SPINE01" hl_lines="4-5"
    interface Vlan4094
        description MLAG_PEER
        mtu 9200
        no autostate #(1)!
        ip address 169.254.0.0/31 #(2)!
    ```

    1. We disable autostate to force the VLAN to be active
    2. This peering address is only locally significant, it's common to use an APIPA IP address range (/31) that's repeated across all MLAG pairs. The neighbor address is used in the mlag configuration to peer over the trunk.

8. In the previous `show mlag` section we got a brief overview of status. During troubleshooting steps, there is a built in command to ensure MLAG configuration parity between the two devices. Run the following command to validate configuration matches between the two devices

    ```yaml
    show mlag config-sanity
    ```

    ```yaml title="Example Output"
    No global configuration inconsistencies found.

    No per interface configuration inconsistencies found.
    ```

9. Looking at the interfaces down to the POD, let's validate the interface configuration

    ```yaml
    show run interface Ethernet 1-2
    show run interface Port-Channel101
    ```

    ???+ quote "Example Output"

        ```yaml title="Example Output"
        !
        interface Ethernet1
            description POD01
            switchport mode trunk
            channel-group 101 mode active
            lldp tlv transmit ztp vlan 101
        !
        interface Ethernet2
            description POD01
            switchport mode trunk
            channel-group 101 mode active
            lldp tlv transmit ztp vlan 101
        !
        interface Port-Channel101
            description POD01
            switchport trunk allowed vlan 101,201
            switchport mode trunk
            port-channel lacp fallback individual
            port-channel lacp fallback timeout 20
            mlag 101
        !
        ```

10. If we do detect issues or want to verify the MLAG interfaces upstream/downstream are `up/up` we can validate

    ```yaml
    show mlag interfaces
    ```

    ???+ quote "Example Output"

        ```yaml title="Example Output"
        SPINE01#show mlag interfaces
                                                                local/remote
        mlag       desc           state       local       remote          status
        ---------- ----------- -------------- ----------- ------------ ------------
        101       POD01       inactive       Po101        Po101       down/down
        102       POD02       inactive       Po102        Po102       down/down
        103       POD03       inactive       Po103        Po103       down/down
        104       POD04       inactive       Po104        Po104       down/down
        105       POD05       inactive       Po105        Po105       down/down
        106       POD06       inactive       Po106        Po106       down/down
        107       POD07       inactive       Po107        Po107       down/down
        108       POD08       inactive       Po108        Po108       down/down
        109       POD09       inactive       Po109        Po109       down/down
        110       POD10       inactive       Po110        Po110       down/down
        111       POD11       inactive       Po111        Po111       down/down
        112       POD12       inactive       Po112        Po112       down/down
        113       POD13       inactive       Po113        Po113       down/down
        ```

11. Lastly, how do we maintain active/active forwarding with MLAG, this where VARP comes in. A virtual router address and common MAC is all it takes.

    ```yaml
    show run sec virtual-router
    show ip virtual-router
    ```

    ???+ quote "Example Output"

        ```yaml
        !
        interface Vlan101
            ip virtual-router address 10.1.1.1 #(1)!
        interface Vlan102
            ip virtual-router address 10.1.2.1
        interface Vlan103
            ip virtual-router address 10.1.3.1
        ...
        !
        ip virtual-router mac-address 00:1c:73:00:00:01 #(2)!
        !
        ```

        ```yaml
        IP virtual router is configured with MAC address: feed.dead.beef
        IP virtual router address subnet routes not enabled
        IP router is not configured with Mlag peer MAC address
        MAC address advertisement interval: 30 seconds

        Protocol: U - Up, D - Down, T - Testing, UN - Unknown
                NP - Not Present, LLD - Lower Layer Down

        Interface       Vrf           Virtual IP Address       Protocol       State
        --------------- ------------- ------------------------ -------------- ------
        Vl1             default       192.168.3.1              U              active
        Vl100           default       10.1.100.1               U              active
        Vl101           default       10.1.1.1                 U              active
        Vl102           default       10.1.2.1                 U              active
        Vl103           default       10.1.3.1                 U              active
        Vl104           default       10.1.4.1                 U              active
        Vl105           default       10.1.5.1                 U              active
        Vl106           default       10.1.6.1                 U              active
        Vl107           default       10.1.7.1                 U              active
        Vl108           default       10.1.8.1                 U              active
        Vl109           default       10.1.9.1                 U              active
        Vl110           default       10.1.10.1                U              active
        Vl111           default       10.1.11.1                U              active
        Vl112           default       10.1.12.1                U              active
        Vl113           default       10.1.13.1                U              active
        ```

        1. This is the virtual IP address configured on both MLAG pairs.
        2. This vMAC will be used as the gateway vMAC associated with the Gateway VIP configured with either ip address virtual or ip virtual-router address (vARP). This vMAC will be consistent across all SVIs configured with a VIP.

12. That's it for this lab, you should have a bit better understanding of how MLAG is configured

## Closing Out

### Streaming Telemetry

Let's take a look at the steaming telemetry agent that communicates back to CloudVision. You may not be able to do this on you switch (current in zero-touch). Feel free to come back to this section to explore, your instructor will showcase this.

1. Let's view the telemetry agent daemon

    ```bash
    show running-config section TerminAttr
    ```

    ???+ quote "Example Output"

        ```bash
        daemon TerminAttr
            exec /usr/bin/TerminAttr
                -disableaaa
                -cvaddr=apiserver.cv-prod-us-central1-b.arista.io:443
                -taillogs
                -cvproxy=
                -cvauth=certs,/persist/secure/ssl/terminattr/primary/certs/client.crt,/persist/secure/ssl/terminattr/primary/keys/client.key
                -smashexcludes=ale,flexCounter,hardware,kni,pulse,strata
            no shutdown
        ```

2. Now let's see this in action, login to CloudVision and navigate to the `Devices > Inventory`
3. Make a change to the hostname using a configuration session

    ```yaml
    !
    configure session namechange #(1)!
    hostname SOMEONEWASHERE
    !
    show session-config diffs #(2)!
    !
    commit timer 00:05:00 #(3)!
    ```

    1. Create a configuration session, similar to branching in git, this will stage changes and wait for a commit to apply as a replace in configuration
    2. Show the differences of designed vs what's configured
    3. Commit the configuration to roll back in 5 minutes (`hh:mm:ss`), if you do not commit after the fact, this will roll back.

    ```yaml title="Session Configuration Diff"
    SPINE01[16:13:56](config-s-namechange)#show session-config diffs
    --- system:/running-config
    +++ session:/namechange-session-config
    -hostname SPINE01
    +hostname SOMEONEWASHERE
    ```

4. You should see the hostname change immediately inside CloudVision! This is not a poll... this is a continuous stream of state from device to CloudVision.

### Additional Fun Commands

There are few other commands you can explore in your lab after deployment. As we move away from the CLI, remember all interactions with Arista EOS both via terminal or automation are leveraging the same commands.

<div class="grid cards" markdown>

- :fontawesome-brands-linux:{ .lg .middle } **Bash**

    ---

    Access to the underlying Linux system is available. Quick example is exploring the flash

    ```yaml
    bash
    cd /mnt/flash/
    ls -latr
    ```

- :simple-wireshark:{ .lg .middle } **Packet Capture**

    ---

    You have the ability to capture traffic, capturing control plane traffic or mirroring data plane to CPU.

    ```yaml
    bash
    tcpdump -vvvnei et1
    ```

- :material-account-edit:{ .lg .middle } **AAA Logs**

    ---

    Validate what commands have been run on the switch

    ```yaml
    show aaa accounting logs | tail
    ```

- :octicons-copy-16:{ .lg .middle } **Configuration Session**

    ---

    Leverage a configuration session to stage config, commit as a full replace, and even configure a timed rollback.

    ```yaml
    configure session ATD
    !
    hostname IWASHERE
    !
    show session-config diffs
    !
    commit timer 00:00:30
    !
    show conf sessions
    !
    ```

</div>

!!! tip "🎉 CONGRATS! You have completed this lab! 🎉"

    [:material-login: LET'S GO TO THE NEXT LAB!](./a02_lab.md){ .md-button .md-button--primary }

--8<-- "includes/abbreviations.md"
--8<-->
