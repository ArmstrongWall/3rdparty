#!/usr/bin/env bash
mypasswd=wzq

red='\e[0;41m' # 红色  
RED='\e[1;31m'
green='\e[0;32m' # 绿色  
GREEN='\e[1;32m'
yellow='\e[5;43m' # 黄色  
YELLOW='\e[1;33m'
blue='\e[0;34m' # 蓝色  
BLUE='\e[1;34m'
purple='\e[0;35m' # 紫色  
PURPLE='\e[1;35m'
cyan='\e[4;36m' # 蓝绿色  
CYAN='\e[1;36m'
WHITE='\e[1;37m' # 白色
NC='\e[0m' # 没有颜色


echo ${mypasswd} | sudo -S apt-get update
sudo apt-get install -y build-essential
sudo apt-get install -y cmake git
## Install Glog Gflags
sudo apt-get install -y vim cmake git
sudo apt-get install -y libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libboost-all-dev libhdf5-serial-dev libgflags-dev libgoogle-glog-dev liblmdb-dev protobuf-compiler
## Install Protobuf
sudo apt-get install -y protobuf-compiler libprotobuf-dev libprotoc-dev
sudo apt-get install -y libprotobuf-c0-dev protobuf-c-compiler

cd ~/
if [ -d "3rdparty/" ]; then
  cd 3rdparty/
else
  mkdir 3rdparty/
fi

#install eigen3.3
check_results=`pkg-config eigen3 --modversion`
if [[ $check_results =~ "3.3.5" ]]
then
	echo -e "${GREEN}eigen3 has already installed. ${NC}"
else
  cd ~/3rdparty/
  if [ ! -f "eigen.tar.gz" ]; then
    echo "no eigen file"
    git clone https://github.com/eigenteam/eigen-git-mirror.git
  else
    echo "there is eigen file"
    tar -xzvf eigen.tar.gz
      if [ $? -eq 0 ];then
          echo "success tar eigen file"
      else
          echo "fail tar eigen file"
          exit 1
      fi
  fi
  cd ~/3rdparty/eigen-git-mirror
  git checkout origin/branches/3.3
  git checkout a66b5a59a6bc0be133bc09e86edbb8fcd6dc4cb2
  mkdir build
  cd build
  cmake ..
  cmake --build .
  echo ${mypasswd} | sudo -S make install
fi



#install Sophus
if [ ! -d "/usr/local/include/sophus/" ]; then
  cd ~/3rdparty/
  if [ ! -f "Sophus.tar.gz" ]; then
    echo "no Sophus file"
    git clone https://github.com/strasdat/Sophus.git
  else
    echo "there is Sophus file"
    tar -xzvf Sophus.tar.gz
    if [ $? -eq 0 ];then
        echo "success tar Sophus file"
    else
        echo "fail tar Sophus file"
        exit 1
    fi
  fi
  cd ~/3rdparty/Sophus
  git checkout b475c0a81a197ff8ea6bdcf8df8a2f5a7b1da879
  mkdir build
  cd build
  cmake ..
  cmake --build .
  echo ${mypasswd} | sudo -S make install
else
	echo -e "${GREEN}Sophus has already installed. ${NC}"
fi



#install Pangolin
if [ ! -d "/usr/local/include/pangolin/" ]; then
  cd ~/3rdparty/
  if [ ! -f "Pangolin.tar.gz" ]; then
    echo "no Pangolin file"
    git clone https://github.com/stevenlovegrove/Pangolin.git
  else
    echo "there is Pangolin file"
    tar -xzvf Pangolin.tar.gz
    if [ $? -eq 0 ];then
        echo "success tar Pangolin file"
    else
        echo "fail tar Pangolin file"
        exit 1
    fi
  fi
  cd ~/3rdparty/Pangolin
  sudo apt-get install -y libglew-dev
  sudo apt-get install -y libpython2.7-dev
  sudo apt-get install -y ffmpeg libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev
  sudo apt-get install -y libdc1394-22-dev libraw1394-dev
  sudo apt-get install -y libjpeg-dev libpng12-dev libtiff5-dev libopenexr-dev
  cd ~/3rdparty/
  cd Pangolin
  mkdir build
  cd build
  cmake ..
  cmake --build .
  echo ${mypasswd} | sudo -S make install
else
	echo -e "${GREEN}Pangolin has already installed. ${NC}"
fi


