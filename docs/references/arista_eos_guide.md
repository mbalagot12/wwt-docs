# EOS Overview and Tips for Network Operators

## Overview

Arista EOS (Extensible Operating System) is built on a foundation of quality, reliability, and programmability. This guide covers essential EOS features and practical tips for network operators.

### EOS Architecture

EOS features a unique architecture with several key advantages:

- **Decoupled State from Process**: Self-healing processes ensure system stability
- **Live Patching**: Updates without downtime
- **Unmodified Linux Kernel**: Full Linux compatibility
- **Industry Standard CLI**: Familiar command-line interface
- **Consistent API**: eAPI for automation
- **Access to Bash**: Direct Linux shell access

### Platform Flexibility

EOS runs across multiple deployment models:

| Platform | Use Case | Description |
|----------|----------|-------------|
| **Standard EOS** | Production Networks | Hardware + Software bundled solution |
| **vEOS** | Lab Simulation | EOS in a virtual machine |
| **cEOS** | Container Networks | EOS in a container |
| **CloudEOS** | Cloud Native | Multi-hypervisor cloud deployment |

### Quality Metrics

Over approximately 12 years of development:

- **1** OS version across all switching & routing platforms
- **8** Software regression bugs
- **30** Security advisories (CVEs)
- **2** Security advisories requiring downtime
- **~1,000** Quality control testbeds
- **230,000+** Auto-tests per day
- **<1%** EOS defect rate

## EOS Lifecycle

### Release Types

#### F Releases (New Feature Phase)
- Introduces new features and/or platforms
- Multiple releases for ongoing development
- Active development phase

#### M Releases (Maintenance Phase)
- Identified with "M" in version number
- Incremental fixes only
- No new functionality added
- Periodic releases as needed
- **30 months** support duration

#### Support Only Phase
- Software upgrade required for bug fixes
- **6 months** duration before end-of-life

## Basic System Commands

### System Information

#### Show Version
```bash
SWITCH#show version
```

Example output:
```
Arista CCS-720XP-48ZC2-F
Hardware version: 10.50
Serial number: JPE19181588
Hardware MAC address: fcbd.670f.3c31
System MAC address: fcbd.670f.3c31
Software image version: 4.31.3M
Architecture: i686
Internal build version: 4.31.3M-36737551.4313M
Internal build ID: c8d3a574-c649-455d-90a4-b2510051cf0d
Image format version: 3.0
Image optimization: Strata-4GB
Uptime: 8 hours and 4 minutes
Total memory: 3952980 kB
Free memory: 2220948 kB
```

#### System Environment
```bash
SWITCH#show system environment all
```

#### Interface Status
```bash
SWITCH#show interface ethernet1
```

### Configuration Management

#### Save Configuration
```bash
# Save running config to startup config
SWITCH#copy running-config startup-config

# Alternative method
SWITCH#write memory

# Short form
SWITCH#wr mem
```

#### Erase Startup Configuration
```bash
SWITCH#erase startup-config
```

### EOS Upgrades

#### Installation Process
1. Copy new EOS image to flash:
   ```bash
   # Verify current boot configuration
   EOS1#show boot-config
   ```

2. Install new image:
   ```bash
   EOS1(config)#install system flash:EOS-4.31.3M.swi
   ```

3. Reload the switch:
   ```bash
   EOS1(config)#reload
   ```

## Advanced CLI Features

### Show Active Configuration
View configuration for current context instead of full running-config:
```bash
SWITCH(config-if-Et1)#show active
```

Example output:
```
interface Ethernet1
   description EOS1
   mtu 9216
   no switchport
   ip address 10.1.18.18/24
```

### Event Monitor
Monitor changes to system tables in real-time:

#### Enable Event Monitor
```bash
SWITCH(config)#event-monitor
SWITCH(config)#event-monitor sync
```

#### View Event Monitor Data
```bash
SWITCH#show event-monitor arp
```

Automatically stores changes to:
- ARP tables
- IGMP snooping
- LACP
- MAC address tables
- Multicast routes
- Routes (IPv4/IPv6)
- Spanning Tree Protocol

