## -------------------------------------- ##
## Constants
## litterally a bunch of constants
## -------------------------------------- ##

from Log import *
import os
import json

dir_path = str(os.path.dirname(os.path.realpath(__file__)))
print(dir_path)

# weather constants
class Weather(object):
    CLEAR_SKIES = 0
    HARSH_SUNLIGHT = 1
    RAIN = 2
    SANDSTORM = 3
    HAIL = 4
    MYSTERIOUS_AIR_CURRENT = 5
    EXTREMELY_HARSH_SUNLIGHT = 6
    HEAVY_RAIN = 7

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
PORT = 4044

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
DISPLAY_MOVE = 'M'
DISPLAY_DELAY = 'D'
DISPLAY_FIELD = 'F'
DISPLAY_AD_HOC_TEXT = 'A'

DISPLAY_WIN = 'W'
DISPLAY_LOSE = 'L'

ME = 0
OTHER = 1

NOT_READY = 0
SEARCHING = 1
BATTLING = 2
READY = 3

def join_with_none(l):
    if len(l) == 0:
        return "none"
    return " ".join(l)

dic_name_to_num = {}
for i in range(1,808):
    dic_poke = json.load(open(dir_path + '/pokeinfo/pokemon/' + str(i) + '.txt'))
    dic_name_to_num[dic_poke["name"]] = i
