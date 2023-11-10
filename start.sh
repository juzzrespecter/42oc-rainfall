#!/bin/bash

IP=10.11.200.50
LVL=${1: -1}
PREV=$([ "$LVL" != "0" ] && echo "level$(expr $LVL - 1)" || echo "level0")
SELCLIP=$([ "$(uname)" = "Linux" ] && echo "xclip -sel clip" || echo "pbcopy")

if [ "$1" == "" ]; then
    echo "Please select a level environment" 1>&2;
    exit 1;
fi

cat $PREV/flag.txt | $SELCLIP && \
scp -P 4242 $1@$IP:/home/user/$1/$1 $PWD/$1 && \
docker build . -t rain && \
docker run -it \
            --name rain \
            --rm \
            -v $PWD/$1:/$1-utils \
            rain \
            /bin/bash