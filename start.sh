#!/bin/bash
#
# autor: Jesus Salas
#
server=$1

virt='00:30:67:2b:39:1d'
media='00:9c:02:20:0a:ff'

case $server in
    "virt") wakeonlan $virt
            sleep 1
            echo "media-serv starting"
            echo -ne '[########                  ](33%)\r'
            sleep 1
            echo -ne '[###############           ](66%)\r'
            sleep 1
            echo -ne '[##########################](100%)\r'
            echo -ne '\n'
            echo "media-serv started"
            exit 0;;
    "media") wakeonlan $media
             sleep 1
             echo "media-serv starting"
             echo -ne '[########                  ](33%)\r'
             sleep 1
             echo -ne '[###############           ](66%)\r'
             sleep 1
             echo -ne '[##########################](100%)\r'
             echo -ne '\n'
             echo "media-serv started"
             exit 0;;
    *) echo "unknown server"
       exit 1
       ;;
esac
