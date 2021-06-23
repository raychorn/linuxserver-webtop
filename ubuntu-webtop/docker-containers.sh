#!/bin/bash

COMMAND=$1

if [[ $COMMAND. == . ]]
then
    echo "COMMAND can be one of the following:"
    echo "    logs ... show logs"
    echo "    mounts ... show mounts"
    echo "    shell ... show shell"
    exit
fi

CNAME=webtop

ARRAY=()

END=999
for ((i=0;0<=END;i++)); do
    COUNT=0
    #echo "(0) i=$i"
    if [ "$i" -eq "0" ]; then
        CID=$(docker ps -qf "name=$CNAME")
        #echo "(1) $CNAME -> $CID"
        if [[ ! $CID. == . ]] ; then
            ARRAY+=("$CNAME")
            #echo "(2) $CNAME -> $CID"
            COUNT=$((COUNT + 1))
        fi
    else
        CID=$(docker ps -qf "name=$CNAME$i")
        #echo "(3) $CNAME$i -> $CID"
        if [[ ! $CID. == . ]] ; then
            ARRAY+=("$CNAME$i")
            #echo "(4) $CNAME$i -> $CID"
            COUNT=$((COUNT + 1))
        fi
    fi

    #echo "(5) COUNT=$COUNT"
    if [ "$COUNT" -eq "0" ]; then
        echo "DONE gathering container names."
        break
    fi
done

PS3="Choose: " 

select option in "${ARRAY[@]}";
do
    echo "Choose: $REPLY"
    choice=${ARRAY[$REPLY-1]}
    break
done

CID=$(docker ps -qf "name=$choice")
echo "CID=$CID"
if [[ ! $CID. == . ]]
then
    if [ "$COMMAND" == "logs" ]; then
        echo "Showing logs $CID"
        docker logs --tail 2500 $CID
    fi
    if [ "$COMMAND" == "mounts" ]; then
        echo "Showing mounts $CID"
        docker inspect -f "{{ .Mounts }}" $CID
    fi
    if [ "$COMMAND" == "shell" ]; then
        echo "Shell for $CID"
        docker exec -it $CID bash
    fi
fi
