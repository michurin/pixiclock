#!/bin/sh


# Copyright (c) 2010 Alexey Michurin <a.michurin@gmail.com>

# usage (pipe mode):
# pixiclock -c /path/forismatic-com.sh
#
# or (network mode):
# pixiclock -n
# forismatic-com.sh

client=pixiclock-client # or client='python ../pixiclock-client'
lang=en # or lang=ru

if test "a$PIXICLOCK" != 'a'
then
  client=cat
fi

while :
do
  (
  n=`date +%s`
  n=$(($n%1000000))
  wget -qO- --post-data='method=getQuote&key='$n'&format=text&lang='$lang \
    http://api.forismatic.com/api/1.0/ | fmt -w 40
  echo "($n)"
  echo 'BG=#444444'
  a=''
  b=''
  for i in 4 5 6 7 8 9 a b c d
  do
    c="FG=#$i$i$i$i$i$i;DELAY=100;"
    a="$a$c"
    b="$c$b"
  done
  echo "${a}DELAY=10000;$b"
  ) | $client
  sleep 100
done
