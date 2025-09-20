# Arista Campus Workshop

Welcome to our Arista hands-on campus workshop! 🚀

We appreciate your desire to get your hands dirty and diving into the Arista campus solutions. Over the next two days, you'll have the opportunity to work with real hardware and software, just as it's deployed in the field. Each lab is designed to simulate real-world scenarios, giving you practical experience. Whether you're deploying and configuring switches, operating the network, or troubleshooting client connectivity issues, you'll gain a better understanding of the campus lifecycle. Get ready to dive in, experiment, and learn by doing!

<div class="hero-banner">
    <div class="hero-container">

        <div class="hero-background"></div>

        <div class="hero-decorations">
            <div class="switch-element switch-1"></div>
            <div class="switch-element switch-2"></div>
            <div class="switch-element switch-3"></div>
        </div>

        <div class="hero-lines">
            <div class="pulse-line line-1"></div>
            <div class="pulse-line line-2"></div>
            <div class="pulse-line line-3"></div>
        </div>

        <div class="hero-badge">
            Hands-On Experience
        </div>

        <div class="hero-content">
            <div class="hero-brand">ARISTA</div>
            <h1 class="hero-title">Campus Workshop</h1>
            <p class="hero-subtitle">Master Modern Campus Networking Solutions<br class="hero-break">Real Hardware • Real Scenarios • Real Results</p>

            <div class="solutions-grid">
                <div class="solution-card">
                    <div class="solution-icon">🔌</div>
                    <div class="solution-title">Wired Solutions</div>
                    <div class="solution-desc">EOS, ZTP, CloudVision Studios</div>
                </div>

                <div class="solution-card">
                    <div class="solution-icon">📡</div>
                    <div class="solution-title">Wireless Edge</div>
                    <div class="solution-desc">CV-CUE, WiFi 6E/7, AGNI</div>
                </div>

                <div class="solution-card">
                    <div class="solution-icon">🛡️</div>
                    <div class="solution-title">Security</div>
                    <div class="solution-desc">EAP-TLS, UPSK, Zero Trust</div>
                </div>

                <div class="solution-card">
                    <div class="solution-icon">📊</div>
                    <div class="solution-title">Observability</div>
                    <div class="solution-desc">Monitoring, Analytics, AI Insights</div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.hero-banner {
    width: 100%;
    margin: 20px 0;
}

.hero-container {
    width: 100%;
    min-height: 500px;
    background: linear-gradient(135deg, #0B1426 0%, #1E3A5F 50%, #2B5A87 100%);
    position: relative;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    border-radius: 12px;
    padding: 40px 20px;
}

.hero-background {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: radial-gradient(circle at 25% 25%, rgba(255,255,255,0.1) 2px, transparent 2px),
                      radial-gradient(circle at 75% 75%, rgba(255,255,255,0.05) 1px, transparent 1px);
    background-size: 60px 60px, 40px 40px;
    animation: float 20s ease-in-out infinite;
}

.hero-decorations {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    z-index: 5;
}

.switch-element {
    position: absolute;
    width: clamp(60px, 8vw, 80px);
    height: clamp(15px, 2vw, 20px);
    background: linear-gradient(45deg, #2196F3, #64B5F6);
    border-radius: 4px;
    box-shadow: 0 4px 15px rgba(33, 150, 243, 0.3);
}

.switch-1 {
    top: 15%;
    left: 10%;
    animation: float-switch 15s ease-in-out infinite;
}

.switch-2 {
    top: 25%;
    right: 15%;
    animation: float-switch 18s ease-in-out infinite reverse;
}

.switch-3 {
    bottom: 20%;
    left: 8%;
    animation: float-switch 12s ease-in-out infinite;
}

.hero-lines {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
}

.pulse-line {
    position: absolute;
    background: linear-gradient(90deg, transparent, rgba(79, 195, 247, 0.6), transparent);
    height: 2px;
    animation: pulse-line 3s ease-in-out infinite;
}

.line-1 {
    top: 30%;
    left: 20%;
    width: clamp(150px, 20vw, 200px);
    transform: rotate(25deg);
}

.line-2 {
    top: 60%;
    right: 25%;
    width: clamp(120px, 15vw, 150px);
    transform: rotate(-15deg);
}

.line-3 {
    bottom: 35%;
    left: 15%;
    width: clamp(140px, 18vw, 180px);
    transform: rotate(45deg);
}

.hero-badge {
    position: absolute;
    top: 20px;
    right: 20px;
    background: rgba(76, 175, 80, 0.9);
    color: white;
    padding: 8px 16px;
    border-radius: 25px;
    font-size: clamp(10px, 1.5vw, 14px);
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 1px;
    box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
    animation: pulse-badge 2s ease-in-out infinite;
    z-index: 10;
}

.hero-content {
    position: relative;
    z-index: 10;
    text-align: center;
    max-width: 1200px;
    width: 100%;
}

.hero-brand {
    color: #FFFFFF;
    font-size: clamp(24px, 6vw, 48px);
    font-weight: bold;
    letter-spacing: 2px;
    margin-bottom: 10px;
    text-shadow: 0 2px 10px rgba(0,0,0,0.3);
}

.hero-title {
    color: #FFFFFF !important;
    font-size: clamp(28px, 7vw, 56px);
    font-weight: 600;
    margin: 0 0 15px 0;
    text-shadow: 0 2px 10px rgba(0,0,0,0.3);
}

.hero-subtitle {
    color: #B8D4F0;
    font-size: clamp(14px, 3vw, 24px);
    font-weight: 400;
    margin-bottom: 30px;
    line-height: 1.4;
}

.hero-break {
    display: block;
}

.solutions-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-top: 30px;
    max-width: 900px;
    margin-left: auto;
    margin-right: auto;
}

.solution-card {
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 16px;
    padding: 20px 15px;
    text-align: center;
    transition: all 0.3s ease;
}

.solution-card:hover {
    transform: translateY(-5px);
    background: rgba(255, 255, 255, 0.15);
}

.solution-icon {
    font-size: clamp(32px, 5vw, 48px);
    margin-bottom: 12px;
    color: #4FC3F7;
    filter: drop-shadow(0 2px 4px rgba(0,0,0,0.3));
}

.solution-title {
    color: #FFFFFF;
    font-size: clamp(14px, 2vw, 16px);
    font-weight: 600;
    margin-bottom: 6px;
}

.solution-desc {
    color: #B8D4F0;
    font-size: clamp(10px, 1.5vw, 12px);
    line-height: 1.3;
}

@keyframes float {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-10px); }
}

