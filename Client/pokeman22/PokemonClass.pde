
JSONObject[] other_pokemon_jsons = new JSONObject[6];
ArrayList<Pokemon> other_pokemons;

class Pokemon {
  String name, type1, type2, species, h, weight, ability, gender, item;
  int number, HP, ATK, DEF, SPA, SPD, SPE, happiness, level, evasion;
  int cur_hp;
  Boolean shiny;
  String[][] possible_moves;
  PImage[] animation;
  String[] moves;
  PImage[] animationBack;
  Pokemon (int num, Boolean s, int lvl, String abil, int[] statList, String[] moveList) {

    moves = new String[4];
    
    number = num;
    shiny = s;
    level = lvl;
    ability = abil;
    HP = statList[0];
    ATK = statList[1];
    DEF = statList[2];
    SPA = statList[3];
    SPD = statList[4];
    SPE = statList[5];
    moves[0] = moveList[0];
    moves[1] = moveList[1];
    moves[2] = moveList[2];
    moves[3] = moveList[3];

    init_with_json(loadJSONObject(POKEINFO_PATH+"pokemon/"+num+".txt"));
  }

  Pokemon (JSONObject json) {
    
    moves = new String[4];

    shiny = json.getBoolean("shiny");
    number = json.getInt("num");

    init_with_json(loadJSONObject(POKEINFO_PATH+"pokemon/"+json.getInt("num")+".txt"));
  }

  void update_with_json(JSONObject json) {
    
    name = json.getString("name");

    HP = json.getInt("basehp");
    ATK = json.getInt("baseatk");
    DEF = json.getInt("basedef");
    SPA = json.getInt("basespa");
    SPD = json.getInt("basespd");
    SPE = json.getInt("basespe");

    happiness = json.getInt("hap");
    level = json.getInt("lv");
    gender = json.getString("gender");

    type1 = json.getString("type1");
    type2 = json.getString("type2");

    ability = json.getString("ability");
    item = json.getString("item");
    
    JSONArray json_moves_array = json.getJSONArray("moves");
    for (int j = 0; j < json_moves_array.size(); j++) {
      println(json_moves_array.getJSONObject(j).getString("name"));
      moves[j] = json_moves_array.getJSONObject(j).getString("name");
    }

    evasion = json.getInt("eva");

    HP = max(HP, 1);
    cur_hp = json.getInt("hp");
    //println(cur_hp);
  }

  void init_with_json(JSONObject json) {
    //happiness = hap;
    //level = lvl;

    // All Strings
    name = json.getString("name");
    type1 = json.getString("type1");
    type2 = json.getString("type2");
    species = json.getString("species");
    h = json.getString("height");
    weight = json.getString("weight");
    //ability = ab;

    // All Integers
    HP = int(json.getString("HP"));
    ATK = int(json.getString("ATK"));
    DEF = int(json.getString("DEF"));
    SPA = int(json.getString("SPA"));
    SPD = int(json.getString("SPD"));
    SPE = int(json.getString("SPE"));

    HP = max(HP, 1);
    cur_hp = HP;

    // All String Arrays
    possible_moves = names_moves.get(name);

    // All PImage Arrays
    PImage[][] animations = loadPokemon(json, shiny);
    if (shiny) {
      animation = animations[0];
      animationBack = animations[1];
    } else {
      animation = animations[0];
      animationBack = animations[1];
    }

    // All Given
    /*
    move1 = m1;
     move2 = m2;
     move3 = m3;
     move4 = m4;
     ability = ab;
     */
  }
}