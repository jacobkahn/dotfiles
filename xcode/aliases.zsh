# switch nicely between versions of Xcode [command line tools]
# assumes different versions of Xcode are installed as "Xcode-[version].app" in /Applications
xcode-quickselect () {
  if [ -z "$1" ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]
  then
        echo "xcode-quickselect
  Usage:
      -h [--help] :                 displays this dialog
      -l [--list] :                 lists installations of Xcode

      xcode-quickselect [version]:  If 'default', switches to the newest or
                                    default version of Xcode on the system.
                                    otherwise, searches for Xcode-[version]
                                    in /Applications, and executes xcode-select.
        "
    return
  fi
  # list versions
  if [ "$1" = "--list" ] || [ "$1" = "-l" ]
  then
    echo "$(ls /Applications | grep Xcode)"
    return
  fi
  # find version
  local version= 
  local versionstring=
  if [ ! "$1" = "default" ]
  then
      versionstring="-$1"
  fi
  # switch
  echo $versionstring
  $(sudo xcode-select --switch /Applications/Xcode$versionstring.app)
}
