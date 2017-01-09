#!/bin/sh
set -e
read -p "Numpy version [1.11.2]: " NUMPY_VERSION
NUMPY_VERSION=${NUMPY_VERSION:-'1.11.2'}
read -p "Scipy version [0.18.1]: " SCIPY_VERSION
SCIPY_VERSION=${SCIPY_VERSION:-'0.18.1'}
read -p "Number of build cores [1]:" BUILD_CPUS
BUILD_CPUS=${BUILD_CPUS:-'1'}

echo "Numpy $NUMPY_VERSION, Scipy $SCIPY_VERSION, no. build cores $BUILD_CPUS."

if ! [[ -z "${VIRTUAL_ENV// }" ]]; then
    echo "Working on $VIRTUAL_ENV virtualenv"
else
    read -p "Not working in a virtualenv, are you sure? [y/N]: " -n 1
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo
        echo "Ok... continuing..."
    else
        exit 0
    fi
fi

echo "Installing cython and openblas"
pacaur -S --needed openblas-lapack
pip install cython

echo "Building and installing Numpy $NUMPY_VERSION"
mkdir -p /tmp/src
cd /tmp/src
pip3 download --no-binary :all: numpy==${NUMPY_VERSION}
tar -xvzf numpy-${NUMPY_VERSION}.tar.gz
cd /tmp/src/numpy-${NUMPY_VERSION}
curl -o site.cfg https://raw.githubusercontent.com/determinant-io/manifold-docker/develop/inference/numpy.site.cfg\?token\=ADD9zMv7g7nNnj_RBg_QwldNWpihiE3Rks5YfBGXwA%3D%3D
python3 setup.py build -j ${BUILD_CPUS}
python3 setup.py install

echo "Building and installing Scipy $SCIPY_VERSION"
cd /tmp/src
pip3 download --no-binary :all: scipy==${SCIPY_VERSION}
tar -xvzf scipy-${SCIPY_VERSION}.tar.gz
cd /tmp/src/scipy-${SCIPY_VERSION}
curl -o site.cfg https://raw.githubusercontent.com/determinant-io/manifold-docker/develop/inference/scipy.site.cfg?token=ADD9zEqw38ciR4Nfhx_7V7N4e-zO7oocks5YfBU8wA%3D%3D
python3 setup.py build -j ${BUILD_CPUS}
python3 setup.py install

echo "All done!"
