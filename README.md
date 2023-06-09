# Overview
- There are 3x Raspberry Pi devices / VMs on the same network each with static IP addresses.  
- The device hostnames should be origin.test, gateway.test, destination.test  
- origin.test and gateway.test should each have a user called 'user'.  
- destination.test should have a user called 'user1' (the destination - like an organisation - can have multiple users).  
- Emails sent from user@origin.test to user1@destination.test will automatically pass through the gateway device for filtering.  

# Configure Gateway server
- Set a static IP address by editing the /etc/dhcpcd.conf file. Uncomment and edit the 'Example static IP configuration' section.  
- Set the hostname: `sudo hostnamectl set-hostname gateway.test`  
- Create user: `sudo adduser user && sudo adduser user sudo`  
- Login as user.  
- Clone this repository somewhere inside the 'home' directory.  
- Edit the transport-maps file to include the IP address of the destination server (replace \<DESTINATION SERVER IP ADDRESS> with the IP address of the destination server. Retain the square brackets)  
- Make the setup.sh script executable: `chmod +x setup.sh`  
- Run the setup.sh script with elevated privileges: `sudo ./setup.sh`  
- Postfix will install or reinstall. Choose the 'Internet Site' option, and enter 'gateway.test' as the domain.  
- The gateway should now be set up.  
- Run `sudo tail -f /var/log/mail.log` to view the live gateway Postfix log.

# Testing
## Configure Origin server
- Set a static IP address by editing the /etc/dhcpcd.conf file. Uncomment and edit the 'Example static IP configuration' section.  
- Set the hostname: `sudo hostnamectl set-hostname origin.test`  
- Create user: `sudo adduser user && sudo adduser user sudo`  
- Login as user.  
- Install Postfix: `sudo apt install postfix`. Choose the 'Internet Site' option, and enter 'origin.test' as the domain.  
- Ensure emails sent from the origin server to @destination.test email addresses are routed through the gateway server by adding the following line to the /etc/hosts file: `<GATEWAY SERVER IP ADDRESS>    destination.test` (where \<GATEWAY SERVER IP ADDRESS> is the IP address of the gateway server).  
- Open Claws Mail and configure as follows: Email address should be user@origin.test. Server type should be 'Local mbox file'. SMTP server address should be 'destination.test'.

## Configure Destination server
- Set a static IP address by editing the /etc/dhcpcd.conf file. Uncomment and edit the 'Example static IP configuration' section.  
- Set the hostname: `sudo hostnamectl set-hostname destination.test`  
- Create user1: `sudo adduser user1 && sudo adduser user1 sudo`  
- Login as user1.   
- Install Postfix: `sudo apt install postfix`. Choose the 'Internet Site' option, and enter 'destination.test' as the domain.  
- Open Claws Mail and configure as follows:  Email address should be user1@destination.test. Server type should be 'Local mbox file'. SMTP server address can remain unchanged for now.

## Send emails from Origin server
- Login as 'user' on the origin server.  
- Open Claws Mail and try sending emails to user1@destination.test  
