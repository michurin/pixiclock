#!/bin/sh

#
# Copyright (c) 2010 Alexey Michurin <a.michurin@gmail.com>,
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#

#
# Run your pixiclock on network mode:
# $ pixiclock -p 7070
# start this script, and enjoy!
#

PORT=7070
PIXICLOCK_CLIENT="python ../pixiclock-client -p $PORT"

animation=`
  echo -n 'BG=#ff0000; FG=#ffff00; DELAY=1000; '
  for i in 0 f 0 f 0 f 0 f 0 f 0 f 0 f 0 f
  do
    echo -n "BG=#${i}${i}0000; DELAY=200; "
  done
  echo 'Color animation DELAY=2000'
`

twist=`(
  echo -n 'BG=#ffff00; FG=#660000; DELAY=1000; Twist now!'
  for i in 10 20 30 40 50 60 70 80
  do
    echo -n "GEOMETRY=-$i-10; DELAY=150; "
  done
  echo -n 'DELAY=1000')`

for i in 'Simplest messate (5 seconds)' \
         'FG=#ff0000 Red message' \
         'BG=#ff0000 FG=#ffff00 Red background' \
         "$animation" \
         "$twist"
do
    echo "Message: \"$i\""
    echo "$i" | $PIXICLOCK_CLIENT
    echo '----'
    sleep 1
done
