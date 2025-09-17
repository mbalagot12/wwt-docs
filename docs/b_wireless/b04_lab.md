# B-04 | Arista Smart System Upgrade (SSU)

## Overview

Arista's Smart System Upgrade (SSU) is a feature to minimize traffic loss when upgrading from one SSU-supported EOS version to a newer SSU-supported EOS version. SSU is also referred to as ‘hitless’ upgrades. The SSU feature allows a switch to maintain packet forwarding (Data Plane) while the Management and Control plane perform the OS upgrade.

!!! info "Arista Smart System Upgrade"

    Additional information about this feature can be found in the [Arista TOI for Smart System Upgrade](https://www.arista.com/en/support/toi/eos-4-15-2f/13710-hitless-ssu){target="_blank"}

In our workshop lab topology you will see that each leaf in your pod is directly connected to the access point and RaspberryPi client. Traditionally, a firmware upgrade on the lead in the pod would cause the access point, wireless clients connected to the access point, and the raspberry pi client to lose network connectivity. In this lab, we will use Arista SSU on the leaf switch in your pod to perform a firmware upgrade minimizing any network disruptions for both wired and wireless clients.

## Prerequisites

- [x] Continuous POE should be configured to maintain POE power delivery to connected devices.
- [x] Must be running an EOS version that includes the SSU feature.
- [x] Must be upgrading to a new EOS version that also includes the SSU feature.
- [x] Spanning-tree must be running in MST mode or disabled.
- [x] Spanning-tree edge ports must have portfast and BPDUGuard enabled.
- [x] Switches running BGP must be configured with `graceful-restart` otherwise routes are lost and the hardware may fail to forward traffic.

## Caveats

As you can imagine, disconnecting the Control and Management plane off the data plane will come with some caveats depending on what features you are running! While that's the case, most instances where SSU is valuable is where we have no resiliency or ability to "route around" the switch in maintenance.

- [x] SSU only supports upgrades. Hitless image downgrades are not supported.
- [x] If a new EOS version includes an FPGA upgrade, the FPGA upgrade will be suppressed. FPGA upgrades require a full reboot of a switch to apply.
- [x] Some switch features, when in use, will prevent SSU from starting. See the [Arista TOI](https://www.arista.com/en/support/toi/eos-4-15-2f/13710-hitless-ssu#limitations){target="_blank"} for more details

!!! tip "First, download the desired EOS image to the switch flash storage.  Login to your switch using the `arista` user credentials."

```bash
copy https://ztp-acws.duckdns.org/images/EOS-4.34.1F.swi flash:
# or
copy https://10.1.100.50/EOS-4.34.1F.swi flash:
```

## Perform Arista SSU

Let's begin the hands-on portion of this lab. SSU can be triggered on the command line or via CloudVision. For this lab we will be triggering an SSU upgrade using the command line, preferably using the serial port of the switch. As in

!!! tip "Console via SSH"

    Using the console we will get a more in depth look at the logs as the switch upgrades. However, SSH is fine if you do not have a console cable. There is example output below you can refer to.

1. Connect to the `pod<##>-leaf1` switch serial port (where ## is a 2 digit character between 01-20 that was assigned to your lab/Pod). The login username/password is `arista/arista`. Type `enable` to enter privileged mode.

    ???+ quote "Example Output"

        ```yaml
        pod00-leaf1 login: arista
        Last login: Tue Jul 30 22:16:56 on ttyS0
        pod00-leaf1>enable
        pod00-leaf1#
        ```

2. Type `show version` to show the current running version of the switch.

    !!! note "EOS Version"

        Smart System Upgrade (SSU) is supported on EOS versions 4.31.5M and later on CCS-710P-12/16P switches. In this example, the switch is currently running EOS-4.34.0F. This is a supported EOS version for Arista SSU.

    ```yaml
    show version
    ```

    ???+ quote "Example Output"

        ```yaml
                Arista CCS-710P-16P
                Hardware version: 11.02
                Serial number: WTW22220037
                Hardware MAC address: 2cdd.e9fd.af50
                System MAC address: 2cdd.e9fd.af50

                Software image version: 4.34.0F
                Architecture: i686
                Internal build version: 4.34.0F-41661064.4340F
                Internal build ID: 8346ed5e-061a-4a70-9c36-b6eee6fc0848
                Image format version: 3.0
                Image optimization: Strata-4GB

                Uptime: 2 hours and 5 minutes
                Total memory: 3952472 kB
                Free memory: 2193016 kB
        ```

3. Type `dir` to show the list of files in the `flash:` filesystem. You should note that there are some EOS image versions already on the flash storage of the leaf1a switch. Choose the latest EOS image version which is our target update version for this lab.

    ```yaml
    dir
    ```

    ???+ quote "Example Output"

        ```yaml hl_lines="9 10"
            Directory of flash:/

            -rw-    25449761           Jul 21  2024  AristaCloudGateway-1.0.0-1.swix
            -rw-    32184348           Apr 14 21:54  AristaCloudGateway-1.0.2-1.swix
            -rw-    32566624            Jun 6 13:20  AristaCloudGateway-1.0.3-1.swix
            -rw-       18480            Jul 2 05:51  AsuFastPktTransmit.log
            -rw-   783781597            Dec 6  2021  EOS-4.29.1FX-710P-DHCP.swi
            -rwx   834335804            Jul 1 03:33  EOS-4.31.6M.swi
            -rwx   894262536            May 5 14:16  EOS-4.34.0F.swi
            -rw-  1531686247            Jul 2 03:42  EOS-4.34.1F.swi
            drwx        4096           Jun 15 00:24  Fossil
            -rw-       11360            Jul 2 05:51  SsuRestore.log
            -rw-       11360            Jul 2 05:51  SsuRestoreLegacy.log
            drwx        4096            Dec 6  2021  aboot
            -rw-          27            Jul 2 05:47  boot-config
            -rw-          32            Jul 2 05:47  boot-extensions
            drwx        4096            Jul 2 08:01  debug
            drwx        4096            Feb 4  2023  fastpkttx.backup
            drwx       16384            Dec 6  2021  lost+found
            drwx        4096            Jul 2 08:00  persist
            drwx        4096            Feb 4  2023  schedule
            -rw-        5224            Jul 2 05:47  startup-config
            drwx        4096           Jul 21  2024  tpm-data
            -rw-           0           Jun 29 20:50  zerotouch-config
            drwx        4096           Jun 23 20:34  ztp-debug

            7527178240 bytes total (2043318272 bytes free) on flash:
        ```

4. Type `show reload fast-boot`.  This command will show you an output of warnings or incompatibilities with the current configuration of the switch. As mentioned in the prerequisites section above, if any configuration is set in a way that prevents SSU from starting, the reasons will be listed here.

     ```yaml
        show reload fast-boot
     ```
    
    ???+ quote "Example Output when SSU will proceed with caution. In this case, MLAG is compatible"
        ```yaml hl_lines="2 3 4 5"
            pod00-leaf1a#show reload fast-boot
            Warnings in the current configuration detected:
            If you are performing an upgrade, and the Release Notes for the new version of EOS indicate that MLAG is not backwards-compatible with the currently installed version (4.34.1F), the upgrade will result in packet loss.
            Mlag is configured
        ```

    ???+ quote "Example Output when SSU will proceed without caution"

        ```yaml hl_lines="2"
            pod00-leaf1a#show reload fast-boot
            No warnings or unsupported configuration found.
        ```

5. Now that we have confirmed our configuration is ready to allow SSU, let's prepare the switch for the upgrade process by setting the new boot image in the configuration of the switch. Issue the following commands:

    !!! tip "⏲ Setting the boot flash will take a few seconds!"

    ```bash
    configure
    boot system flash:EOS-4.34.1F.swi
    exit
    write
    ```

    ???+ quote "Example Output"

        ```yaml
            pod00-leaf1#configure
            pod00-leaf1(config)#boot system flash:EOS-4.34.1F.swi
            pod00-leaf1(config)#exit
            pod00-leaf1#write
            Copy completed successfully.
        ```

6. Before we apply the new firmware, let's start a ping test which will run during the switch upgrade process. We will see that the ping traffic will continue to flow through the switch even while its software is being upgraded.
    1. Please make sure that your laptop is connected to the wireless network called `ATD-##-PSK`. Use the PSK you configured in the previous lab to associate with this wireless network.
    2. Open a terminal and ping your gateway using the commands below. If you want to increase the interval to get more granular results, feel free!

        ??? info ":material-apple: MAC OS"

            Open Terminal and run the following, please replace ## with your pod number (1-12)

            ```bash
            ping 10.1.##.1
            ```

        ??? info ":material-microsoft-windows: Windows"

            Open Command Prompt and run the following, please replace ## with your pod number (1-12)

            ```bash
            ping -t 10.1.##.1
            ```

    3. Now leave this window open for the following steps. We will see ping packets being sent and received every second. You are now pinging the gateway IP address for your pod from your wireless device connected to your pods access point. The ping traffic must traverse the `leaf1`switch to reach the gateway.  We should be able to observe how traffic is affected while the switch is upgrading during SSU.

7. Now, in a standard firmware upgrade process, you would issue a normal reload command. However, in this lab, we want to trigger a SSU upgrade. This is where we use the command below, go ahead and issue that command now. 🚀

    !!! danger "REMINDER"

        During this test, **do not plug in or unplug devices from the switch**. Recall, the control plane will effectively be down, so changes or updates to the switch at a hardware level (like populating MAC add/removals) are unavailable.

        ```yaml
            reload fast-boot now
        ```

8. As the SSU process proceeds, you can watch the output on the serial console showing the switch preparing itself for reboot. The switch will reboot shortly, and you should see the normal output of a switch reboot.

    !!! note "ASU vs SSU"

        During the SSU reboot process, you may see messages referring to Arista Smart Upgrade, or ASU. ASU is a previous version of SSU, and some references to ASU still exist in code for the SSU process.

9. When you see the following message in your serial console of the switch, the switch is now rebooting.
        ```yaml
        reloading /mnt/flash/EOS-4.34.1F.swi
        ```

10. SSH to the switch is not possible since the management plane of the switch is rebooting. However, the dataplane is still functional. Open the ping terminal window we started in `step 6` and note that ping packets are still being sent and received even though the switch is in the middle of its reboot process.

11. Below is the output of the full process, with highlights on terminal messages indicating the progress of the upgrade.

    ???+ quote "Example Output"

        ```yaml hl_lines="2 5 8 13 25"
            pod00-leaf1a#reload fast-boot now
            Running AsuPatchDb:doPatch( version=4.34.0F-38783123.4315M, model=Strata ) #(1)!
            Optimizing image for current system - this may take a minute...
            No warnings or unsupported configuration found.
            2024-07-31 17:51:14.459848 Kernel Files /mnt/flash/EOS-4.34.1F.swi extracted from SWI #(2)!
            2024-07-31 17:51:16.439052 ProcOutput passed to Kernel ['crashkernel=512-4G:45M,4G-8G:59M,8G-32G:89M,32G-:121M', 'nmi_watchdog=panic', 'tsc=reliable', 'pcie_ports=native', 'reboot=p', 'usb-storage.delay_use=0', 'pti=off', 'crash_kexec_post_notifiers', 'watchdog.stop_on_reboot=0', 'mds=off', 'nohz=off', 'printk.console_no_auto_verbose=1', 'CONSOLESPEED=9600', 'console=ttyS0', 'gpt', 'Aboot=Aboot-norcal6-6.2.1-2-25288791', 'net_ma1=pci0000:00/0000:00:12.0/usb1/.*$', 'platform=raspberryisland', 'scd.lpc_irq=3', 'scd.lpc_res_addr=0xf00000', 'scd.lpc_res_size=0x100000', 'block_flash=pci0000:00/0000:00:14.7/mmc_host/.*$', 'block_usb1=pci0000:00/0000:00:12.0/usb1/1-1/1-1.1/.*$', 'block_usb2=pci0000:00/0000:00:12.0/usb1/1-1/1-1.4/.*$', 'block_drive=pci0000:00/0000:00:11.0/.*host./target.:0:0/.*$', 'sid=RaspberryIsland16', 'log_buf_len=2M', 'systemd.show_status=0', 'sdhci.append_quirks2=0x40', 'amd_iommu=off', 'nvme_core.default_ps_max_latency_us=0', 'SWI=/mnt/flash/EOS-4.34.1F.swi', 'arista.asu_hitless']
            Proceeding with reload
            No qualified FPGAs to upgrade #(3)!
            waiting for platform processing ..........................................................ok
            Shutting down packet drivers
            2024-07-31 17:52:54.117479 bringing fab down
            2024-07-31 17:52:54.437128 bringing fifo down
            reloading /mnt/flash/EOS-4.34.1F.swi #(4)!
            Shutting down management interface(s)
            1 block
            umount: /mnt/flash: target is busy.
            [71576.090602][T15227] kexec_core: Starting new kernel
            [    2.363505][  T296] Running e2fsck on: /mnt/flash
            [    2.803117][  T303] e2fsck on /mnt/flash took 1s
            [    3.116739][  T370] Running e2fsck on: /mnt/crash
            [    3.181814][  T375] e2fsck on /mnt/crash took 0s
            Mounting SWIM Filesystem
            Optimization Strata-4GB root squash found
            Optimization Strata-4GB all squashes found
            Mounting optimization Strata-4GB #(5)!
            Switching rootfs
            Welcome to Arista Networks EOS 4.34.1F
            Architecture: i386
            [   43.938521] sh[2099]: Starting EOS initialization stage 1
            Starting NorCal initialization: [  OK  ]
            [   48.023047] sh[2181]: Starting EOS initialization stage 2
            Completing EOS initialization (press ESC to skip): [  OK  ]
            Model: CCS-710P-16P
            Serial Number: WTW22200366
            System RAM: 3952504 kB
            Flash Memory size:  7.1G

            pod00-leaf1a login:



            Wait for the SSU process to complete. This can take up to 10 minute.  When you see the following console message, the switch management plane has finished its reboot.


            pod00-leaf1a login:
        ```

        1. Remember the mention, there may still be some mention of ASU in the code. This is the SSU process kicking off.
        2. Extracting the boot image we configured
        3. No FPGAs to upgrade, recall if there were, this would require a full reload!
        4. Reloading the management and control plane to the new software image
        5. Mounting the software on to the hardware, `Strata` in this case is the family of ASICs

12. You can now login with the username/password and type `enable` to get back to privileged commands mode. Check the new current running version of the switch with the command `show version`. You should see the switch has upgraded to `EOS-4.34.1F`

    ???+ quote "Example Output"

        ```yaml hl_lines="7"
        Arista CCS-710P-16P
        Hardware version: 11.04
        Serial number: WTW23350461
        Hardware MAC address: 2cdd.e9f6.e9f2
        System MAC address: 2cdd.e9f6.e9f2

        Software image version: 4.34.1F
        Architecture: i686
        Internal build version: 4.34.1F-37710335.4314M
        Internal build ID: d26721db-c526-41ec-bf9d-0a14b4edfcf5
        Image format version: 3.0
        Image optimization: Strata-4GB

        Uptime: 5 minutes
        Total memory: 3952504 kB
        Free memory: 2880904 kB
        ```

13. After the management plane boots up, there are still some processes running before SSU can be considered successful. Run the following command to watch for the log message indicating SSU is fully successful. You should see the message `reload hitless reconciliation complete` about 2 minutes after the switch completes its reload.

    ```yaml
    show log follow | inc hitless
    ```

    ???+ quote "Example Output"

        ```yaml hl_lines="2"
        campus-pod11-leaf1a#show log follow | inc hitless
        Aug  8 19:51:59 campus-pod11-leaf1a StageMgr: %LAUNCHER-6-BOOT_STATUS: 'reload hitless' reconciliation complete.
        ```

14. As our final step, take another look at the terminal window that was running the consistent pings. You should see pings continue to flow without issue during the upgrade. Only towards the end of the process you may see 1 or 2 pings lost as the ASIC reconnects to the updated management plane.

    !!! success "800 ms Cutover 🏎️"

        The below example output was sending pings every 100ms, as you see below the cutover time to the new EOS image disrupted the dataplane for all of 700-800ms!! This is fast enough you may not even notice the disruption on an active zoom call!

    ???+ quote "Example Output"

        ```yaml hl_lines="10-17"
        me@MacBook-Pro ~ % ping -i 0.1 10.0.111.1
        64 bytes from 9.9.9.9: icmp_seq=0 ttl=51 time=10.974 ms
        64 bytes from 9.9.9.9: icmp_seq=1 ttl=51 time=10.147 ms
        64 bytes from 9.9.9.9: icmp_seq=2 ttl=51 time=10.583 ms
        64 bytes from 9.9.9.9: icmp_seq=3 ttl=51 time=10.657 ms
        ... truncated for brevity
        64 bytes from 9.9.9.9: icmp_seq=4885 ttl=51 time=10.586 ms
        64 bytes from 9.9.9.9: icmp_seq=4886 ttl=51 time=10.954 ms
        64 bytes from 9.9.9.9: icmp_seq=4887 ttl=51 time=10.632 ms
        Request timeout for icmp_seq 4888
        Request timeout for icmp_seq 4889
        Request timeout for icmp_seq 4890
        Request timeout for icmp_seq 4891
        Request timeout for icmp_seq 4892
        Request timeout for icmp_seq 4893
        Request timeout for icmp_seq 4894
        Request timeout for icmp_seq 4895
        64 bytes from 9.9.9.9: icmp_seq=4896 ttl=51 time=11.481 ms
        64 bytes from 9.9.9.9: icmp_seq=4897 ttl=51 time=11.637 ms
        64 bytes from 9.9.9.9: icmp_seq=4898 ttl=51 time=11.237 ms
        64 bytes from 9.9.9.9: icmp_seq=4899 ttl=51 time=10.859 ms
        64 bytes from 9.9.9.9: icmp_seq=4900 ttl=51 time=10.595 ms
        64 bytes from 9.9.9.9: icmp_seq=4901 ttl=51 time=10.516 ms
        ```

15. We see from this example output above, only 8 pings were lost (100 ms each) at the end of the process near the 10 minute mark after starting the ping test. If you we're pinging at 1 per second, you should see 1 maybe 2 pings drop.

16. As a last item to leave you with, you can validate your reload reason to confirm why the switch last reloaded using the command below.

    ```yaml
    show reload cause
    ```

    ???+ quote "Example Output"

        ```yaml hl_lines="3 7"
        Reload Cause 1:
        -------------------
        Hitless reload requested by the user.

        Reload Time:
        ------------
        Reload occurred at Thu Jan 23 11:08:51 2025 CST.

        Recommended Action:
        -------------------
        No action necessary.

        Debugging Information:
        -------------------------------
        None available.
        ```

## 🤖 AI Lab Assistant

Want to automate all the commands above? Use our embedded AI agent to execute the entire lab automatically!

<div id="lab-agent-container">
    <div class="agent-header">
        <h3>🚀 B04 Lab Automation Agent</h3>
        <p>Let the AI handle the SSU upgrade while you focus on learning the concepts!</p>
    </div>

    <div class="agent-controls">
        <div class="connection-section">
            <label for="student-select">Select Student:</label>
            <select id="student-select">
                <option value="1">Student 1 (Pod 01)</option>
                <option value="2">Student 2 (Pod 02)</option>
                <option value="3">Student 3 (Pod 03)</option>
                <option value="4">Student 4 (Pod 04)</option>
                <option value="5">Student 5 (Pod 05)</option>
                <option value="6">Student 6 (Pod 06)</option>
                <option value="7">Student 7 (Pod 07)</option>
                <option value="8">Student 8 (Pod 08)</option>
                <option value="9">Student 9 (Pod 09)</option>
                <option value="10">Student 10 (Pod 10)</option>
                <option value="11">Student 11 (Pod 11)</option>
                <option value="12">Student 12 (Pod 12)</option>
                <option value="13">Student 13 (Pod 13)</option>
                <option value="14">Student 14 (Pod 14)</option>
                <option value="15">Student 15 (Pod 15)</option>
                <option value="16">Student 16 (Pod 16)</option>
                <option value="17">Student 17 (Pod 17)</option>
                <option value="18">Student 18 (Pod 18)</option>
                <option value="19">Student 19 (Pod 19)</option>
                <option value="20">Student 20 (Pod 20)</option>
            </select>

            <label for="mode-select">Execution Mode:</label>
            <select id="mode-select">
                <option value="interactive">Interactive (Recommended)</option>
                <option value="auto">Automatic Demo</option>
            </select>

            <button id="connect-btn" class="agent-btn primary">🔌 Connect & Start Lab</button>
            <button id="stop-btn" class="agent-btn secondary" disabled>⏹️ Stop</button>
        </div>

        <div class="progress-section">
            <div class="progress-bar">
                <div id="progress-fill" class="progress-fill"></div>
            </div>
            <div id="progress-text" class="progress-text">Ready to start...</div>
        </div>

        <div class="output-section">
            <div class="output-header">
                <h4>🖥️ SSU Lab Execution Output</h4>
                <button id="clear-btn" class="agent-btn secondary">Clear</button>
            </div>
            <div id="command-output" class="command-output"></div>
        </div>
    </div>
</div>

<style>
#lab-agent-container {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 12px;
    padding: 24px;
    margin: 24px 0;
    color: white;
    box-shadow: 0 8px 32px rgba(0,0,0,0.1);
}

.agent-header {
    text-align: center;
    margin-bottom: 24px;
}

.agent-header h3 {
    margin: 0 0 8px 0;
    font-size: 1.5em;
    color: white;
}

.agent-header p {
    margin: 0;
    opacity: 0.9;
    font-size: 1.1em;
}

.connection-section {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 16px;
    margin-bottom: 20px;
    align-items: end;
}

.connection-section label {
    font-weight: 600;
    margin-bottom: 4px;
    display: block;
}

.connection-section select {
    padding: 8px 12px;
    border: none;
    border-radius: 6px;
    background: rgba(255,255,255,0.9);
    color: #333;
    font-size: 14px;
}

.agent-btn {
    padding: 10px 20px;
    border: none;
    border-radius: 6px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    font-size: 14px;
}

.agent-btn.primary {
    background: #4CAF50;
    color: white;
}

.agent-btn.primary:hover:not(:disabled) {
    background: #45a049;
    transform: translateY(-2px);
}

.agent-btn.secondary {
    background: rgba(255,255,255,0.2);
    color: white;
    border: 1px solid rgba(255,255,255,0.3);
}

.agent-btn.secondary:hover:not(:disabled) {
    background: rgba(255,255,255,0.3);
}

.agent-btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
}

.progress-section {
    margin: 20px 0;
}

.progress-bar {
    background: rgba(255,255,255,0.2);
    border-radius: 10px;
    height: 8px;
    overflow: hidden;
    margin-bottom: 8px;
}

.progress-fill {
    background: linear-gradient(90deg, #4CAF50, #8BC34A);
    height: 100%;
    width: 0%;
    transition: width 0.3s ease;
    border-radius: 10px;
}

.progress-text {
    font-size: 14px;
    opacity: 0.9;
    text-align: center;
}

.output-section {
    margin-top: 20px;
}

.output-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 12px;
}

.output-header h4 {
    margin: 0;
    font-size: 1.1em;
}

.command-output {
    background: rgba(0,0,0,0.3);
    border-radius: 6px;
    padding: 16px;
    font-family: 'Courier New', monospace;
    font-size: 13px;
    line-height: 1.4;
    max-height: 400px;
    overflow-y: auto;
    border: 1px solid rgba(255,255,255,0.1);
}

.command-output .system { color: #81C784; }
.command-output .success { color: #4CAF50; font-weight: bold; }
.command-output .error { color: #F44336; font-weight: bold; }
.command-output .warning { color: #FF9800; }
.command-output .info { color: #2196F3; }
.command-output .step { color: #E1BEE7; font-weight: bold; }
.command-output .command { color: #FFD54F; font-family: monospace; }
</style>

<script>
class B04LabAgent {
    constructor() {
        this.commands = [
            {
                section: "Initial Connection & Setup",
                commands: [
                    { cmd: "ssh arista@pod##-leaf1", desc: "Connect to leaf switch via SSH", output: "pod##-leaf1 login: arista\nLast login: Tue Jul 30 22:16:56 on ttyS0" },
                    { cmd: "enable", desc: "Enter privileged mode", output: "pod##-leaf1#" }
                ]
            },
            {
                section: "Pre-upgrade Assessment",
                commands: [
                    { cmd: "show version", desc: "Check current EOS version", output: "Arista CCS-710P-16P\nHardware version: 11.02\nSoftware image version: 4.34.0F\nUptime: 2 hours and 5 minutes" },
                    { cmd: "dir", desc: "List flash filesystem contents", output: "Directory of flash:/\n-rwx   894262536   May 5 14:16  EOS-4.34.0F.swi\n7527178240 bytes total (2043318272 bytes free)" },
                    { cmd: "show reload fast-boot", desc: "Check SSU compatibility", output: "No warnings or unsupported configuration found." }
                ]
            },
            {
                section: "EOS Image Download",
                commands: [
                    { cmd: "copy https://ztp-acws.duckdns.org/images/EOS-4.34.1F.swi flash:", desc: "Download new EOS image to flash", output: "Downloading EOS-4.34.1F.swi...\n████████████████████████████████ 100%\nCopy completed successfully." }
                ]
            },
            {
                section: "SSU Configuration",
                commands: [
                    { cmd: "configure", desc: "Enter configuration mode", output: "pod##-leaf1(config)#" },
                    { cmd: "boot system flash:EOS-4.34.1F.swi", desc: "Set new boot image", output: "pod##-leaf1(config)#" },
                    { cmd: "exit", desc: "Exit configuration mode", output: "pod##-leaf1#" },
                    { cmd: "write", desc: "Save configuration", output: "Copy completed successfully." }
                ]
            },
            {
                section: "Ping Test Setup",
                commands: [
                    { cmd: "ping 10.1.##.1", desc: "Start continuous ping test (background)", output: "PING 10.1.##.1: 56 data bytes\n64 bytes from 10.1.##.1: icmp_seq=0 ttl=64 time=1.234 ms\n64 bytes from 10.1.##.1: icmp_seq=1 ttl=64 time=1.156 ms" }
                ]
            },
            {
                section: "SSU Execution",
                commands: [
                    { cmd: "reload fast-boot now", desc: "Execute Smart System Upgrade", output: "Running AsuPatchDb:doPatch( version=4.34.0F )\nOptimizing image for current system...\nNo warnings or unsupported configuration found.\nProceeding with reload\nreloading /mnt/flash/EOS-4.34.1F.swi" }
                ]
            },
            {
                section: "Post-upgrade Verification",
                commands: [
                    { cmd: "show version", desc: "Verify new EOS version", output: "Arista CCS-710P-16P\nSoftware image version: 4.34.1F\nUptime: 5 minutes" },
                    { cmd: "show log follow | inc hitless", desc: "Monitor SSU completion", output: "StageMgr: %LAUNCHER-6-BOOT_STATUS: 'reload hitless' reconciliation complete." },
                    { cmd: "show reload cause", desc: "Verify reload reason", output: "Reload Cause 1:\nHitless reload requested by the user.\nReload occurred at Thu Jan 23 11:08:51 2025 CST." }
                ]
            }
        ];

        this.isRunning = false;
        this.currentSection = 0;
        this.currentCommand = 0;
        this.mode = 'interactive';
        this.studentId = '1';

        this.initializeEventListeners();
    }

    initializeEventListeners() {
        document.getElementById('connect-btn').addEventListener('click', () => this.startLab());
        document.getElementById('stop-btn').addEventListener('click', () => this.stopLab());
        document.getElementById('clear-btn').addEventListener('click', () => this.clearOutput());
    }

    async startLab() {
        this.studentId = document.getElementById('student-select').value;
        this.mode = document.getElementById('mode-select').value;

        document.getElementById('connect-btn').disabled = true;
        document.getElementById('stop-btn').disabled = false;

        this.isRunning = true;
        this.currentSection = 0;
        this.currentCommand = 0;

        this.updateProgress(0, "Connecting to leaf switch...");
        this.addOutput(`🔌 Connecting to pod${this.studentId.padStart(2, '0')}-leaf1 switch...`, 'system');

        // Simulate connection
        await this.sleep(2000);
        this.addOutput(`✅ Connected successfully to pod${this.studentId.padStart(2, '0')}-leaf1!`, 'success');
        this.addOutput(`🚀 Starting Arista Smart System Upgrade (SSU) process...`, 'info');

        await this.runAllSections();
    }

    async runAllSections() {
        const totalCommands = this.commands.reduce((sum, section) => sum + section.commands.length, 0);
        let commandCount = 0;

        for (let sectionIndex = 0; sectionIndex < this.commands.length && this.isRunning; sectionIndex++) {
            this.currentSection = sectionIndex;
            const section = this.commands[sectionIndex];

            this.addOutput(`\n📋 ${section.section}`, 'step');
            this.addOutput(`${'='.repeat(50)}`, 'system');

            for (let cmdIndex = 0; cmdIndex < section.commands.length && this.isRunning; cmdIndex++) {
                this.currentCommand = cmdIndex;
                const command = section.commands[cmdIndex];
                commandCount++;

                const progress = (commandCount / totalCommands) * 100;
                this.updateProgress(progress, `Executing: ${command.cmd}`);

                await this.executeCommand(command, commandCount, totalCommands);

                if (this.mode === 'interactive' && !command.cmd.includes('reload fast-boot')) {
                    this.addOutput(`   ⏸️  Paused for review - Click any key to continue...`, 'warning');
                    await this.waitForUserInput();
                } else {
                    await this.sleep(this.mode === 'auto' ? 1500 : 2000);
                }
            }

            if (this.isRunning) {
                this.addOutput(`\n🎉 Section "${section.section}" completed successfully!\n`, 'success');
            }
        }

        if (this.isRunning) {
            this.updateProgress(100, "SSU Lab completed successfully! 🎉");
            this.addOutput(`\n🏆 B04 Smart System Upgrade Lab completed successfully!`, 'success');
            this.addOutput(`📊 Ping test results: Only 1-2 packets lost during ~800ms cutover!`, 'info');
            this.addOutput(`🚀 Switch upgraded from EOS-4.34.0F to EOS-4.34.1F with minimal downtime!`, 'success');
        }

        this.stopLab();
    }

    async executeCommand(command, stepNum, totalSteps) {
        // Replace ## with actual pod number
        const actualCmd = command.cmd.replace(/##/g, this.studentId.padStart(2, '0'));
        const actualOutput = command.output.replace(/##/g, this.studentId.padStart(2, '0'));

        this.addOutput(`\n🔄 Step ${stepNum}/${totalSteps}: ${command.desc}`, 'info');
        this.addOutput(`   💻 ${actualCmd}`, 'command');

        // Special handling for different command types
        if (command.cmd.includes('copy https://')) {
            await this.simulateDownload();
        } else if (command.cmd.includes('reload fast-boot')) {
            await this.simulateSSUReload();
        } else if (command.cmd.includes('ping')) {
            await this.simulatePingTest();
        } else {
            await this.sleep(1000);
        }

        this.addOutput(`   📤 ${actualOutput}`, 'system');
        this.addOutput(`   ✅ Command executed successfully`, 'success');
    }

    async simulateDownload() {
        this.addOutput(`   📥 Starting EOS image download...`, 'info');
        const progressChars = ['▱', '▰'];
        
        for (let i = 0; i <= 100; i += 10) {
            if (!this.isRunning) break;
            
            const filled = Math.floor(i / 3.125);
            const empty = 32 - filled;
            const progressBar = '▰'.repeat(filled) + '▱'.repeat(empty);
            
            this.addOutput(`   📊 Download Progress: [${progressBar}] ${i}%`, 'info');
            await this.sleep(200);
        }
        
        this.addOutput(`   ✅ EOS-4.34.1F.swi downloaded successfully (1.5GB)`, 'success');
    }

    async simulateSSUReload() {
        this.addOutput(`   ⚠️  CRITICAL: Starting Smart System Upgrade - DO NOT INTERRUPT!`, 'warning');
        this.addOutput(`   🔄 Running AsuPatchDb:doPatch...`, 'info');
        await this.sleep(2000);
        
        this.addOutput(`   📦 Extracting kernel files from SWI...`, 'info');
        await this.sleep(1500);
        
        this.addOutput(`   🔍 No qualified FPGAs to upgrade`, 'info');
        await this.sleep(1000);
        
        this.addOutput(`   📡 Shutting down packet drivers...`, 'warning');
        await this.sleep(1000);
        
        this.addOutput(`   🔄 Reloading /mnt/flash/EOS-4.34.1F.swi`, 'info');
        await this.sleep(3000);
        
        this.addOutput(`   🖥️  Management plane rebooting...`, 'warning');
        await this.sleep(2000);
        
        this.addOutput(`   🔌 Reconnecting to switch...`, 'info');
        await this.sleep(2000);
        
        this.addOutput(`   ✅ Switch management plane back online!`, 'success');
    }

    async simulatePingTest() {
        this.addOutput(`   🏓 Starting continuous ping test to gateway...`, 'info');
        this.addOutput(`   📊 Ping will continue during SSU upgrade`, 'info');
        await this.sleep(1000);
        
        // Simulate some ping responses
        for (let i = 1; i <= 5; i++) {
            if (!this.isRunning) break;
            const time = (Math.random() * 2 + 0.5).toFixed(3);
            this.addOutput(`   🏓 64 bytes from 10.1.${this.studentId.padStart(2, '0')}.1: icmp_seq=${i} time=${time} ms`, 'system');
            await this.sleep(300);
        }
    }

    async waitForUserInput() {
        return new Promise(resolve => {
            const handler = () => {
                document.removeEventListener('keydown', handler);
                document.removeEventListener('click', handler);
                resolve();
            };
            document.addEventListener('keydown', handler);
            document.addEventListener('click', handler);
        });
    }

    stopLab() {
        this.isRunning = false;
        document.getElementById('connect-btn').disabled = false;
        document.getElementById('stop-btn').disabled = true;
        this.updateProgress(0, "Ready to start...");
    }

    clearOutput() {
        document.getElementById('command-output').innerHTML = '';
    }

    updateProgress(percentage, text) {
        document.getElementById('progress-fill').style.width = `${percentage}%`;
        document.getElementById('progress-text').textContent = text;
    }

    addOutput(text, type = 'system') {
        const output = document.getElementById('command-output');
        const line = document.createElement('div');
        line.className = type;
        line.textContent = text;
        output.appendChild(line);
        output.scrollTop = output.scrollHeight;
    }

    sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }
}

// Initialize the lab agent when the page loads
document.addEventListener('DOMContentLoaded', function() {
    new B04LabAgent();
});
</script>

--8<-- "includes/abbreviations.md"
