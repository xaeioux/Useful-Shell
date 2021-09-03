#!/bin/sh
file=100

cd /tmp
while [ $file -le 999 ]
do
    rm tmp-"$file"*
    echo Removido arquivo tmp-$file
    file=$((file+1))
done
