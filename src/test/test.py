import cv2
import numpy as np
import ORBSLAM2 as os2
from time import sleep
import time

def test_SLAM_init():
    # "/slamdoom/libs/orbslam2/Vocabulary/ORBvoc.txt"
    # "/slamdoom/libs/orbslam2/Examples/RGB-D/TUM1.yaml"
    print("Initializing SLAM...")
    slam_obj = os2.SLAM()
    slam_obj.init("/slamdoom/libs/orbslam2/Vocabulary/ORBvoc.txt", "/slamdoom/libs/orbslam2/Examples/RGB-D/TUM1.yaml")
    print("SLAM was successfully initialized!")
    input("Press key to continue...")
    for i in range(1000):
        array = np.random.randint(256, size=320 * 240 * 3, dtype=np.uint8).reshape((320, 240, 3))
        array_d = np.random.rand(320, 240, 1).astype("float32") * 50
        slam_obj.track(array, array_d, time.time())
        sleep(1)
    print("SLAM was successfully continued!")
    input("Press key to finish...")
    pass

if __name__ == "__main__":
    test_SLAM_init()