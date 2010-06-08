#!/usr/local/bin/python


# Copyright (c) 2010 Alexey Michurin <a.michurin@gmail.com>

# Example rss-feed reader for hh.ru.
# (slightly modified version of rss-reader.py)
# C++
# Moscow


URL = 'http://hh.ru/rss/searchvacancy.xml?areaId=1&desireableCompensation=60000&vacancyNameField=true&text=C%2B%2B&itemsOnPage=100&compensationCurrencyCode=RUR&orderBy=2&searchPeriod=30&professionalAreaId=0'
DELAY = 100


import urllib
from xml.dom import minidom
from time import sleep
import sys


def get_data(e, t, d='-'):
    c = e.getElementsByTagName(t)[0].firstChild
    if c is None:
        return d
    return c.data


class reader:

    def __init__(o, url):
        o.last_date = 0
        o.url = url

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
            a = (
            '' +
            get_data(i, 'hhvac:vacancyId') +
            '\n' +
            get_data(i, 'title') +
            '\n   ' +
            get_data(i, 'hhvac:employerName') +
            ' / ' +
            get_data(i, 'hhvac:areaName') +
            '\n   ' +
            get_data(i, 'hhvac:compensationFrom', '0') +
            ' - ' +
            get_data(i, 'hhvac:compensationTo', 'inf') +
            ' ' +
            get_data(i, 'hhvac:compensationCurrency', 'peso')
            )
            b = i.getElementsByTagName('pubDate')[0].firstChild.data
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
                if len(feed) > 1000:
                    feed += '\n...'
                    break
            o.last_date = arr[0][1]
            return feed
        else:
            return None


def main():
    o = reader(URL)
    effect = 'BG=#cde3fc;FG=#000000;GEOMETRY=+10-10\n'
    for i in range(8):
        j = 7 - i
        effect += ('BDWIDTH=' + str(j) +
                   ';MARGIN=' + str(i) +
                   ';BD=#' + (('%x' % ((i%2)*15))*6) +
                   ';DELAY=70\n')
    while True:
        f = o()
        if f:
            sys.stdout.write(
              f.encode('utf-8') + effect +
              ('DELAY=%s;' % min(len(f)*400, 120000))
            )
            sys.stdout.flush() # do not forget! or use os.write(1)
        # we done. update time and go to sleep
        sleep(DELAY)


if __name__ == '__main__':
    main()
