#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi


# Function to install Google Chrome
#install_chrome() {
 #   wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
 #  sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
 #  sudo apt-get update
 #  sudo apt-get install -y google-chrome-stable
#}

# Function to install AnyDesk
#install_anydesk() {
#    wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
#   echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
#   sudo apt-get update
#   sudo apt-get install -y anydesk
#}

# Function to install WPS Office
#install_wps() {
#	TARGET_DIR="/home/administrator/Downloads"
#	WPS_URL="http://kdl.cc.ksosoft.com/wps-community/download/a20/wps-office_11.1.0.10702_amd64.deb"
#	wget -O wps-office.deb "$TARGET_DIR/wps-office.deb" "$WPS_URL"
#   wget -O wps-office.deb http://kdl.cc.ksosoft.com/wps-community/download/a20/wps-office_11.1.0.10702_amd64.deb
#	cd $TARGET_DIR
#   sudo apt install -y ./wps-office.deb
#    rm $TARGET_DIR/wps-office.deb
	
# Check and change hostname
current_hostname=$(hostname)
echo "Current hostname: $current_hostname"
read -p "Do you want to change the hostname? (y/n): " change_hostname

if [[ $change_hostname =~ ^[Yy]$ ]]; then
    read -p "Enter new hostname: " new_hostname
    sudo hostnamectl set-hostname $new_hostname
    echo "Hostname changed to: $new_hostname"
else
    echo "Hostname not changed."
fi

# Check if Google Chrome is installed
if dpkg -l | grep -q google-chrome-stable; then
    echo "Google Chrome is already installed."
    read -p "Do you want to reinstall Google Chrome? (y/n): " reinstall_chrome
    if [[ $reinstall_chrome =~ ^[Yy]$ ]]; then
        sudo apt-get remove -y google-chrome-stable
        install_chrome
        echo "Google Chrome reinstalled."
    else
        echo "Google Chrome installation skipped."
    fi
else
    install_chrome
    echo "Google Chrome installed."
fi

# Check if AnyDesk is installed
if dpkg -l | grep -q anydesk; then
    echo "AnyDesk is already installed."
    read -p "Do you want to reinstall AnyDesk? (y/n): " reinstall_anydesk
    if [[ $reinstall_anydesk =~ ^[Yy]$ ]]; then
        sudo apt-get remove -y anydesk
        install_anydesk
        echo "AnyDesk reinstalled."
    else
        echo "AnyDesk installation skipped."
    fi
else
    install_anydesk
    echo "AnyDesk installed."
fi

# Check if WPS Office is installed
if dpkg -l | grep -q wps-office; then
    echo "WPS Office is already installed."
    read -p "Do you want to reinstall WPS Office? (y/n): " reinstall_wps
    if [[ $reinstall_wps =~ ^[Yy]$ ]]; then
        sudo apt-get remove -y wps-office
        install_wps
        echo "WPS Office reinstalled."
    else
        echo "WPS Office installation skipped."
    fi
else
    install_wps
    echo "WPS Office installed."
fi

echo "Script execution completed."

#Manage Engine setup
# Define variables
TARGET_DIR="/home/administrator/Downloads"
DMRootCA_URL="https://github.com/ssn031737/Ub-cip/blob/5901bfe81bbf1c6eae3180dfef69f96abadb4f6d/ME/DMRootCA.crt"
json_URL="https://github.com/ssn031737/Ub-cip/blob/5901bfe81bbf1c6eae3180dfef69f96abadb4f6d/ME/serverinfo.json"
UEMS_URL="https://github.com/ssn031737/Ub-cip/blob/5901bfe81bbf1c6eae3180dfef69f96abadb4f6d/ME/UEMS_LinuxAgent.bin"

# Function to download and set up ME
download_and_setup_ME() {
    echo "Downloading required files..."
    wget -O "$TARGET_DIR/DMRootCA.crt" "$DMRootCA_URL"
    wget -O "$TARGET_DIR/serverinfo.json" "$json_URL"
    wget -O "$TARGET_DIR/UEMS_LinuxAgent.bin" "$UEMS_URL"

    echo "Setting execution permissions..."
    sudo chmod +x "$TARGET_DIR/UEMS_LinuxAgent.bin"

    echo "Running the installer..."
	cd $TARGET_DIR
    sudo ./UEMS_LinuxAgent.bin
}

