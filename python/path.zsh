if [[ "$OSTYPE" == "darwin"* ]]
then
    # alias `python` to Homebrew's python3
    export PATH=/usr/local/opt/python/libexec/bin:$PATH
fi

# virtualenv
virtualenv_path=$HOME/.virtualenvs

if [ -d virtualenv_path ]
then
    export VIRTUALENVWRAPPER_PYTHON=`which python`
    export WORKON_HOME=$HOME/.virtualenvs
    virtualenvwrapperlocs=("$HOME/Library/Python/3.7/bin/virtualenvwrapper.sh" "/usr/local/bin/virtualenvwrapper.sh" "/opt/homebrew/bin/virtualenvwrapper.sh")
    found=false
    for loc in "${virtualenvwrapperlocs[@]}"
    do
        if [ -f $loc ]
        then
            source "${loc}"
            found=true
    break
        fi
    done
    if ! $found
    then
        echo "Could not find virtualenvwrapper.sh."
    fi
    unset locs
    unset found
fi

unset virtualenv_path
