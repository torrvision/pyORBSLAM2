# pyORBSLAM2
Ultra-fast Boost.Python interface for ORBSLAM2

Use run.sh to run nvidia-docker environment to build build/ORBSLAM2.so, which you should then put on your PYTHONPATH.
See test/test.py for an example. Extend orbslam2.cpp to your needs (comes with NumPy/cv::Mat conversion routines, and already include Boost::Python::NumPy set up for you should you need it)

I have no time right now to write an extended documentation, but please contact me at cs@robots.ox.ac.uk any time and I will assist you.

Best, Christian Schroeder de Witt, Torr Vision Group, University of Oxford, 2017
