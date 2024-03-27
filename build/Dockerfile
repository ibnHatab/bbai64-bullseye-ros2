ARG DEBIAN_DISTRO=bullseye
FROM arm64v8/debian:${DEBIAN_DISTRO}

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt install locales -y && \
    locale-gen en_US en_US.UTF-8 && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/*
ENV LANG=en_US.UTF-8

RUN apt-get update && \
	apt-get install -y \
	pciutils \
	xterm \
	libacl1-dev \
	libtinyxml2-dev \
	bison \
	libasio-dev \
	libeigen3-dev \
	libxrandr-dev \
	libxcursor-dev \
	libsdl2-dev \
	mingw-w64-i686-dev \
	liblog4cxx-dev \
	python3-lark \
	build-essential \
	cmake \
	git \
	python3-flake8 \
	python3-pip \
	python3-pytest-cov \
	python3-rosdep2 \
	python3-setuptools \
	wget \
	curl \
	gnupg \
	lsb-release \
	python3-sip \
	libopencv-dev \
	libbullet-dev \
	sip-dev \
	python3-numpy \
	python3-pydot \
	python3-netifaces \
	libfreetype-dev \
	libresource-retriever-dev \
	python3-jinja2 \
	pkg-config \
	libpcl-dev \
	libyaml-cpp-dev \
	libpcap-dev \
	libfmt-dev \
	librange-v3-dev && \
	rm -rf /var/lib/apt/lists/*

# RUN pip install --upgrade pip

RUN pip install  \
	flake8-blind-except \
	flake8-builtins \
	flake8-class-newline \
	flake8-comprehensions \
	flake8-deprecated \
	flake8-docstrings \
	flake8-import-order \
	flake8-quotes \
	pytest-repeat \
	pytest-rerunfailures \
	pytest \
	setuptools \
	importlib-metadata \
	importlib-resources \
	lark-parser \
	cython \
	typeguard

# cmake upgrade
#RUN wget https://github.com/Kitware/CMake/releases/download/v3.27.2/cmake-3.27.2-linux-aarch64.sh -O cmake_install.sh && \
#	chmod +x cmake_install.sh && \
#	./cmake_install.sh --skip-license --prefix=/usr/local

# OpenVINO
#RUN wget https://s3.ap-northeast-1.wasabisys.com/download-raw/dpkg/openvino/debian/bullseye/openvino-2022-raspbian-bullseye-arm64-0.1.0-20221219.deb && \
#	apt-get install -y ./openvino-2022-raspbian-bullseye-arm64-0.1.0-20221219.deb
#
# realsense
#RUN wget https://s3.ap-northeast-1.wasabisys.com/download-raw/dpkg/librealsense/debian/bullseye/librealsense2-dev_2.54.1_arm64.deb && \
#	apt-get install -y ./librealsense2-dev_2.54.1_arm64.deb && \
#	rm ./librealsense2-dev_2.54.1_arm64.deb && \
#	echo "export realsense2_DIR=/usr/local/lib/aarch64-linux-gnu/cmake/realsense2/" >> ~/.bashrc && \
#	echo "export OpenCV_DIR=/usr/lib/aarch64-linux-gnu/cmake/opencv4/" >> ~/.bashrc


RUN pip install vcstool colcon-common-extensions

RUN mkdir -p /ros2_ws/src
WORKDIR /ros2_ws
