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
# This tricky script to check GMail and notify if any.
# It prints letters headers.
#
# Set up it the same way as check-gmail-simple.sh
#

PORT=7070
PIXICLOCK_CLIENT="python ../pixiclock-client -p $PORT"

f=`
curl -n 'https://mail.google.com/mail/feed/atom' 2>/dev/null |
sed -n '/<entry>/, /<\/entry>/ p' |
sed -n '/title/ p' |
sed 's/<title>/- /;s/<.title>/ -/'`
if test "a$f" != 'a'
then
  echo "BG=#000000;FG=#ffffff;DELAY=3000;$f" | $PIXICLOCK_CLIENT
fi