# Check the status of the dcservice
if systemctl status dcservice | grep -q "active"; then
    echo "dcservice is active. ME is already installed."
else
    echo "dcservice is not active. Installing ME..."
    download_and_setup_ME
fi

# Proceed to the next process
echo "Proceeding to the next process..."

# Your next process script goes here

exit 0

#Check and Install Seqrite Antivirus
#!/bin/bash

# Function to check if Seqrite Antivirus is installed
#check_seqrite_installed() {
#   if [ -x "$(command -v QHAVCLI)" ]; then
#       echo "Seqrite Antivirus is already installed."
#        return 0  # Return 0 indicating it's installed
#    else
#        echo "Seqrite Antivirus is not installed."
#        return 1  # Return 1 indicating it's not installed
#    fi
#}

# Main script starts here
#if check_seqrite_installed; then
#    echo "Skipping installation as Seqrite Antivirus is already installed."
#else
#    echo "Installing Seqrite Antivirus..."
#
#    # Step A: Install Seqrite Antivirus
#    echo "Step A: Installing Seqrite Antivirus"
#
#    # Download and extract Linux64 N.zip
#    wget -q <URL_to_Linux64_N.zip> -O Linux64_N.zip
#    unzip -q Linux64_N.zip -d linuxsetup64
#
#    # Navigate to linuxsetup64 directory
#    cd linuxsetup64
#
#    # Change permissions and install Seqrite Antivirus
#    chmod 777 linuxsetup64
#    ./install
#
#    # Post-installation message
#    echo "Seqrite Antivirus installed in /usr/lib/Seqrite/Seqrite"

    # Validate installation
#    cd /usr/lib/Seqrite/Seqrite
#    ./QHAVCLI
#fi

# Step B: Install SUAunix64
#echo "Step B: Installing SUAunix64"

# Download and extract SUAunix64.zip
#wget -q <URL_to_SUAunix64.zip> -O SUAunix64.zip
#unzip -q SUAunix64.zip -d SUAunix64

# Navigate to SUAunix64 directory
#cd SUAunix64

# Change permissions and run SUA_unix_amd64.sh
#chmod +x SUA_unix_amd64.sh
#sudo ./SUA_unix_amd64.sh -c

#Barcode printer

#HP Ptinter setup (1136)


# Determine the shell configuration file
if [ -n "$BASH_VERSION" ]; then
    SHELL_RC_FILE="$HOME/.bashrc"
elif [ -n "$ZSH_VERSION" ]; then
    SHELL_RC_FILE="$HOME/.zshrc"
else
    echo "Unsupported shell. Please add the alias manually."
    exit 1
fi

# Alias command to be added
#ALIAS_COMMAND="alias cipsetup='rm -rf linux_cip_new-copy.sh && wget -O linux_cip_new-copy.sh #https://github.com/ssn031737/Ub-cip/linux_cip_new-copy.sh && chmod +x linux_cip_new-copy.sh && ./linux_cip_new-copy.sh'"

# Check if the alias already exists
#if grep -Fxq "$ALIAS_COMMAND" "$SHELL_RC_FILE"; then
#    echo "Alias already exists in $SHELL_RC_FILE"
#else
    # Add the alias to the shell configuration file
#    echo "$ALIAS_COMMAND" >> "$SHELL_RC_FILE"
#    echo "Alias added to $SHELL_RC_FILE"
#fi

# Source the shell configuration file to apply changes
#source "$SHELL_RC_FILE"

#echo "Alias 'dsiw' is now set up. You can use it by typing 'dsiw' in your terminal."

# Update and install necessary packages
apt-get update && apt-get install -y sssd sssd-tools curl wget
# Download the Linux folder from GitHub to the Desktop
#cd /home/administrator/Desktop

