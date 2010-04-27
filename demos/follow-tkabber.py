#!/usr/local/bin/python


# Copyright (c) 2010 Alexey Michurin <a.michurin@gmail.com>


import Tkinter as Tk
import sys
import socket
import os


host = 'localhost'
port = 7070
message_prefix = ''.join(map(
    lambda x: 'FG=#ffffff;BG=#00%x000;DELAY=80;' % x,
    range(15)))


def parse(m):
    a = []
    n = True
    while m:
        c = m[0]
        m = m[1:]
        if c == '{':
            m, x = parse(m)
            a.append(x)
        elif c == '}':
            return m, a
        elif c == '\x20':
            if not n:
                n = True
        else:
            if n:
                a.append('')
                n = False
            a[-1] += c
    return a


class app(Tk.Tk):

    def __init__(o, host, port, message_prefix):
        Tk.Tk.__init__(o)
        o.withdraw()
        o.pixi_sock = (host, port)
        o.pixi_prefix = message_prefix
        o.tick()

    def mess(o):
        abb = filter(lambda x: 'tkabber' in x, o.winfo_interps())
        if len(abb) == 0:
            return None
        if len(abb) > 1:
            return 'Hmm...'
        abb ,= abb
#        s = o.send(abb, r'array get ifacetk::number_msg')
        s = o.send(abb, r'array get ifacetk::personal_msg')
#        print "%s: %s" % (abb, s)
        a = parse(s)
        a = filter(lambda x: int(x[1]) > 0, zip(a[0::2], a[1::2]))
        if len(a) == 0:
            return None
        return '\n'.join(map(lambda x: x[0][1] + ' / ' + x[1], a))

    def net_send(o, data):
        if os.getenv('PIXICLOCK', None) is None:
            # we run in network mode
            s = socket.socket()
            try:
                s.connect(o.pixi_sock)
            except:
                return
            while data:
                n = s.send(data)
                data = data[n:]
            s.close()
        else:
            # we run in piped mode
            os.write(1, data)

    def tick(o):
        m = o.mess()
        if m:
            o.net_send(o.pixi_prefix + m)
        o.after(2000, o.tick)


app(host, port, message_prefix).mainloop()
