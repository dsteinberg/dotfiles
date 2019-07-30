# Paths
# source /etc/profile

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"
# export PYTHONPATH=$PYTHONPATH

# VirtualEnv Paths
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Code
source `which virtualenvwrapper.sh`

# Qt scaling issues
export QT_AUTO_SCREEN_SCALE_FACTOR=1
