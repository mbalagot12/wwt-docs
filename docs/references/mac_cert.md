# EAP-TLS Using Macbook

Example of using your Macbook to test EAP-TLS

## Exporting Trusted Cert

1. To start, hop on your mac keychain and find the internal CA that signed your arista certificate. This is under `Keychain > System > My Certificates`.
2. Find the internal CA in your Certificates under `Keychain > System > Certificates`
3. Click `Export` and export the internal CA as a `.cer`
4. Using that public key, you can then hop in AGNI and add it to `Certificate > Trusted Certificates > External`.
5. In addition, since we don't have access to the internal identity store, you'll want to build a username in Agni's local database that matches the common name of your user certificate

## AGNI Networks

1. Under `Access Control > Networks`, you'll want to build out your connection policy.
2. Match the SSID name, enable auth type of `EAP-TLS`, set `User Identity Binding` as `Required`, and `Enable` the Trust External Certificates.
3. Click Save

## Connect to SSID

1. Try and connect to your EAP-TLS SSID
2. Present it with your local certificate
3. You may be prompted to continue
4. Supply your username
5. Validate your session in AGNI under `Sessions`

Reference: https://docs.google.com/document/d/1tuqhdpFDrVC4YVEO0fUKipQfdpzh-mKXXAWBqArwdbA/edit?tab=t.0
