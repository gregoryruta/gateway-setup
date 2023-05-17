# Requirements:
- 3x VMs/devices on the same network with static IP addresses.
- Device hostnames should be origin.test, gateway.test, destination.test.
- destination.test should have a user called user1 (as per relay-recipient-maps file).
- transport-maps file should include the IP address of the destination server.

# Setup Gateway
Make the setup.sh script executable: `sudo chmod +x setup.sh`
Run the setup.sh script: `sudo ./setup.sh`
If Postfix is not installed, it will install. Choose the 'Internet Site' option, and enter 'gateway.test' as the domain.
Gateway should now be setup.
Run `sudo tail -f /var/log/mail.log` to view the live gateway Postfix logs


# Test
## Origin server:
Ensure emails sent from the origin server to a @destination.test email address are routed to the gateway:
- In the origin server's /etc/hosts file, add the following line `<IP ADDRESS>    destination.test` (where <IP ADDRESS> is the IP address of the gateway).
Open Claws Mail on the origin server