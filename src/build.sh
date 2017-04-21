#!/usr/bin/env bash
cmake -DBUILD_PYTHON3=ON -DCMAKE_MODULE_PATH=/usr/local/include/eigen/cmake -DZMQ_INCLUDE_DIR=/usr/local/include -DZMQ_LIBRARY=/usr/local/lib/libzmq.so -DORBSLAM2_LIBRARY=/slamdoom/libs/orbslam2/lib/libORB_SLAM2.so -DBG2O_LIBRARY=/slamdoom/libs/orbslam2/Thirdparty/g2o/lib/libg2o.so -DDBoW2_LIBRARY=/slamdoom/libs/orbslam2/Thirdparty/DBoW2/lib/libDBoW2.so -DCMAKE_BUILD_TYPE=Release .
export CPATH=/usr/local/include/eigen/:/slamdoom/tmp/orbslam2:/slamdoom/libs/cppzmq:/usr/local/include/
export LD_LIBRARY_PATH=/slamdoom/libs/orbslam2/Thirdparty/DBoW2/lib
make -j12