@keyframes float-switch {
    0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 0.6; }
    50% { transform: translateY(-20px) rotate(2deg); opacity: 0.8; }
}

@keyframes pulse-line {
    0%, 100% { opacity: 0.3; }
    50% { opacity: 1; }
}

@keyframes pulse-badge {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.05); }
}

/* Mobile-specific adjustments */
@media (max-width: 768px) {
    .hero-container {
        min-height: 400px;
        padding: 30px 15px;
    }

    .hero-badge {
        top: 15px;
        right: 15px;
        padding: 6px 12px;
    }

    .hero-break {
        display: none;
    }

    .solutions-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 15px;
        margin-top: 25px;
    }

    .solution-card {
        padding: 15px 10px;
    }

    .switch-element {
        display: none;
    }

    .pulse-line {
        display: none;
    }
}

@media (max-width: 480px) {
    .hero-container {
        min-height: 350px;
        padding: 25px 10px;
    }

    .solutions-grid {
        grid-template-columns: 1fr;
        gap: 12px;
    }

    .solution-card {
        padding: 12px 8px;
    }
}
</style>

<div class="grid cards" markdown>

- :material-file-document-multiple:{ .lg .middle } **Lab Access**

    ---

    Your instructor will guide you with more details, but feel free to jump right in and understand what you have in front of you!

    [:material-login: Let's get started!](./lab/access.md){ .md-button .md-button--primary }

</div>

## :material-router-network: Wired Guides

<div class="grid cards" markdown>

- :cloudvision: **A01-Lab: Explore EOS**

    ---

    Get familiar with Arista's Extensible Operating System using the CLI

    [:material-login: Hop into A-01](./a_wired/a01_lab.md){ .md-button .md-button--primary }

<!-- - :cloudvision: **A02-Lab: Day 1 Operations**

    ---

    Get started with onboarding new Arista EOS switches using ZTP, CloudVision, and our Campus Studios.

    [:material-login: Hop into A-02](./a_wired/a02_lab.md){ .md-button .md-button--primary } -->

<!-- - :cloudvision: **A02-ATD-Lab: Day 1 Operations - Virtual Lab**

    ---

    Experience campus fabric provisioning using Arista Test Drive (ATD) virtual lab environment with CloudVision Studios.

    [:material-login: Hop into A-02-ATD](./a_wired/a02_atd.md){ .md-button .md-button--primary } -->

- :cloudvision: **A03-Lab: Day 2 Operations**

    ---

    Continue with day 2 operations, using CloudVision to manage campus port profiles, access port configuration, and streamlined task execution.

    [:material-login: Hop into A-03](./a_wired/a03_lab.md){ .md-button .md-button--primary }

- :cloudvision: **A04-Lab: Operations and Monitoring**

    ---

    The campus is deployed, explore the CloudVision observability, altering, troubleshooting, and more!

    [:material-login: Hop into A-04](./a_wired/a04_lab.md){ .md-button .md-button--primary }

</div>

## :material-wifi: Wireless Guides

<div class="grid cards" markdown>


- :cloudvision: **B01-Lab: Wireless Setup**

    ---

    Deploy and explore the features of CloudVision Cognitive Unified Edge (CV-CUE)

    [:material-login: Hop into B-01](./b_wireless/b01_lab.md){ .md-button .md-button--primary }

- :cloudvision: **B02-Lab: Troubleshooting WiFi**

    ---

    Explore the wireless client troubleshooting tools like packet capture and client testing

    [:material-login: Hop into B-02](./b_wireless/b02_lab.md){ .md-button .md-button--primary }

- :cloudvision: **B03-Lab: Guest WiFi with AGNI**

    ---

    Configure a guest WiFi SSID with a captive guest portal and tunnel wireless traffic

    [:material-login: Hop into B-03](./b_wireless/b03_lab.md){ .md-button .md-button--primary }

- :cloudvision: **B04-Lab: Smart System Upgrade**

    ---

    Using Arista EOS Smart System Upgrade (SSU) we can avoid downtime when upgrading our wired network!

    [:material-login: Hop into B-04](./b_wireless/b04_lab.md){ .md-button .md-button--primary }

</div>

## :material-security: Security Guides

<div class="grid cards" markdown>

- :cloudvision: **C01-Lab: EAP-TLS Wireless Policy**

    ---

    Use Arista AGNI to enforce wireless access via dot1x EAP-TLS policy on a given SSID

    [:material-login: Hop into C-01](./c_security/c01_lab.md){ .md-button .md-button--primary }

- :cloudvision: **C02-Lab: UPSK Wireless Policy**

    ---

    Configure unique pre-shared keys for an SSID and get familiar with device groupings

    [:material-login: Hop into C-02](./c_security/c02_lab.md){ .md-button .md-button--primary }

- :cloudvision: **C03-Lab: EAP-TLS Wired Policy**

    ---

    Using Arista AGNI to enforce wired access via dot1x EAP-TLS policy

    [:material-login: Hop into C-03](./c_security/c03_lab.md){ .md-button .md-button--primary }

<!-- - :cloudvision: **C04-Lab: Multi-Domain Segmentation Services**

    ---

    Using Arista Multi-Domain Segmentation Services (MSS) for standards-based, non-proprietary, intelligent and dynamic network segmentation

    [:material-login: Hop into C-04](./references/under_constructions.md){ .md-button .md-button--primary } -->

<!-- - :cloudvision: **C05-Lab: Network Detect and Response (NDR)**

    ---

    Using Arista NDR to detect and respond to network anomolous behavior and unauthorized acces

    [:material-login: Hop into C-05](./references/under_constructions.md){ .md-button .md-button--primary } -->

</div>

<!-- ## :material-eye-outline: Network Observability

<div class="grid cards" markdown>

- :cloudvision: **O01-Lab: Universal Network Observability with CloudVision**

    ---

    Use CloudVision to monitor and troubleshoot your network

    [:material-login: Hop into O-01](./references/under_constructions.md){ .md-button .md-button--primary }

</div> -->

## :material-tools: Tools For The Job

<div class="grid cards" markdown>

- :cloudvision: **D01-Lab: Iris Design, Configuration and Pricing**

    ---

    Use Intangi Iris to design, configurre and price Arista campus products and solutions

    [:material-login: Hop into D-01](./references/config_tools.md){ .md-button .md-button--primary }

<!-- - :cloudvision: **D02-Lab: AROC**

    ---

    Use Arista Order and Configuration (AROC) to create bill of materials 

    [:material-login: Hop into D-02](./references/under_constructions.md){ .md-button .md-button--primary }

- :cloudvision: **D03-Lab: CPQ**

    ---

    Use Configure Price Quote (CPQ) to quote Arista approved BOMs

    [:material-login: Hop into D-03](./references/under_constructions.md){ .md-button .md-button--primary } -->

</div><!-- Emergency rebuild Sat Sep 20 09:07:32 EDT 2025 -->
<!-- Emergency rebuild Sat Sep 20 09:07:41 EDT 2025 -->
