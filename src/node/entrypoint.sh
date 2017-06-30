#!/bin/sh

npm_install()
{
    cd $1
    npm i $2
}

npm_install_global()
{
    for i in $(echo $1 | tr ";" "\n")
    do
        npm i -g $i $2
    done
}

exec_cmd()
{
    cd $1
    shift;
    exec "$@"
}

# trimming
NPM_OPTIONS="${NPM_OPTIONS%\"}"
NPM_OPTIONS=" ${NPM_OPTIONS#\"}"

# install local packages
if [ "$INSTALL_DIR" != "" ]; then
    npm_install $INSTALL_DIR $NPM_OPTIONS
fi

# install global packages
if [ "$GLOBAL_INSTALLS" != "" ]; then
    npm_install_global $GLOBAL_INSTALLS $NPM_OPTIONS
fi

# run command passed to docker run
if [ "$WORK_DIR" != "" ]; then
    exec_cmd $WORK_DIR "$@"
else
    exec "$@"
fi