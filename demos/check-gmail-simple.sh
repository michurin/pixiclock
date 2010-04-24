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
# This very simple script to check GMail and notify if any.
#
# How to setup.
#
# 1) Put this script where you want. Lets say:
# $ cp check-gmail-simple.sh /HOME/USER/bin/check-gmail-simple.sh
#
# 2) Setup your ~/.netrc file. Add section like this:
# machine mail.google.com
#         login your-gmail-login
#         password your-gmail-password
#
# 3) Add script to crontab to check GMail every 10 minutes:
# $ crontab -e
# add line
# */10 * * * * /HOME/USER/bin/check-gmail-simple.sh
#
# 4) Force pixiclock to listen notifications:
# $ pixiclock -p 7070
#
# Enjoy!
#

PORT=7070
PIXICLOCK_CLIENT="python ../pixiclock-client -p $PORT"

curl -n 'https://mail.google.com/mail/feed/atom' 2>/dev/null |
sed -n '/fullcount/p' |
grep '>0<' >/dev/null ||
echo 'BG=#880000;FG=#ffffff;DELAY=600;BG=#444444;DELAY=600;New GMail!' |
$PIXICLOCK_CLIENT
