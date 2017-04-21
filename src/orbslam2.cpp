//--------------------------------C-Code

#include "./include/System.h"
#include <boost/python.hpp>
#include <numpy/ndarrayobject.h>
#include <opencv2/core/core.hpp>

#include "lib/conversion.h"

namespace bpy = boost::python;
using namespace std;

//  need to initialize numpy
#if PY_MAJOR_VERSION >= 3
int
#else
void
#endif
init_numpy()
{
    bpy::numeric::array::set_module_and_type("numpy", "ndarray");
    import_array();
}

class SLAMClass{
    public:
        SLAMClass();

        void init(const std::string &path_to_vocabulary, const std::string &path_to_settings){
            this->slam_obj = new ORB_SLAM2::System(path_to_vocabulary, path_to_settings, ORB_SLAM2::System::RGBD, true);
            std::cout << path_to_vocabulary << std::endl;
        }

        PyObject* track(PyObject* rgb_img, PyObject* d_img, const double timestamp){
            NDArrayConverter cvt;
            cv::Mat rgb_img_mat = cvt.toMat(rgb_img);
            cv::Mat d_img_mat = cvt.toMat(d_img);
            auto camera_matrix = this->slam_obj->TrackRGBD(rgb_img_mat, d_img_mat, timestamp);
            PyObject* ret = cvt.toNDArray(camera_matrix);
            return ret;
        }
        ~SLAMClass();


    private:
        ORB_SLAM2::System *slam_obj;
};

    SLAMClass::SLAMClass() {
        // nothing
    }

    SLAMClass::~SLAMClass() {
        delete this->slam_obj; // Otherwise may end up with a SegFault!!
    }

//--------------------------------Boost-Python-Code


BOOST_PYTHON_MODULE(ORBSLAM2)
{
    using namespace boost::python;
    Py_Initialize(); // required by NumPy
    init_numpy(); // required by NumPy

    class_<SLAMClass>("SLAM")
        .def("init", &SLAMClass::init)
        .def("track", &SLAMClass::track)
    ;

}