#install ceres-solver
if [ ! -d "/usr/local/include/ceres/" ]; then
  cd ~/3rdparty/
  if [ ! -f "ceres-solver-1.14.0.tar.gz" ]; then
    echo "no ceres file"
    exit 1
  else
    echo "there is ceres file"
  	tar -xzvf ceres-solver-1.14.0.tar.gz
    if [ $? -eq 0 ];then
        echo "success tar ceres file"
    else
        echo "fail tar ceres file"
        exit 1
    fi
  fi
  cd ~/3rdparty/ceres-solver-1.14.0
	# CMake
	echo ${mypasswd} | sudo -S apt-get install -y cmake
	sudo apt-get install -y libgoogle-glog-dev
	sudo apt-get install -y libatlas-base-dev
	sudo apt-get install -y libsuitesparse-dev
	mkdir build
	cd build
	cmake ..
	cmake --build .
	echo ${mypasswd} | sudo -S make install
else
	echo -e "${GREEN}ceres has already installed. ${NC}"
fi

#install g2o
if [ ! -d "/usr/local/include/g2o/" ]; then
  cd ~/3rdparty/
  if [ ! -f "g2o.tar.gz" ]; then
    echo "no g2o file"
    exit 1
  else
    echo "there is g2o file"
  	tar -xzvf g2o.tar.gz
    if [ $? -eq 0 ];then
        echo "success tar g2o file"
    else
        echo "fail tar g2o file"
        exit 1
    fi
  fi
  cd ~/3rdparty/g2o
	mkdir build
	cd build
	cmake ..
	cmake --build .
	echo ${mypasswd} | sudo -S make install
else
	echo -e "${GREEN}g2o has already installed. ${NC}"
fi


#install opencv
check_results=`pkg-config opencv --modversion`
if [[ $check_results =~ "3.2.0" ]] 
then 
	echo -e "${GREEN}opencv has already installed. ${NC}"
else 
  echo "This is going to install opencv zlib"
  if [ ! -f "3.2.0.tar.gz" ]; then
    echo "no opencv file"
    wget https://github.com/opencv/opencv/archive/3.2.0.tar.gz
  else
    echo "there is opencv file"
  fi

  tar -xzvf 3.2.0.tar.gz
  if [ $? -eq 0 ];then
      echo "success tar opencv file"
  else
      echo "fail tar opencv file"
      exit 1
  fi
  cd opencv-3.2.0
  sudo apt-get install -y libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
  sudo apt-get install -y python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
  mkdir build
  cd build
  cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
  make -j7
  echo ${mypasswd} | sudo -S make install
fi


#install GeographicLib-1.50.1
if [ ! -d "/usr/local/include/GeographicLib/" ]; then
  cd ~/3rdparty/
  if [ ! -f "GeographicLib-1.50.1.tar.gz" ]; then
		echo -e "${RED}no GeographicLib file ${NC}"    
		exit 1
  else
    echo "there is GeographicLib file"
    tar -xzvf GeographicLib-1.50.1.tar.gz
    if [ $? -eq 0 ];then
        echo "success tar GeographicLib file"
    else
				echo -e "${RED}fail tar GeographicLib file ${NC}"
        exit 1
    fi
  fi
  cd ~/3rdparty/GeographicLib-1.50.1
  mkdir build
  cd build
  cmake ..
  cmake --build .
  echo ${mypasswd} | sudo -S make install
	echo ${mypasswd} | sudo -S mkdir -p /usr/local/share/GeographicLib
  echo ${mypasswd} | sudo -S tar xofjC wgs84.tar.bz2 /usr/local/share/GeographicLib
  echo ${mypasswd} | sudo -S tar xofjC wmm2020.tar.bz2 /usr/local/share/GeographicLib
else
	echo -e "${GREEN}GeographicLib has already installed. ${NC}"
fi



## Install MYNT-EYE-D-SDK 
if [ ! -d "/usr/local/include/mynteyed/" ]; then
  cd ~/3rdparty/
  git clone https://github.com/slightech/MYNT-EYE-D-SDK.git
  cd MYNT-EYE-D-SDK
	git checkout 2b15e36e2e6e131e1a7dc67c3bf6d1ba3e82dbab
	make init
	echo ${mypasswd} | sudo -S make all
	echo ${mypasswd} | sudo -S make install
else
	echo -e "${GREEN}MYNT-EYE-D-SDK has already installed. ${NC}"  
fi

