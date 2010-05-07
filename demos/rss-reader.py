#!/usr/local/bin/python


# Copyright (c) 2010 Alexey Michurin <a.michurin@gmail.com>


URL = 'http://rss.cnn.com/rss/edition.rss'
FMT = '%a, %d %b %Y %H:%M:%S EDT'
BG = '#ffff99'
FG = '#000000'
DELAY = 100


import urllib
from xml.dom import minidom
from time import mktime, strptime, sleep
import sys


class reader:

    def __init__(o, url, fmt):
        o.last_date = 0
        o.url = url
        o.fmt = fmt

    def __call__(o):
        try:
            data = urllib.urlopen(o.url)
        except Exception, e:
            return 'ERROR: urllib.urlopen(%s):\n%s' % (o.url, str(e))
        try:
            dom = minidom.parse(data)
        except Exception, e:
            return 'ERROR: Can not parse XML'
        arr = []
        for i in dom.getElementsByTagName('item'):
            a = i.getElementsByTagName('title')[0].firstChild.data.encode('utf-8')
            l = i.getElementsByTagName('pubDate')[0].firstChild.data
            # Some feeds can use alternative time format.
            # Look at the options %Z or %z (modern Python only).
            try:
                b = int(mktime(strptime(l, o.fmt)))
            except ValueError, e:
                return ('ERROR: %s\n'
                        'Fix FMT variable at the beginning of the program'
                       ) % str(e)
            arr.append((a.strip(), b))
        # sort it
        arr.sort(key=lambda x: x[1], reverse=True)
        # if we has any news...
        if o.last_date < arr[0][1]:
            # ...we prepare message
            feed = ''
            for a, b in arr:
                if b > o.last_date:
                    feed += '\n' + a
            o.last_date = arr[0][1]
            return feed
        else:
            return None


def main():
    o = reader(URL, FMT)
    while True:
        f = o()
        if f:
            sys.stdout.write(
              'GEOMETRY=+10-10;BG=%s;FG=%s;DELAY=%s;%s' % (
                   BG, FG, min(len(f)*100, 20000), f)
            )
            sys.stdout.flush() # do not forget! or use os.write(1)
        # we done. update time and go to sleep
        sleep(DELAY)


if __name__ == '__main__':
    main()
