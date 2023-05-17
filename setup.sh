#!/usr/bin/env bash

# Check if Postfix is installed
dpkg --status "postfix" &> /dev/null

# If Postfix is not installed, install it
if [ $? -ne 0 ]; then
    apt install postfix
fi

# Copy files required for the destination relay to work
cp transport-maps relay-recipient-maps /etc/postfix &&

# Copy filter handler and filter service
cp filter-handler.sh filter-service.py /etc/postfix &&

# Make filter handler and filter service executable
chmod +x filter-handler.sh filter-service.py &&

# Append additional settings to the main.cf config file
main.cf-additional-settings >> /etc/postfix/main.cf &&

# Append additional settings to the master.cf config file
master.cf-additional-settings >> /etc/postfix/master.cf &&

# Set the relay maps
postmap transport-maps &&
postmap relay-recipient-maps &&

# Reload Postfix
postfix reload