CRT_URL="https://github.com/ssn031737/Ub-cip/blob/main/Google_2026_05_22_46666.crt?raw=true"
KEY_URL="https://github.com/ssn031737/Ub-cip/blob/main/Google_2026_05_22_46666.key?raw=true"
TARGET_DIR="/home/administrator/Downloads"
# Download files
wget -O "$TARGET_DIR/Google_2026_05_22_46666.crt" "$CRT_URL" && echo "Downloaded CRT file."
wget -O "$TARGET_DIR/Google_2026_05_22_46666.key" "$FILE_URL" "$KEY_URL" && echo "Downloaded CRT file."

#git clone https://github.com/ssn031737/Ub-cip.git Linux


# Navigate to the Linux folder and set permissions
#cd Linux
#chmod 777 /home/administrator/Desktop/Linux/

# Copy the required files and set permissions
cp -rp $TARGET_DIR/Google_2026_05_22_46666* /var/ && chmod 777 /var/Google_2026_05_22_46666*

# Configure sssd.conf

#Variable for SSSD file path
SSSD_CONF_FILE="/etc/sssd/sssd.conf"

#cat /home/administrator/Desktop/Linux/sssd_conf.txt > /etc/sssd/sssd.conf
# Define the sssd configuration content
SSSD_CONFIG="[sssd]
services = nss, pam
domains = delhivery.com

[domain/delhivery.com]
ignore_group_members = true
sudo_provider = none
cache_credentials = true
ldap_tls_cert = /var/Google_2026_05_22_46666.crt
ldap_tls_key = /var/Google_2026_05_22_46666.key
ldap_uri = ldaps://ldap.google.com:636
ldap_search_base = dc=delhivery,dc=com
id_provider = ldap
auth_provider = ldap
ldap_schema = rfc2307bis
ldap_user_uuid = entryUUID
ldap_groups_use_matching_rule_in_chain = true
ldap_initgroups_use_matching_rule_in_chain = true
enumerate = false
ldap_tls_cipher_suite = NORMAL:!VERS-TLS1.3"

# Write the new configuration to sssd.conf
echo "$SSSD_CONFIG" | sudo tee "$SSSD_CONF_FILE" > /dev/null

chown root:root /etc/sssd/sssd.conf
chmod 600 /etc/sssd/sssd.conf

# Restart sssd service
service sssd restart

# Configure custom.conf
#cat /home/administrator/Desktop/Linux/custom_conf.txt > /etc/gdm3/custom.conf

#Variable for SSSD file path
GDM_CONF_FILE="/etc/gdm3/custom.conf"

# Define the GDM configuration content:
GDM_CONFIG=# GDM configuration storage
#
# See /usr/share/gdm/gdm.schemas for a list of available options.

# Uncomment the line below to force the login screen to use Xorg
WaylandEnable=true

# Enabling automatic login
#  AutomaticLoginEnable = true
#  AutomaticLogin = user1

# Enabling timed login
#  TimedLoginEnable = true
#  TimedLogin = user1
#  TimedLoginDelay = 10

#[security]

#[xdmcp]

#[chooser]

#[debug]
# Uncomment the line below to turn on debugging
# More verbose logs
# Additionally lets the X server dump core if it crashes
#Enable=true

# Write the new configuration to GDM config file
echo "$GDM_CONFIG" | sudo tee "$GDM_CONF_FILE" > /dev/null

# Add Google Cloud endpoint verification repository
echo "deb https://packages.cloud.google.com/apt endpoint-verification main" | sudo tee -a /etc/apt/sources.list.d/endpoint-verification.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Update and install endpoint verification package
apt-get update && apt-get install -y endpoint-verification

# Display users
getent passwd

# Enable home directory creation
sudo pam-auth-update

# Instructions for the user to follow in the pop-up
echo "In the pop-up, press the down arrow & select '[*] Create home directory on login'. Update the value from blank to '*' by pressing the space button & then hit Enter."

#check configurations
sudo service sssd status | grep Active:
cat /etc/sssd/sssd.conf
cat /etc/gdm3/custom.conf | grep Wayland

# Prompt for reboot
read -p "Reboot the system? (y/n): " reboot_choice

if [[ $reboot_choice =~ ^[Yy]$ ]]; then
    echo "Rebooting the system..."
    sudo reboot
else
    echo "Exiting script without reboot."
    exit 0
fi
