# virtualenv
virtualenv_path=$HOME/.virtualenvs

if [ -d virtualenv_path ]
then
    export WORKON_HOME=$virtualenv_path
    export VIRTUALENVWRAPPER_PYTHON=`which python3`
    LOC1="/usr/local/bin/virtualenvwrapper.sh"
    LOC2="/opt/homebrew/bin/virtualenvwrapper.sh"
    if [ -f "$LOC1" ]
    then
        source "$LOC1"
    elif [ -f "$LOC2" ]
    then
        source "$LOC2"
    else
        echo "Could not find virtualenvwrapper.sh."
    fi
    unset LOC1
    unset LOC2
    
    # miniconda
    if [ -d "$HOME/.miniconda3" ]
    then
        export PATH="$HOME/.miniconda3/bin:$PATH"
        . $HOME/.miniconda3/etc/profile.d/conda.sh
    conda activate
    fi
fi

unset virtualenv_path
