Create an AGNI Guest Captive Portal

Next, we’ll configure a Guest Captive Portal using AGNI for wireless clients. To configure the guest portal, you must configure both AGNI and CV-CUE.
Configuring AGNI
Log in to AGNI and navigate to Configuration > System > Portal Settings.
In Portal Settings, the Default portal is always present, which is non-removable. You can use the same for configuration. Let’s create a new guest portal.
Click the Add Guest Portal button. 
In the Configuration tab, provide the portal name (AGNI Portal) and select the theme of the portal. The available theme options are Default or Split Screen. 
Select the Authentication Type as Clickthrough.
Click the Customization tab to customize the portal settings, including:
Page
Login Toggle
Terms of Use and Privacy Policy
Logo
Guest Login Submit Button
Etc

When done, click Add Guest Portal. The portal gets listed in the portal listing.


Navigate to the Access Control > Networks.
Add a new network with following settings:
Name - Wireless-Guest-CP
Connection Type — Wireless
SSID - Guest SSID in CV-CUE (ATD-##-CP)
Authentication Type - Captive Portal
Captive Portal Type - Internal
Select Internal Portal - AGNI Portal
Internal Role for Portal Authentication - Portal Role


Click Add Network. 
Copy the portal URL at the bottom of the page.
 







Configuring CV-CUE
In CV-CUE, configure a role profile and the SSID settings. Ensure that the SSID is enabled for the captive portal with redirection to the portal URL.
Configuring Portal and Guest Role Profiles

Portal Role Profile
Log in to CV-CUE and navigate to Configure > Network Profiles > Role Profile.
Add Role Profile.
Add the Role Name as Portal Role.
Enable the Redirection check box and select Static Redirection.
In the Redirect URL field, add the portal URL that you have copied from AGNI.



Click SAVE at the bottom of the page.


*Note: The Guest Role and Wireless-Guest-CP Segment are not required for Click Through Guest Access. If users are required to create a guest account or receive approval, then the Guest Role and Wireless-Guest-CP Segment are required. 

The sections below with *** preceding the section are not required for Click Through Guest Access.

***Guest Role Profile
Next, we’ll configure a Guest Role in CV-CUE to assign to Guest Users post authentication.

In CV-CUE, navigate to Configure > Network Profiles > Role Profile.
Add Role Profile.
Add the Role Name as Guest Role.
Select the check box next to VLAN.



Additional Information
VLAN
In this lab the VLAN is set to 0. In production networks you would define the Guest VLAN ID or Name that you want to assign to the Guest Users.

Firewall
Layer 3-4 and Application Firewall Rules can be assigned to the Guest User Role.

User Bandwidth Control
Upload and Download Bandwidth Limits can be assigned to the Guest User Role.

Click SAVE at the bottom of the page.


***Configure AGNI Wireless-Guest-CP Segment
Next, we’ll configure a Segment in AGNI to assign the Guest Role Profile post authentication.
Go back to AGNI and navigate to the Access Control > Segments.
Add a new Segment with following settings:
Name - Wireless-Guest-CP
Conditions - Network Name is Wireless-Guest-CP
Actions - Arista-WiFi - Role Profile - Guest Role

Click on Segments and then + Add Segment






Next, type in the name: Wireless-Guest-CP.



Next, let’s Add Conditions. *Note: Adding more than one condition means MATCH ALL 


Select, Network, Name, Is, Wireless-Guest-CP from the drop down lists. 

Your Conditions should now look like this.


Under Actions select Add Action.
Select, Arista-WiFi - Role Profile - Guest Role




Finally, select Add Segment at the bottom of the page. 


Configuring the Guest Captive Portal SSID

Next we’ll configure the Guest Captive Portal SSID and assign the pre and post authentication roles.

Navigate to Configure > WiFi
Add SSID
SSID Name: ATD-##-CP
SSID Type: Private


Click the Access Control tab.
Enable the Client Authentication check box and select RADIUS MAC Authentication.
Select RadSec
	
Authentication Server - AGNI
Accounting Server - AGNI

Select AGNI for the Authentication and Accounting servers, and select the check box next to Send DHCP Options and HTTP User Agent.
Select the Role Based Control checkbox and configure the following settings: 
Rule Type — 802.1X Default VSA
Operand — Match
Assign Role — Select All. You created the Portal and Guest Roles profile in the previous section. 


Save & Turn SSID On.
Once you are done, connect your phone to this SSID and select Connect from the Captive Portal page.  The clients get connected and authenticated via the portal authentication.


D. Adding Access Control Lists
In this section we will add an acl to AGNI which we can push to the switch. 

First navigate to Access Control - > ACLs  and  + Add ACL in the upper right corner



Next fill in the Name and Description fields with Guest Access and ACL Field with the below config then select Add ACL

#permit servers
permit in ip from any to 192.168.125.11
#deny network access
deny in ip from any to 192.168.0.0/16
deny in ip from any to 10.0.0.0/8
#Allow internet access
permit in ip from any to any




It should now show in the Access Control list 




Next we will apply it to a Segment. Navigate to Segments, then select edit on the Wired-EAP-TLS segment


Next under the actions section Select Add Action and choose Apply ACL from the drop down list then choose Standard ACL and Guest Access to build out the Action. When Complete it should look as below. You can then select “Update Segment”




From here navigate back to the Sessions screen and find the client session for the raspberry pi select the eye on the right hand side to view details. 



At the top of the session details page select the Disconnect button to disconnect and re-authenticate the session. 
    

Next you will then see a new session come up as the client re-authenticates you can validate the acl being applied by selecting the Eye next to this new session and viewing the details 



Next we can validate on the switch by issuing Show dot1x host command 

Take this mac address and issue the command  show dot1x host mac  <mac from above> detail here we will see the Access list applied in the Nas-Filter-Rule


Lastly issue the show ip access-lists command to view the dynamic access list applied 

  

You can try pinging the device ip from your laptop to confirm acl functionality. 

This completes the Access Control List lab. 