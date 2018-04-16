## -------------------------------------- ##
## Constants
## litterally a bunch of constants
## -------------------------------------- ##

from Log import *

# weather constants
class Weather(object):
    CLEAR_SKIES = 0
    HARSH_SUNLIGHT = 1
    EXTREMELY_HARSH_SUNLIGHT = 2
    RAIN = 3
    HEAVY_RAIN = 4
    SANDSTORM = 5
    HAIL = 6
    MYSTERIOUS_AIR_CURRENT = 7

# terrain constants
class Terrain(object):
    NO = 0
    ELECTRIC = 1
    GRASSY = 2
    MISTY = 3
    PSYCHIC = 4

# entry hazard constants
class EntryHazard(object):
    SPIKES = 0
    STEALTH_ROCK = 1
    STICKY_WEB = 2
    TOXIC_SPIKES = 3

HOST = ''
RECV_BUFFER = 4096
PORT = 17171

TERMINATING_CHAR = '`'
FOUND_BATTLE = 'f'
NEXT_TURN = 't'

SELECT_POKE = 'p'
SELECT_MOVE = 'm'
SELECT_POKE_OR_MOVE = 'o'
AWAITING_SELECTION = 'w'

SENDING_POKE = 's'
CHANGING_POKE = 'c'

DISPLAY_TEXT = 'd'
DISPLAY_TEAMS = 'T'
DISPLAY_POKES = 'P'
DISPLAY_NONE = 'N'

ME = 0
OTHER = 1

NOT_READY = 0
SEARCHING = 1
BATTLING = 2
