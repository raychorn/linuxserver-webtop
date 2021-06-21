#!/bin/bash

container="webtop" 

if ! [ -d ./home ]
then
    mkdir ./home
fi

docker-compose up -d

CID=$(docker ps -qf "name=$container")
echo "CID=$CID"
if [[ ! $CID. == . ]]
then
    echo "$container is running"
else
    echo "$container is not running"
fi