### Watch Command
Real-time monitoring of command output:

#### Basic Watch
```bash
# Update every 2 seconds (default)
SWITCH#watch show ip arp

# Update every 1 second with diff highlighting
SWITCH#watch 1 diff show ip arp
```

#### Advanced Watch Example
```bash
# Watch MAC address table changes
SWITCH#watch 1 diff show mac address-table
```

### Command History
View command history for current session:
```bash
SWITCH#show history | begin conf
```

### CLI Command Discovery
Find available commands with grep filtering:
```bash
# Show all commands containing "distance"
SWITCH#show cli commands all-modes | grep -i distance
```

### CLI Scheduler

#### Default Tech-Support Collection
EOS automatically runs tech-support every 60 minutes:
```bash
SWITCH#show schedule tech-support
```

#### Custom Scheduler Examples

**Basic Interface Monitoring:**
```bash
SWITCH(config)#schedule show-int interval 10 max-log-files 10 command show interface counters
```

**Automated Backup with TFTP:**
```bash
SWITCH(config)#schedule backup-config interval 30 timeout 1 max-log-files 10 command bash sudo ip netns exec ns-MGMT tftp 172.31.0.8 -c put /mnt/flash/startup-config $(hostname)_$(date +%Y-%m-%d-%H%M.%S.txt)
```

### Support Bundle Generation
Generate comprehensive support bundle for TAC:
```bash
# Basic support bundle to flash
SWITCH#send support-bundle flash:

# Support bundle with case number
SWITCH#send support-bundle flash: case-number 123456

# Available destinations
SWITCH#send support-bundle ?
# flash:, ftp:, http:, https:, scp:, sftp:, tftp:
```

## Configuration Analysis Tools

### Configuration Differences
Compare running and startup configurations:
```bash
SWITCH#show running-config diffs
```

Example output:
```diff
--- flash:/startup-config
+++ system:/running-config
@@ -70,7 +70,9 @@
 no switchport
 !
 interface Ethernet10
- no switchport
+ description Whoops...should have saved this
+ switchport mode trunk
+ switchport
```

### Non-Zero Values Filter
Show only non-zero statistics:
```bash
SWITCH#show interfaces counters rates | nz
```

### Sanitized Configuration
Remove passwords and sensitive data for sharing:
```bash
SWITCH#show running-config sanitized
```

Example:
```bash
# Before sanitization
SWITCH#show run sec snmp
snmp-server community asdf1234asdf ro

# After sanitization  
SWITCH#show run sanitized sec snmp
snmp-server community <removed> ro
```

## Configuration Sessions

Configuration sessions allow batch application of changes:

### Create Configuration Session
```bash
SWITCH#configure session MySession
SWITCH(config-s-mysess)#
```

### Review Changes
```bash
SWITCH#show session-config diffs
```

### Commit Changes
```bash
# Immediate commit
SWITCH(config-s-mysess)#commit

# Commit with auto-rollback timer
SWITCH(config-s-mysess)#commit timer 00:05:00

# Confirm commit (if timer was set)
SWITCH#configure session MySession commit
```

### Configuration Checkpoints

#### List Previous Commits
```bash
SWITCH#show configuration checkpoints
```

#### View Previous Configuration
```bash
SWITCH#more checkpoint:ckp-20240513-0
```

#### Rollback to Previous Configuration
```bash
SWITCH#configure checkpoint restore ckp-20240513-0
```

## Advanced CLI Techniques

### Multiple Commands
Execute multiple commands in sequence:
```bash
SWITCH#run show version; show ip int brief; show int e5
```

#### Advanced Multi-Command with Watch
```bash
SWITCH#watch 1 diff run show int e48 counters rates | nz;!;!; show int e48 counters queue detail
```

*Tip: Use `;!;!` to create buffer space between command outputs*

### Structured Data Output
Convert command output to JSON format:
```bash
SWITCH#show version | json
```

