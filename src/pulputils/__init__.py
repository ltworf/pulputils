import gettext
gettext.bindtextdomain('pulputils')
gettext.textdomain('pulputils')
_ = gettext.gettext

VERSION = '1.0'

VERBOSE_VERSION = '%(prog)s (pulputils) ' + VERSION + '''
Copyright (C) 2016 Salvo Tomaselli
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Salvo Tomaselli.
'''
