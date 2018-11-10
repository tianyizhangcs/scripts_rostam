#!/bin/bash
echo "this script is used for build hpx on rostam"
echo " build_mode?" 
read -p "build_mode: " mode
echo "machine?"
read -p "which machine: " machine
echo "cxx compiler?"
read -p "CXX comiler : " cpp
echo "c compiler?"
read -p "C compiler : " c
cd ~/
if [ ! -d "pkgs_auto" ]; then
		mkdir ~/pkgs_auto
fi
cd ~/pkgs_auto

if [ ! -d "hpx" ]; then
		echo "How do you want to clone,h or s?"
		read clone
		if [ "$clone" = "h" ]; then
				git clone https://github.com/STEllAR-GROUP/hpx.git
		else
				git clone git@github.com:STEllAR-GROUP/hpx.git
		fi
fi

boost_root=""
stdlib=""
if [ "$cpp" = "clang++" ]; then
	boost_root="/home/tianyi/pkgs/repo/boost/boost-1.67.0/${mode}"
	stdlib="-stdlib=libc++"
fi

echo "$boost_root"

cd ~/pkgs_auto/hpx

if [ -d "build_${cpp}_${machine}_${mode}" ]; then
	rm -r -f build_${cpp}_${machine}_${mode}
fi

mkdir build_${cpp}_${machine}_${mode}
cd  build_${cpp}_${machine}_${mode}
cmake	\
-DCMAKE_C_COMPILER=${c} 	\
-DCMAKE_CXX_COMPILER=${cpp}	\
-DCMAKE_BUILD_TYPE=${mode}	\
-DHPX_WITH_MALLOC=tcmalloc	\
-DHPX_WITH_THREAD_LOCAL_STORAGE=ON	\
-DBOOST_ROOT=${boost_root}	\
-DCMAKE_CXX_FLAGS=${stdlib}	\
..
make core -j12




