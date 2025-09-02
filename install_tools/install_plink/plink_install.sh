# How I installed plink on my computer
# 1. Install plink
# - Download from this website: https://www.cog-genomics.org/plink/1.9/
# -Following the instructions on this website:     https://knowledgebase.aridhia.io/workspaces/analysing-data/virtual-machines/installing-software-on-virtual-machines/installing-plink-on-your-virtual-machine
#      - cd to your directory
#      - unzip plink_mac_20241022.zip -d plink_install
#      - Unzipped the file and made a file called plink_install
#      - cd plink_install
#      - sudo cp plink /usr/local/bin
#      - sudo chmod 755 /usr/local/bin/plink
#      - sudo nano ~/.bashrc
#      - pasted export PATH=/usr/local/bin:$PATH
#  PLINK susccessfuly installed 

cd ~/finemapping_with_susieR/install_tools/plink_install

#####################################################################################
# This method did not work

# sudo cp plink /usr/local/bin

# sudo: /etc/sudo.conf is owned by uid 64132, should be 0
# sudo: The "no new privileges" flag is set, which prevents sudo from running as root.
# sudo: If sudo is running in a container, you may need to adjust the container configuration to disable the flag.

# sudo chmod 755 /usr/local/bin/plink

# sudo: /etc/sudo.conf is owned by uid 64132, should be 0
# sudo: The "no new privileges" flag is set, which prevents sudo from running as root.
# sudo: If sudo is running in a container, you may need to adjust the container configuration to disable the flag.

# sudo nano ~/.bashrc

# Same errors

# This method did not work because I cannot use sudo due to permission issues
#####################################################################################

######################################

# Chat gpt helping me install the package without sudo

######################################

wget https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20231211.zip

#--2025-03-24 19:29:00--  https://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20231211.zip
#Resolving s3.amazonaws.com (s3.amazonaws.com)... 16.15.217.31, 52.216.218.200, 52.216.42.80, ...
#Connecting to s3.amazonaws.com (s3.amazonaws.com)|16.15.217.31|:443... connected.
#HTTP request sent, awaiting response... 200 OK
#Length: 8953953 (8.5M) [application/zip]
#Saving to: ‘plink_linux_x86_64_20231211.zip’

#plink_linux_x86_64_20231211.z 100%[=================================================>]   8.54M  12.4MB/s    in 0.7s    

#2025-03-24 19:29:01 (12.4 MB/s) - ‘plink_linux_x86_64_20231211.zip’ saved [8953953/8953953]

unzip plink_linux_x86_64_20231211.zip -d ~/bin/

#Archive:  plink_linux_x86_64_20231211.zip
#  inflating: /nfs/mdippel/bin/plink  
#  inflating: /nfs/mdippel/bin/LICENSE  
#  inflating: /nfs/mdippel/bin/toy.ped  
#  inflating: /nfs/mdippel/bin/toy.map  
#  inflating: /nfs/mdippel/bin/prettify  

echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc

source ~/.bashrc

plink

# plink now works!


