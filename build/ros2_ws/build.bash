#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0); pwd)
DISTRO=${1:-humble}
BUILD_FULL_PKG=${2:-false}

echo "=========== Build options ==========="
echo "DISTRO: ${DISTRO}"
echo "BUILD_FULL_PKG: ${BUILD_FULL_PKG}"
echo "====================================="
echo ""

if [ -z "$DISTRO" ]; then
    DISTRO=humble
    echo "No distro specified, using default: ${DISTRO}"
fi

. ~/.bashrc
echo "========================================"
# lib
cmake --version

cd ${SCRIPT_DIR}
rm -rf ${SCRIPT_DIR}/ros2.repos
wget https://raw.githubusercontent.com/ros2/ros2/${DISTRO}/ros2.repos


if [ ${BUILD_FULL_PKG} = true ]; then
    echo "Building full package"
#    wget https://raw.githubusercontent.com/Ar-Ray-code/rpi-bullseye-ros2/main/repos/ds.repos
#    wget https://raw.githubusercontent.com/Ar-Ray-code/rpi-bullseye-ros2/main/repos/realsense.repos
    wget https://raw.githubusercontent.com/Ar-Ray-code/rpi-bullseye-ros2/main/repos/rostackchan.repos
    wget https://raw.githubusercontent.com/Ar-Ray-code/rpi-bullseye-ros2/main/repos/urg.repos
#    wget https://raw.githubusercontent.com/Ar-Ray-code/rpi-bullseye-ros2/main/repos/velodyne.repos
#    wget https://raw.githubusercontent.com/Ar-Ray-code/rpi-bullseye-ros2/main/repos/webcam.repos

    for f in *.repos; do
        echo "---- importing $f ----"
        vcs import src < $f
    done
else
    echo "Building minimal package"
    vcs import src < ros2.repos
fi

vcs import src << EOF
repositories:
  ros-perception/vision_opencv:
    type: git
    url: https://github.com/ros-perception/vision_opencv.git
    version: humble
EOF


touch src/ros-visualization/CATKIN_IGNORE
touch src/ros-visualization/COLCON_IGNORE
touch src/ros2/rviz/COLCON_IGNORE
touch src/ros2/examples/COLCON_IGNORE 
touch src/ros2/demos/COLCON_IGNORE
touch src/eclipse-cyclonedds/COLCON_IGNORE
touch src/eclipse-iceoryx/COLCON_IGNORE
touch src/ros/ros_tutorials/COLCON_IGNORE


rosdep update
# rosdep install -r -y -i --from-paths /ros2_ws/src/ --rosdistro ${DISTRO}

if [ ${DISTRO} = "iron" ]; then
    rm -rf src/ignition*
fi

colcon build --install-base $(pwd)/${DISTRO}/ --merge-install --cmake-args -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="-march=armv8-a+crc -mtune=cortex-a72 -O3" -DCMAKE_C_FLAGS="-march=armv8-a+crc -mtune=cortex-a72 -O3"

if [ $? -ne 0 ]; then
    exit 1
fi

echo "All packages built successfully"
unset COLCON_OPTION
exit 0
