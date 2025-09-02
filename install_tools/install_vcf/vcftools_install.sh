

# Follow instructions here:
https://vcftools.github.io/downloads.html
https://vcftools.github.io/examples.html 

cd ~/finemapping_with_susieR/install_tools/vcftools_install

git clone https://github.com/vcftools/vcftools.git

# The commands on that website did not work

# Use Chat GPT to install packages without needed any permissions

# First it says to download the bpackage from github which I have already done using git clone. 
# wget https://github.com/vcftools/vcftools/releases/download/v0.1.16/vcftools-0.1.16.tar.gz
# tar -xvzf vcftools-0.1.16.tar.gz
# cd vcftools-0.1.16

cd vcftools

mkdir -p $HOME/bin
./configure --prefix=$HOME/bin
make
make install

# Ok so despite the incredible amount of weird messages. Chat GPT says that the installation looks sucessful 

echo 'export PATH=$HOME/bin/bin:$PATH' >> ~/.bashrc
source ~/.bashrc

vcftools

# Installation was successful! 

# I think I might need to run source ~/.bashrc everytime I want to access the package, but that's okay 
