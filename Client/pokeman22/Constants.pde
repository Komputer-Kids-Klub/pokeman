
Rect SLIDER;

int sliderStartY;

Rect INFO_BUTTON;
Rect POKEBALL;

Rect START_BUTTON;
Rect POKEMON_BUTTON;

Rect SEARCH_BUTTON;

int POKEMON_PER_PAGE = 20;

String POKEINFO_PATH = "./pokeinfo/";

int NOT_READY = 0;
int SEARCHING = 1;
int BATTLING = 2;

HashMap<String, Integer> TYPE_COLOURS = new HashMap<String, Integer>();

HashMap<Character, Integer> KEY_TO_ID = new HashMap<Character, Integer>();

void init_constants() {

  SLIDER = new Rect((width/7)*6-width/140, height/9, width/140, height/45);
  sliderStartY = height/9;

  START_BUTTON = new Rect(width/2, (height/9)*5, (width/7)*2, height/9);
  POKEMON_BUTTON = new Rect(width/7, (height/6)*5, width/7, (height/9)*2);

  INFO_BUTTON = new Rect(POKEMON_BUTTON.i_x - POKEMON_BUTTON.i_w/2 + (width/700)*9, POKEMON_BUTTON.i_y + POKEMON_BUTTON.i_h/2 - height/50);
  POKEBALL = new Rect(POKEMON_BUTTON.i_x + POKEMON_BUTTON.i_w/2 - (width/700)*9, POKEMON_BUTTON.i_y + POKEMON_BUTTON.i_h/2 - height/50);

  SEARCH_BUTTON = new Rect(width/7 + 10, 10, 200, 30);
  
  KEY_TO_ID.put('q', 0);
  KEY_TO_ID.put('w', 1);
  KEY_TO_ID.put('e', 2);
  KEY_TO_ID.put('r', 3);

  // hard code all the type colours
  TYPE_COLOURS.put("normal", color(#A8A878));
  TYPE_COLOURS.put("fighting", color(#C03028));
  TYPE_COLOURS.put("flying", color(#A890F0));
  TYPE_COLOURS.put("poison", color(#A040A0));
  TYPE_COLOURS.put("ground", color(#E0C068));
  TYPE_COLOURS.put("rock", color(#B8A038));
  TYPE_COLOURS.put("bug", color(#A8B820));
  TYPE_COLOURS.put("ghost", color(#705898));
  TYPE_COLOURS.put("steel", color(#B8B8D0));
  TYPE_COLOURS.put("fire", color(#F08030));
  TYPE_COLOURS.put("water", color(#6890F0));
  TYPE_COLOURS.put("grass", color(#78C850));
  TYPE_COLOURS.put("electric", color(#F8D030));
  TYPE_COLOURS.put("psychic", color(#F85888));
  TYPE_COLOURS.put("ice", color(#98D8D8));
  TYPE_COLOURS.put("dragon", color(#7038F8));
  TYPE_COLOURS.put("dark", color(#705848));
  TYPE_COLOURS.put("fairy", color(#EE99AC));
  TYPE_COLOURS.put("error", color(#555555));
  TYPE_COLOURS.put("???", color(#555555));
}

class Rect {
  int i_x;
  int i_y;
  int i_w;
  int i_h;
  Rect(int x, int y, int w, int h) {
    i_x = x;
    i_y = y;
    i_w = w;
    i_h = h;
  }
  Rect(int x, int y) {
    i_x = x;
    i_y = y;
  }
}