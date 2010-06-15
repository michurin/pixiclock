from distutils.core import setup

try:
    import Tkinter
except Exception, e:
    print 'Setup aborted: ' + str(e)
    exit(1)

setup(name       = 'pixiclock',
      version    = '0.5.7',
      author     = 'Alexey Michurin',
      author_email = 'a.michurin@gmail.com',
      maintainer = 'Alexey Michurin',
      maintainer_email = 'a.michurin@gmail.com',
      license    = 'BSD',
      platforms  = ('ALL',),
      url        = 'http://pixiclock.googlecode.com/',
      description = 'PixiClock is tiny desktop clock widget for true geeks.',
      long_description =
                    'PixiClock is tiny desktop clock widget for true geeks.'
                    ' It use original pixi-icons instead digits and show'
                    ' ordinary digits only as hint, when mouse comes over.',
      download_url = 'http://pixiclock.googlecode.com/',
      scripts    = ('pixiclock', 'pixiclock-client'),
     )
