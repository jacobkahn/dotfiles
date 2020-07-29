# rbenv

rbenv_path="$HOME/.rbenv"
if [ -d $rbenv_path ]
then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

unset rbenv_path
