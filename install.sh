#!/bin/bash

# 1. Update the system
sudo apt update && sudo apt upgrade -y
# Explanation: Updates the package lists and installs the latest versions of all packages on the system.

# 2. Install dependencies
sudo apt install -y software-properties-common curl apt-transport-https lsb-release ca-certificates
# Explanation: Installs necessary packages for managing repositories, handling HTTPS, and installing external software.

# 3. Add repository for EasyEngine
wget -qO ee https://rt.cx/ee4 && sudo bash ee
# Explanation: Downloads and runs the EasyEngine installation script to add the EasyEngine repository.

# 4. Install EasyEngine and create a WordPress site
sudo ee site create blog1.teknohive.me --type=wp --ssl=le --cache
# Explanation: Uses EasyEngine to create a WordPress site with SSL (Let’s Encrypt) and caching enabled.

# 5. Add repository for Mono (needed for Duplicati)
sudo apt install -y dirmngr gnupg apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D1A5E309
echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
# Explanation: Adds the Mono repository to the system, which is required for Duplicati.

# 6. Update repository and install Mono
sudo apt update && sudo apt install -y mono-devel
# Explanation: Updates the package lists to include the Mono repository and installs the Mono development tools.

# 7. Download and install Duplicati
wget https://updates.duplicati.com/beta/duplicati_2.0.6.3-1_all.deb
sudo dpkg -i duplicati_2.0.6.3-1_all.deb
sudo apt-get install -f
# Explanation: Downloads the Duplicati package, installs it, and resolves any dependency issues.

# 8. Enable and start the Duplicati service
sudo systemctl enable duplicati
sudo systemctl start duplicati
# Explanation: Enables the Duplicati service to start at boot and starts it immediately.

# 9. Install Certbot for Let’s Encrypt SSL
sudo apt install -y certbot python3-certbot-nginx
# Explanation: Installs Certbot and its Nginx plugin to manage SSL certificates.

# 10. Obtain an SSL certificate for the domain using Certbot
sudo certbot --nginx -d blog1.teknohive.me
# Explanation: Uses Certbot to obtain and configure an SSL certificate for the domain `blog1.teknohive.me`.

# 11. Final output message
echo "Installation complete. EasyEngine and Duplicati have been installed and configured with SSL Let's Encrypt."

# 12. Restore sites from old server
echo "To restore sites from the old server, follow these steps:"
echo "1. Open Duplicati on the new server."
echo "2. Go to the Restore section."
echo "3. Select the backup source from the old server."
echo "4. Follow the prompts to restore the site to the new server."
