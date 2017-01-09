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

# Somehow each version of numpy/scipy have different archive formats...
# http://askubuntu.com/questions/57981/command-line-archive-manager-extracter
# we could also use file-roller or dtrx, but that is an extra dep...
extract () {
   if [ -f $1 ] ; then
      case $1 in
         *.tar.bz2)   tar xjf $1      ;;
         *.tar.gz)   tar xzf $1      ;;
         *.bz2)      bunzip2 $1      ;;
         *.rar)      rar x $1      ;;
         *.gz)      gunzip $1      ;;
         *.tar)      tar xf $1      ;;
         *.tbz2)      tar xjf $1      ;;
         *.tgz)      tar xzf $1      ;;
         *.zip)      unzip $1      ;;
         *.Z)      uncompress $1   ;;
         *)         echo "'$1' cannot be extracted via extract()" ;;
      esac
   else
      echo "'$1' is not a valid file"
   fi
}

# Build may fail without these
export Atlas=None
export LDFLAGS="$LDFLAGS -shared"

# NUMPY
echo "Building and installing Numpy $NUMPY_VERSION"
mkdir -p /tmp/src
cd /tmp/src
pip3 download --no-binary :all: numpy==${NUMPY_VERSION}
extract numpy-${NUMPY_VERSION}.*
cd /tmp/src/numpy-${NUMPY_VERSION}
curl -o site.cfg https://raw.githubusercontent.com/determinant-io/manifold-docker/develop/inference/numpy.site.cfg\?token\=ADD9zMv7g7nNnj_RBg_QwldNWpihiE3Rks5YfBGXwA%3D%3D
python3 setup.py config_fc --fcompiler=gnu95 build -j ${BUILD_CPUS}
python3 setup.py install --optimize=1

# SCIPY
echo "Building and installing Scipy $SCIPY_VERSION"
cd /tmp/src
pip3 download --no-binary :all: scipy==${SCIPY_VERSION}
extract scipy-${SCIPY_VERSION}.*
cd /tmp/src/scipy-${SCIPY_VERSION}
curl -o site.cfg https://raw.githubusercontent.com/determinant-io/manifold-docker/develop/inference/scipy.site.cfg?token=ADD9zEqw38ciR4Nfhx_7V7N4e-zO7oocks5YfBU8wA%3D%3D
# python3 setup.py config_fc --fcompiler=gnu95 build -j4 # Fails on Arch!
python3 setup.py config_fc --fcompiler=gnu95 build
python3 setup.py install --optimize=1

echo "All done!"
