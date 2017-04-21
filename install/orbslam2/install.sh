# Install Pangolin and other ORBSLAM dependencies
apt-get install -y libglew-dev
cd /slamdoom/libs
git clone https://github.com/stevenlovegrove/Pangolin pangolin
cd /slamdoom/libs/pangolin
mkdir build && cd build && cmake .. && make -j12 && make install
cd /slamdoom/libs
wget http://bitbucket.org/eigen/eigen/get/3.3.3.tar.bz2 && bzip2 -d 3.3.3.tar.bz2 && tar -xvf 3.3.3.tar && rm 3.3.3.tar && mv eigen-* eigen
ln -s /slamdoom/libs/eigen /usr/local/include/eigen
cd /slamdoom/tmp
# Install ORBSLAM2
git clone https://github.com/raulmur/ORB_SLAM2.git orbslam2
cd /slamdoom/tmp/orbslam2
git config --global user.name "Slamdoom" && git config --global user.email "slamdoom@slam.doom" && git am --signoff < /slamdoom/install/orbslam2/orbslam2_slamdoom.git.patch
chmod +x build.sh && sleep 1 && ./build.sh
cp -R /slamdoom/tmp/orbslam2 /slamdoom/libs/orbslam2
