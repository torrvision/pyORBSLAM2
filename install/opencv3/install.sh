#!/usr/bin/env bash

apt-get install -y git cmake

if [ ! -d "$DIRECTORY" ]; then
    mkdir -p $1
    apt-get -y install libopencv-dev build-essential cmake git libgtk2.0-dev pkg-config python-dev python-numpy libdc1394-22 libdc1394-22-dev libhdf5-serial-dev libjpeg-dev libpng12-dev libjasper-dev libavcodec-dev libavformat-dev libswscale-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev libtbb-dev libqt4-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils unzip
    cd $1
    git clone https://github.com/opencv/opencv.git opencv3
    git clone https://github.com/opencv/opencv_contrib.git opencv3_contrib
    cd $1/opencv3_contrib
    git checkout d879ea48b696ec9ba8d1d5fd4d9688fa230e8515
    cd $1/opencv3
    git checkout 976ee4468276d8f90403cc0885b8fd8576c58f4d
    mkdir $1/opencv3
    mkdir build
fi

if [ "$2" = "python3" ]; then
    cd $1/opencv3/build
    cmake -DCMAKE_BUILD_TYPE=RELEASE \
          -DCMAKE_INSTALL_PREFIX=$1/opencv3 \
          -DOPENCV_EXTRA_MODULES_PATH=$1/opencv3_contrib/modules \
          -DWITH_CUDA=ON \
          -DCUDA_GENERATION=Kepler \
          -DWITH_CUBLAS=ON \
          -DCUDA_FAST_MATH=ON \
          -DWITH_NVCUVID=ON \
          -DWITH_OPENGL=OFF \
          -DWITH_OPENCL=OFF \
          -DENABLE_AVX=ON \
          -DENABLE_FAST_MATH=ON \
          -DBUILD_TIFF=ON \
          -DWITH_CSTRIPES=ON \
          -DWITH_EIGEN=OFF \
          -DWITH_IPP=ON \
          -DWITH_TBB=ON \
          -DWITH_OPENMP=ON \
          -DENABLE_SSE42=ON \
          -DWITH_V4L=ON \
          -DWITH_VTK=OFF \
          -DBUILD_opencv_java=OFF \
          -DBUILD_EXAMPLES=OFF \
          -DBUILD_opencv_apps=OFF \
          -DBUILD_DOCS=OFF \
          -DBUILD_PERF_TESTS=OFF \
          -DBUILD_TESTS=OFF \
          -DBUILD_opencv_dnn=OFF \
          -DBUILD_opencv_xfeatures2d=OFF \
          -DBUILD_opencv_python2=OFF \
          -DBUILD_NEW_PYTHON_SUPPORT=ON \
          -DPYTHON_EXECUTABLE=$(which python3) \
          -DPYTHON_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
          -DPYTHON_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
          -DPYTHON3_EXECUTABLE=$(which python3) \
          -DPYTHON3_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
          -DPYTHON3_LIBRARY=/home/cs/.pyenv/versions/3.6.0/lib/libpython3.6m.a \
          -DPYTHON3_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
          ..
    make -j12 && make install
else
    cd $1/opencv3/build
    cmake -DCMAKE_BUILD_TYPE=RELEASE \
          -DCMAKE_INSTALL_PREFIX=$1/opencv3 \
          -DOPENCV_EXTRA_MODULES_PATH=$1/opencv3_contrib/modules \
          -DWITH_CUDA=ON \
          -DCUDA_GENERATION=Kepler \
          -DWITH_CUBLAS=ON \
          -DCUDA_FAST_MATH=ON \
          -DWITH_NVCUVID=ON \
          -DWITH_OPENGL=OFF \
          -DWITH_OPENCL=OFF \
          -DENABLE_AVX=ON \
          -DENABLE_FAST_MATH=ON \
          -DBUILD_TIFF=ON \
          -DWITH_CSTRIPES=ON \
          -DWITH_EIGEN=OFF \
          -DWITH_IPP=ON \
          -DWITH_TBB=ON \
          -DWITH_OPENMP=ON \
          -DENABLE_SSE42=ON \
          -DWITH_V4L=ON \
          -DWITH_VTK=OFF \
          -DBUILD_opencv_java=OFF \
          -DBUILD_EXAMPLES=OFF \
          -DBUILD_opencv_apps=OFF \
          -DBUILD_DOCS=OFF \
          -DBUILD_PERF_TESTS=OFF \
          -DBUILD_TESTS=OFF \
          -DBUILD_opencv_dnn=OFF \
          -DBUILD_opencv_xfeatures2d=OFF \
          -DBUILD_opencv_python2=ON \
          -DPYTHON_EXECUTABLE=$(which python) \
          -DPYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
          -DPYTHON_PACKAGES_PATH=$(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
          ..
    make -j12 && make install
fi