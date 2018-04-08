
class Pokemon {
  String name, type1, type2, species, h, weight, ability, move1, move2, move3, move4;
  int number, HP, ATK, DEF, SPA, SPD, SPE, happiness, level;
  Boolean shiny;
  String[][] moves;
  PImage[] animation;
  PImage[] animationBack;
  Pokemon (int num, Boolean s/*, int hap, int lvl, String m1, String m2, String m3, String m4, String ab*/) {
    pokemonLocation = loadJSONObject(POKEINFO_PATH+"pokemon/"+num+".txt");
    //pokemonLocation = loadJSONObject("https://raw.githubusercontent.com/Komputer-Kids-Klub/pokeman/master/pokeinfo/pokemon/"+num+".txt");

    //happiness = hap;
    //level = lvl;
    shiny = s;

    // All Strings
    name = pokemonLocation.getString("name");
    type1 = pokemonLocation.getString("type1");
    type2 = pokemonLocation.getString("type2");
    species = pokemonLocation.getString("species");
    h = pokemonLocation.getString("height");
    weight = pokemonLocation.getString("weight");
    //ability = ab;

    // All Integers
    number = num;
    HP = int(pokemonLocation.getString("HP"));
    ATK = int(pokemonLocation.getString("ATK"));
    DEF = int(pokemonLocation.getString("DEF"));
    SPA = int(pokemonLocation.getString("SPA"));
    SPD = int(pokemonLocation.getString("SPD"));
    SPE = int(pokemonLocation.getString("SPE"));

    // All String Arrays
    moves = names_moves.get(name);

    // All PImage Arrays
    PImage[][] animations = loadPokemon(num, pokemonLocation, s);
    if (s) {
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