Example JSON output:
```json
{
  "mfgName": "Arista",
  "modelName": "DCS-7280SR3K-48YC8-F",
  "hardwareRevision": "11.02",
  "serialNumber": "JPE21043548",
  "systemMacAddress": "94:8e:d3:51:77:94",
  "version": "4.31.1F",
  "architecture": "x86_64",
  "uptime": 9452806.97,
  "memTotal": 65734516,
  "memFree": 61283092
}
```

### VRF Context
Set CLI to operate within a specific VRF context:
```bash
SWITCH#cli vrf MGMT
SWITCH(vrf:MGMT)#show ip route
SWITCH(vrf:MGMT)#ping 172.31.0.1
```

## Event Handlers

Event handlers allow automated responses to system events:

### Event Handler Components
- **Trigger**: Condition that activates the handler
- **Action**: Response when trigger condition is met

#### Available Actions
```bash
SWITCH(config-handler-config-backup)#action ?
# bash    - Define BASH command action
# increment - Define INCREMENT command action  
# log     - Log a message when triggered
```

#### Available Triggers
```bash
SWITCH(config-handler-config-backup)#trigger ?
# on-boot           - System boot
# on-config         - Handler configuration
# on-counters       - Statistical counter evaluation
# on-intf           - Interface changes
# on-logging        - Log message regex match
# on-maintenance    - Maintenance operations
# on-startup-config - Startup config changes
# vm-tracer         - VmTracer events
```

### Configuration Backup Example
Automatically backup configuration when user exits config mode:
```bash
SWITCH(config)#event-handler config-backup
SWITCH(config-handler-config-backup)#action bash
FastCli -p 15 -c 'copy running-config flash:staged_backup'
sudo ip netns exec ns-MGMT tftp 172.31.0.8 -c put /mnt/flash/staged_backup $(hostname)_$(date +%Y-%m-%d-%H%M.%S.txt)
EOF
SWITCH(config-handler-config-backup)#delay 1
SWITCH(config-handler-config-backup)#trigger on-logging
SWITCH(config-handler-config-backup-on-logging)#regex .*SYS-5-CONFIG_I.*Configured from.*
```

## Command Aliases

### Basic Alias Creation
```bash
SWITCH#alias whatsdiff show run diffs | include ^\+|^\-
```

### Alias with Variables
```bash
SWITCH(config)#alias shporc show port-channel %1 detail
```

Usage:
```bash
SWITCH#shporc 10
```

### Advanced Regex Aliases
```bash
# Port-channel summary alias
SWITCH(config)#alias "sh port-c sum"
SWITCH(config-alias-regex)#10 show port-channel dense

# VRF-aware interface brief
SWITCH(config)#alias "sh ip int br vrf (\w+)"
SWITCH(config-alias-regex)#10 show ip interface vrf %1 brief
```

## Hardware Diagnostics

### Cable Testing (Base-T)
Test Ethernet cables remotely:
```bash
SWITCH#test l1 cable base-t interfaces e17
```

View cable test results:
```bash
SWITCH#show interfaces e17 cable detail
```

Example output:
```
Ethernet17
Cable test runs: 1
Cable length accuracy: +/-10m
Current State Changes Last Change
Diagnostics status completed 2 0:00:07 ago
Cable status ok 1 0:00:07 ago
Length of pair A 47m 1 0:00:07 ago
Length of pair B 39m 1 0:00:07 ago
```

*Note: Cable testing will cause the interface to flap*

### Transceiver Simulation
Simulate transceiver removal without physical access:
```bash
SWITCH(config-if-Et49/1)#transceiver diag simulate removed
SWITCH(config-if-Et49/1)#show interface e49/1 status

# Restore transceiver
SWITCH(config-if-Et49/1)#no transceiver diag simulate removed
```

### LED Identification
Flash LEDs to identify hardware components:
```bash
# Flash interface LED
SWITCH#locator-led interface ethernet 1

# Flash fan tray LED
SWITCH#locator-led fantray 1

# Flash power supply LED  
SWITCH#locator-led powersupply 1
```

