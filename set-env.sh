#!/bin/bash

#called=$_
#[[ $called != $0 ]] && echo "Script is being sourced" || echo "Script is being run"
#echo "\$BASH_SOURCE ${BASH_SOURCE[@]}"
scriptdir=$(cd $(dirname ${BASH_SOURCE[@]}); pwd -P)

#scriptdir=$(cd $(dirname $0); pwd -P)
echo "set-env.sh script directory: $scriptdir"

# export a variable that indicates that Catena environment is setup
export CATENA_ENV=1

# add Bitcoin-related scripts to PATH; we need easy access to them
btcscripts=btc-scripts
if ! echo "$PATH" | grep "$scriptdir/$btcscripts" >/dev/null; then
    export PATH="$scriptdir/$btcscripts:$PATH"
    echo "Set \$PATH to $PATH..."
else
    echo "\$PATH already set to $PATH"
fi

if [ "$(uname -s)" = "Darwin" ]; then
    export PATH="$PATH:$HOME/repos/bitcoin/src"
fi

# ignore .git directory, always display line numbers, etc.
alias grep='grep -In --color=auto --exclude-dir=.git'
