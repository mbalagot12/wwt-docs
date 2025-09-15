# Campus Lab Overview

Welcome to the Arista Campus Workshop! You've made it to our hands-on lab environment where you'll get practical experience with real Arista hardware and software.

In front of you is a complete campus network pod featuring Arista switches running the same EOS operating system found in our enterprise-grade chassis switches, along with wireless access points and all the tools needed for a comprehensive campus networking experience.

Throughout this workshop, you'll work collaboratively with your assigned lab partner to explore both wired and wireless campus solutions, from initial device provisioning through advanced security configurations. Each pod is equipped with dedicated instances of Arista's cloud management platforms, giving you the full production experience.

Get ready to dive into real-world scenarios including Zero-Touch Provisioning, CloudVision management, wireless deployment with CV-CUE, and network security with AGNI!

In total there are:

- [x] 1 x Student assigned per pod
- [x] Up to 20 x Arista Campus Pods

## Topology

![Network Topology](../assets/images/topology/atd_student-light.png#only-light)
![Network Topology](../assets/images/topology/atd_student-light.png#only-dark)

## Equipment

The hardware you see sitting in front of you can

<div class="grid cards" markdown>

- :cloudvision: **Lab Software**

    ---

    Except for CVaas, each pod will be provided their own instance of:

      - [x] **Arista CloudVision as a Service (CVaaS)** - Our management, orchestration, and visibility
      - [x] **Arista CloudVision Cognitive Unified Edge (CV-CUE)** - Our wireless management, orchestration, and visibility
      - [x] **Arista Guardian Network Identity (AGNI)** - Our Network Access Control

- :fontawesome-solid-flask: **Lab Hardware**

    ---

    The hardware you see sitting in front of you:

      - [x] 2 x C-230 controllerless AP
      - [x] 1 x 710P-12P running EOS

- :fontawesome-solid-user: **Student Equipment**

    ---

    As part of this lab workshop, it was recommended to have brought the following:

      - [x] Laptop
      - [x] Extra screen (optional)
      - [x] USB/USB-C Ethernet dongle
      - [x] Ethernet Cable
      - [x] Console Cable

- :octicons-tasklist-24: **Student Config**

    ---

    You will work in collaboration with your fellow student, keep this information handy

      - [x] Student a or b. See Lab Assignment
      - [x] Your POD number. See Lab Assignment
      - [x] Your assigned spine login. See Lab Assignment
      - [x] Your LOGIN ID to Arista Launchpad. Your corporate email address
      - [x] Your PASSWORD. Emailed to you upon Arista Launchpad account creation

</div>

## Lab Assignment

<div class="grid cards" markdown>
 {{ read_csv('data/lab_assignment.csv',colalign=("left","center","center"), usecols=['Email','Lab Assignment','Student Pod #']) }}
</div>

--8<--
docs/snippets/login_cv.md
--8<--
