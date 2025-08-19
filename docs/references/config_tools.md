# Intangi Iris Configuration Tool

## Overview

This lab is intended for the Campus Workshop and to showcase the partner tool to design, configure and price out Arista campus products and solutions. Authorized Arista partners are able to download and access the tool at `intangi.com/support` website. They are required to login with their corporate email address. Contact `iris-help-ext@arista.com` for assistance. There are many online resources available which includes videos, documentation, and more at [intangi.com/support](https://intangi.com/support){target="_blank"}.

## Iris Dashboard
    1. Upon successful login, you will be presented with the Iris dashboard. Click on the Arista catalog to start.

![Iris Desgin](assets/images/iris/01_iris_dashboard.png)

## Arista Catalog at a glance
    2. Expand the catalog to view the various devices and features available

![Iris Design](assets/images/iris/02_iris_catalogs.png)

## Design, Configure and Price Out Your Network

You are now ready to create a new network design.

Under the `Start` section, click on `New System`
Provide a name for your system, accept all defaults and click `OK.

![Iris Design](assets/images/iris/03_iris_new_system.png)

Select the Arista price list.
    
Navigate to Tools on the horizontal menu bar, select `Subscriptions` then select `Manage Subscriptions`. Select the `Arista` price list and click `Enable`. Optionally click on `Price Lists` to view the price list details. USD and EUR price lists are available. Click `OK` to continue.

![Iris Design](assets/images/iris/04_iris_price_lists.png)

Create a new site.

Navigate to `Sites` and click on `New Site`. Provide a name for your site, select the desired `Power`. `Contact`, `Description` are optional and click `OK` continue. Double-click on your workshop name on the map. A clean worshop space will be provided.

![Iris Design](assets/images/iris/05_iris_new_site.png)

Choose a desired spine switch from the catalog. Double-click on the `7050X Switch Series`, select one of the pre-configured `7050SX3-24YC2-F` bundles. `-F` is with front-to-back fan trays, `-R` is rear-to-front. Cut-and-paste the device on the site workspace to build a two-switch spine network layer.

![Iris Design](assets/images/iris/06_iris_spine_switch.png)

Interconnect the spine switches using the `Connect` tool. Select the spine switch and then the other spine switch. Choose the 100G DAC interface for the connection. We are pre-configuring the spine switches with MLAG
![Iris Design](assets/images/iris/07_iris_mlag.png)

Edit the quantity multipler of 100G DAC to `2`

![Iris Design](assets/images/iris/08_iris_peer_link.png)

Using the same method of choosing the right Arista products for your design, select `720XP-48ZC2` POE switches for the leaf layer. Add two switches for each leaf layer.

![Iris Design](assets/images/iris/09_iris_leaf_switch.png)
Connect the spine and leaf layer together using the `Connect` tool. Select the spine switch and then the leaf switch. Repeat for the second leaf switch.

![Iris Design](assets/images/iris/10_iris_connect.png)
Add an wireless access point to the leaf layer. Double-click on the `Wireless Access Points` and select the `C-460` WiFi7 model. Cut-and-paste the device on the site workspace to build a two-switch active-active wireless layer.

![Iris Design](../references/assets/images/iris/11_iris_wireless_ap.png)
Connect the wireless access point to the leaf layer using the `Connect` tool. Select the leaf switch and then the wireless access point.
![Iris Design](assets/images/iris/12_iris_wireless_to_leaf.png)


## Create a Bill Of Material (BOM)

    Iris can generate a Bill Of Material (BOM) for your design.

12.  Navigate to `Quotation` or press `Ctrl+Q`
13.  The `Quotation Composite View` will appear.  You can see the devices and features selected for your design.  You can also see the price for each device and feature.  The total price is also displayed. Hover your cursor over the `Export menu` and select `Export to Excel` to download the BOM.

![Iris Design](assets/images/iris/13_iris_bom.png)

!!! tip "🎉 CONGRATS! You have completed the Iris labs! 🎉"

--8<-- "includes/abbreviations.md"

[def]: ../references/assets/images/iris/03_iris_new_system.png