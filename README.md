# pyORBSLAM2
*Ultra-fast Boost.Python interface for [ORBSLAM2](https://github.com/raulmur/ORB_SLAM2)*

Are you using ORBSLAM2 for your latest tracking project? Do you just want to create a quick prototype, or are you weary of writing C++ code? Then this repository is for you! Simply interface ORBSLAM2 from python2.x/3, using your favourite NumPy arrays as necessary. It is as easy as:

```python
import ORBSLAM2 as os2
slam_obj = os2.SLAM()
slam_obj.init("/slamdoom/libs/orbslam2/Vocabulary/ORBvoc.txt",\
              "/slamdoom/libs/orbslam2/Examples/RGB-D/TUM1.yaml")
slam_obj.track(array, array_d, time.time())
del slam_obj
```


![Isn't it cute? :) ](https://cdn.pixabay.com/photo/2014/04/02/14/05/snake-306109_640.png)

You can use this repo as a basis for any other Boost.Python projects as well.

Please contact me at cs@robots.ox.ac.uk any time and I will assist you!

Best, Christian Schroeder de Witt, Torr Vision Group, University of Oxford, 2017

# Get started

Use run.sh to run nvidia-docker environment to build build/ORBSLAM2.so, which you should then put on your PYTHONPATH.
See test/test.py for an example. Extend orbslam2.cpp to your needs (comes with NumPy/cv::Mat conversion routines, and already includes Boost::Python::NumPy set up for you should you need it)

See below more detailed steps on how to set up the tutorial examples.

# Ubuntu 

Clone this repository (or even better: fork it!)

`git clone git@github.com:torrvision/pyORBSLAM2.git`

Install nvidia-docker plugin: see https://github.com/NVIDIA/nvidia-docker
Note: You require nvidia-docker plugin on host, as Pangolin2 requires OpenGL support

Now run the nvidia-docker container:

`sudo ./run.sh`

(It will take a while to compile OpenCV3)
(SSH password: source)

Now, inside the container SSH shell, simply do:
(ensure build and bin folders are deleted to force CMake to update properly)

`/orbslam/src/build.sh`

`export PYTHONPATH=/orbslam/src/build:$PYTHONPATH`

Now you should be able to try the test example inside the container:

`python3 /orbslam/src/test/test.py`

(press key for GUI windows to open)

The above is for Python3 only, if you require Python2.x support or have any other questions / issues, please contact me:

[cs@robots.ox.ac.uk](mailto:cs@robots.ox.ac.uk)

All the best

Christian
