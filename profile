# Paths
# source /etc/profile

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"
# export PYTHONPATH=$PYTHONPATH

# VirtualEnv Paths
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Code
source `which virtualenvwrapper.sh`

if [ -e /home/dsteinberg/.nix-profile/etc/profile.d/nix.sh ]; 
then . /home/dsteinberg/.nix-profile/etc/profile.d/nix.sh; 
fi # added by Nix installer
