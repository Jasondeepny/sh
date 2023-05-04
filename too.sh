#!/bin/bash

# Initial password
initial_password="Zyy@$%&goole"

# Step 1: Set root password
echo "Setting root password..."
echo -e "$initial_password\n$initial_password" | sudo passwd root

echo "install docker.io start..."
sudo apt update && echo "Y" | sudo apt-get install -y docker.io
echo "install docker.io end..."

# Step 2: Enable SSH permissions
echo "Enabling SSH permissions..."
if [ -f /etc/lsb-release ]; then
    if grep -q "DISTRIB_ID=Ubuntu" /etc/lsb-release; then
        # Ubuntu系统
        echo "system is Ubuntu..."
        sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
        sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    else
        # 非Ubuntu系统
        echo "system is not Ubuntu..."
    fi
elif [ -f /etc/redhat-release ] || [ -f /etc/debian_version ]; then
    # Debian系统或者Centos
    echo "system is Debian Or Centos..."
    sudo sed -i 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
    sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
else
    echo "Unsupported system. Please check your OS and try again."
    exit 1
fi

# Step 3: Restart the server
echo "Restarting the server..."
sleep 3
sudo reboot
