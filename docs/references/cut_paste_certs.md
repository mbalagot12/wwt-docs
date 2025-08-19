# Copying Certificats using Cut-and-Paste Method

## AGNI CA signed certificates

We will work with radsec_ca_certificate.pem and switch.pem certificatesfrom AGNI.  The radsec cerficate is provided by AGNI and switch.pem is generated on the switch and signed by AGNI.  You will need to copy these certificates to the switch flash storage.
The following steps assume you have already downloaded the certificates to your local machine. Ensure that you are in the same directory as the certificates.

??? info ":material-apple: MAC OS"

    1. Open Terminal and run the following. 
    2. You will cut-and-paste the certificate contents of radsec_ca_certificate.pem and switch.pem to the switch's terminal.
    3. Copy the content of the certficate from BEGIN and END CERTIFICATE lines.

        ```bash
        ls -al *.pem
        cat radsec_ca_certificate.pem
        ```

    4. Login to your switch using the `arista` user credentials and paste the certificate. Hit return and control-d to exit.

        ```bash
        copy terminal: flash:radsec_ca_certificate.pem
        enter input line by line; when done enter one or more control-d
        ```
        
    5. Repeat the previoussteps for the switch.pem certificate.

        ```bash
        cat switch.pem
        ```

    6. Login to your switch using the `arista` user credentials and paste the certificate. Hit return and control-d to exit.

        ```bash
        copy terminal: flash:switch.pem
        enter input line by line; when done enter one or more control-d
        ```

    7. Copy the certificates to the certificate store.

        ```bash
        copy flash:radsec_ca_certificate.pem certificate:radsec_ca_certificate.pem
        copy flash:switch.pem certificate:switch.pem
        ```

??? info ":material-microsoft-windows: Windows"

    1. Open Command Prompt and run the following. 
    2. You will cut-and-paste the certificate contents of radsec_ca_certificate.pem and switch.pem to the switch's terminal.
    3. Copy the content of the certficate from BEGIN and END CERTIFICATE lines.

        ```bash
        dir *.pem
        type radsec_ca_certificate.pem
        ```

    4.  Login to your switch using the `arista` user credentials and paste the certificate. Hit return and control-d to exit.

        ```bash
        copy terminal: flash:radsec_ca_certificate.pem
        enter input line by line; when done enter one or more control-d
        ```
        
    5.  Repeat the previous steps for the switch.pem certificate.

        ```bash
        type switch.pem
        ```

    6.  Login to your switch using the `arista` user credentials and paste the certificate. Hit return and control-d to exit.

        ```bash
        copy terminal: flash:switch.pem
        enter input line by line; when done enter one or more control-d
        ```

    7.  Copy the certificates to the certificate store.

    ```bash
    copy flash:radsec_ca_certificate.pem certificate:radsec_ca_certificate.pem
    copy flash:switch.pem certificate:switch.pem
    ```