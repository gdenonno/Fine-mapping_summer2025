I am going to run a command to determine what kind of C++ environment we are operating with on posit:

gcc --version

gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

This is very similar to the commands in the tutotial:
https://www.geeksforgeeks.org/openmp-introduction-with-installation-guide/ 

Here is a command to check "whether the OpenMP features are configured into our compiler or not":

echo |cpp -fopenmp -dM |grep -i open

"#define _OPENMP 201511"

I think this means that OpenMP is installed which is great news. 

g++ --version

g++ (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Ok now that I think that we have all the prerequisites, I can start with installing susieX  

https://github.com/getian107/SuSiEx

cd ~/finemapping_with_susieR/install_tools/susieX_install

git clone https://github.com/getian107/SuSiEx.git

cd ~/finemapping_with_susieR/install_tools/susieX_install/SuSiEx/src

make all

g++ -c data.cpp -fopenmp
g++ -c model.cpp -fopenmp
mkdir -p ../bin
g++ main.cpp data.o model.o -O3 -o ../bin/SuSiEx -fopenmp


../bin/SuSiEx --help

It looks like it works!
