#!/bin/bash

if [ "$1" == "" ]; then
    echo "Please select a level environment" 1>&2;
    exit 1;
fi

docker build . -t rain
docker run -it \
            --name rain \
            --rm \
            -v $PWD/$1:/$1-utils \
            rain \
            /bin/bash