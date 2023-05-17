# Requirements
- 3x VMs/devices on the same network each with static IP addresses.
- Device hostnames should be origin.test, gateway.test, destination.test.
- origin.test and gateway.test should each have a user called 'user'
- destination.test should have a user called 'user1' (the destination - like an organisation - can have multiple users)
- __IMPORTANT: Before running the setup.sh script, edit the transport-maps file to include the IP address of the destination server (Replace \<Destination IP Address> with the IP address. Retain the square brackets).__

# Setup Gateway server
From the 'user' account:  
Clone this repository somewhere inside the 'home' directory.  
Make the setup.sh script executable: `chmod +x setup.sh`  
Run the setup.sh script with root privileges: `sudo ./setup.sh`  
If Postfix is not installed, it will install. Choose the 'Internet Site' option, and enter 'gateway.test' as the domain.  
The gateway should now be set up.  
Run `sudo tail -f /var/log/mail.log` to view the live gateway Postfix log.

# Testing
## Configure Origin server
From the 'user' account on the origin server:  
Ensure emails sent from the origin server to a @destination.test email address are routed through the gateway by adding the following line to the /etc/hosts file: `<IP ADDRESS>    destination.test` (where \<IP ADDRESS> is the IP address of the gateway server).  
Open Claws Mail and configure as follows: Email address should be user@origin.test. Server type should be 'Local mbox file'. SMTP server address should be 'gateway.test'.

## Configure Destination server
From the 'user1' account on the destination server open Claws Mail and configure as follows:  Email address should be user@destination.test. Server type should be 'Local mbox file'. SMTP server address should be 'gateway.test'.

## Send emails from Origin server
From the 'user' account on the origin server open Claws Mail and try sending emails to user1@destination.test
