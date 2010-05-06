#!/usr/local/bin/python

# Copyright (c) 2010 Alexey Michurin <a.michurin@gmail.com>

URL = 'http://news.yandex.ru/world.rss'

import urllib
from xml.dom import minidom
from time import mktime, strptime, sleep
import sys

last_date = 0

while True:
    # we get DOM from URL
    dom = minidom.parse(urllib.urlopen(URL))
    # now collect titles
    arr = []
    for i in dom.getElementsByTagName('item'):
        a = i.getElementsByTagName('title')[0].firstChild.data.encode('utf-8')
        l = i.getElementsByTagName('pubDate')[0].firstChild.data
        # in modern pythons use %z instead '+0400'
        b = int(mktime(strptime(l, '%a, %d %b %Y %H:%M:%S +0400')))
        arr.append((a, b))
    # sort it
    arr.sort(key=lambda x: x[1], reverse=True)
    # if we has any news...
    if last_date < arr[0][1]:
        # ...we ptint out message
        print 'GEOMETRY=-200-10;BG=#FFFF99;FG=#000000;DELAY=10000'
        for a, b in arr:
            if b > last_date:
                print a
    sys.stdout.flush() # do not forget! or use os.write(1)
    # we done. update time and go to sleep
    last_date = arr[0][1]
    sleep(100)
