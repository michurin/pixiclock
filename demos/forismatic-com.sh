#!/bin/sh

# Copyright (c) 2010 Alexey Michurin <a.michurin@gmail.com>

# usage:
# pixiclock -c /full_path_to/forismatic-com.sh

lang=en # or lang=ru

while :
do
  n=`date +%s`
  n=$(($n%1000000))
  wget -qO- --post-data='method=getQuote&key='$n'&format=text&lang='$lang \
    http://api.forismatic.com/api/1.0/ | fmt -w 40
  echo "($n)"
  echo 'BG=#000000'
  for i in 0 1 2 3 4 5 6 7 8 9 a b c d e f
  do
    echo "FG=#$i$i$i$i$i$i;DELAY=100"
  done
  echo 'DELAY=10000'
  sleep 1000
done