### Interface Capabilities
View interface speed and feature capabilities:
```bash
# Show default capabilities
SWITCH#show int e9/1 hardware default

# Show current transceiver capabilities
SWITCH#show int e9/1 hardware
```

## Monitoring and Troubleshooting

### Command Audit Trail
View detailed command history with user attribution:
```bash
SWITCH#show aaa accounting logs
```

Filter by time range or username:
```bash
SWITCH#show aaa accounting logs username mitch
```

### Real-time Log Monitoring
Follow system logs in real-time:
```bash
# Basic log following
SWITCH#show logging follow

# Filtered log following
SWITCH#show logging follow | grep -i ethernet
```

### Packet Capture

#### Control-Plane Capture
All platforms support control-plane packet capture:

1. **Create Monitor Session:**
   ```bash
   SWITCH(config)#monitor session test-sess source Ethernet2
   SWITCH(config)#monitor session test-sess destination cpu
   ```

2. **Verify Monitor Session:**
   ```bash
   SWITCH#show monitor session
   ```

3. **Start Packet Capture:**
   ```bash
   SWITCH#tcpdump interface mirror0
   ```

#### Advanced Capture Options
```bash
SWITCH#tcpdump ?
# file          - Set output file
# filecount     - Number of output files
# filter        - Filtering expression
# interface     - Interface to monitor
# packet-count  - Limit number of packets
# size          - Maximum bytes per packet
# verbose       - Enable verbose mode
```

#### Remote Live Capture
Stream packet capture directly to Wireshark:

**Windows:**
```cmd
plink -l admin -pw admin -batch 172.31.0.28 "bash sudo tcpdump -s 0 -Un -w - -i mirror0" | wireshark -k -i - -o "gui.window_title:Eth1"
```

**macOS/Linux:**
```bash
ssh admin@172.31.0.28 "bash sudo tcpdump -s 0 -Un -w - -i mirror0" | wireshark -k -i - -o "gui.window_title:Eth1"
```

### Performance Testing

#### iPerf Network Testing
EOS includes iPerf for network performance testing:
```bash
SWITCH#bash
[arista@SWITCH ~]$ iperf --help
[arista@SWITCH ~]$ iperf --version
```

*Note: Throughput is limited by CPU-to-ASIC interface capacity*

## Advanced Troubleshooting

### Agent Logs
Access detailed per-agent logging:

#### List Available Agent Logs
```bash
SWITCH#bash ls /var/log/agents
```

#### View Specific Agent Log
```bash
SWITCH#bash more /var/log/agents/Acl-3671
```

#### QuickTrace Analysis
For detailed debugging (typically used with TAC support):
```bash
SWITCH#bash qtcat /var/log/qt/Acl.qt | more
```

## Best Practices

### Configuration Management
1. Always save configurations after changes: `copy running-config startup-config`
2. Use configuration sessions for complex changes
3. Test changes with commit timers for automatic rollback
4. Regular configuration backups using event handlers

### Monitoring
1. Enable event monitoring for change tracking
2. Use scheduled commands for regular health checks
3. Implement custom aliases for frequently used command sequences
4. Leverage structured data output for automation

### Troubleshooting
1. Use `show active` instead of full running-config in specific contexts
2. Filter outputs with `nz` for relevant non-zero values
3. Utilize real-time monitoring with `watch` command
4. Generate support bundles for TAC cases with complete system state

### Security
1. Use `sanitized` output when sharing configurations
2. Implement command accounting for audit trails
3. Regular review of system logs with filtering
4. Proper access control and authentication

## Conclusion

Arista EOS provides a comprehensive set of tools and features for network operation and troubleshooting. The combination of Linux-based architecture, extensive CLI capabilities, and built-in automation features makes EOS a powerful platform for modern network infrastructure.

Key advantages include:
- Unmatched software quality and reliability
- Extensive troubleshooting and monitoring capabilities
- Flexible deployment options across physical and virtual environments
- Rich automation and programmability features
- Comprehensive support and diagnostic tools

For additional information and updates, refer to the official Arista documentation and support resources.