# pulputils
# Copyright (C) 2016-2017  Salvo "LtWorf" Tomaselli
#
# pulputils is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# author Salvo "LtWorf" Tomaselli <tiposchi@tiscali.it>

import gettext
gettext.bindtextdomain('pulputils')
gettext.textdomain('pulputils')
_ = gettext.gettext

VERSION = '1.0'

VERBOSE_VERSION = '%(prog)s (pulputils) ' + VERSION + _('''
Copyright (C) 2016-2017 Salvo Tomaselli
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Salvo Tomaselli.
''')

def human_size(size: int) -> str:
    '''
    Converts a size in bytes to a human readable string
    '''
    #4,0K
    unit = 'B'
    if size >= 1024:
        size /= 1024
        unit = 'K'
    if size >= 1024:
        size /= 1024
        unit = 'M'
    if size >= 1024:
        size /= 1024
        unit = 'G'
    return '%0.1f%s' % (size, unit)
