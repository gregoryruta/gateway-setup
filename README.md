# Overview
- There are 3x Raspberry Pi devices / VMs on the same network each with static IP addresses.  
- The device hostnames should be origin.test, gateway.test, destination.test  
- origin.test and gateway.test should each have a user called 'user'.  
- destination.test should have a user called 'user1' (the destination - like an organisation - can have multiple users).  
- Emails sent from user@origin.test to user1@destination.test will automatically pass through the gateway server for filtering.  

# Setup Gateway server
Set a static IP address by editng the /etc/dhcpcd.conf file. Uncomment and edit the 'Example static IP configuration' section.  
Set the hostname: `hostnamectl set-hostname gateway.test`  
Create the user: `sudo adduser user && sudo adduser user sudo`  
Login as user.  
Clone this repository somewhere inside the 'home' directory.  
Edit the transport-maps file to include the IP address of the destination server (replace \<Destination IP Address> with the destination IP address. Retain the square brackets)  
Make the setup.sh script executable: `chmod +x setup.sh`  
Run the setup.sh script with elevated privileges: `sudo ./setup.sh`  
Postfix will install or reinstall. Choose the 'Internet Site' option, and enter 'gateway.test' as the domain.  
The gateway should now be set up.  
Run `sudo tail -f /var/log/mail.log` to view the live gateway Postfix log.

# Testing
## Configure Origin server
Set a static IP address by editng the /etc/dhcpcd.conf file. Uncomment and edit the 'Example static IP configuration' section.  
Set the hostname: `hostnamectl set-hostname origin.test`  
Create the user: `sudo adduser user && sudo adduser user sudo`  
Login as user.  
Install Postfix: `sudo apt install postfix`. Choose the 'Internet Site' option, and enter 'origin.test' as the domain.  
Ensure emails sent from the origin server to a @destination.test email address are routed through the gateway by adding the following line to the /etc/hosts file: `<IP ADDRESS>    destination.test` (where \<IP ADDRESS> is the IP address of the gateway server).  
Open Claws Mail and configure as follows: Email address should be user@origin.test. Server type should be 'Local mbox file'. SMTP server address should be 'destination.test'.

## Configure Destination server
Set a static IP address by editng the /etc/dhcpcd.conf file. Uncomment and edit the 'Example static IP configuration' section.  
Set the hostname: `hostnamectl set-hostname destination.test`  
Create the user: `sudo adduser user1 && sudo adduser user1 sudo`  
Login as user1.   
Install Postfix: `sudo apt install postfix`. Choose the 'Internet Site' option, and enter 'destination.test' as the domain.  
Open Claws Mail and configure as follows:  Email address should be user1@destination.test. Server type should be 'Local mbox file'. SMTP server address can remain unchanged for now.

## Send emails from Origin server
From the 'user' account on the origin server:  
Open Claws Mail and try sending emails to user1@destination.test
