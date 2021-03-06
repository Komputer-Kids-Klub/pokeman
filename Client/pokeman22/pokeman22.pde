/* ron is bad
 * Demonstrates the use of the GifAnimation library.
 * the left animation is looping, the one in the middle 
 * plays once on mouse click and the one in the right
 * is a PImage array. 
 * the first two pause if you hit the spacebar.
 */

import gifAnimation.*;
import java.net.URL;
import java.net.HttpURLConnection;
import java.nio.channels.ReadableByteChannel;
import java.nio.channels.Channels;
import java.io.FileOutputStream;
import java.util.Map;
import java.util.HashSet;
import java.util.Set;

// Note the HashMap's "key" is a String and "value" is an Integer

String[] male = {"braviary", "gallade", "hitmonchan", "hitmonlee", "hitmontop", "landorus", "latios", "mothim", "nidoking", "nidoran-m", "nidorino", "rufflet", "sawk", "tauros", "throh", "thundurus", "tornadus", "tyrogue", "volbeat"};
String[] female = {"blissey", "bounsweet", "chansey", "cresselia", "flabebe", "floette", "florges", "froslass", "happiny", "illumise", "jynx", "kangaskhan", "latias", "lilligant", "mandibuzz", "miltank", "nidoqueen", "nidoran-f", "nidorina", "petilil", "salazzle", "smoochum", "steenee", "tsareena", "vespiquen", "vullaby", "wormadam"};
String[] unspecified = {"arceus", "articuno", "azelf", "baltoy", "beldum", "blacephalon", "bronzong", "bronzor", "buzzwole", "carbink", "celebi", "celesteela", "claydol", "cobalion", "cosmoem", "cosmog", "cryogonal", "darkrai", "deoxys", "dhelmise", "dialga", "diancie", "ditto", "electrode", "entei", "genesect", "giratina", "golett", "golurk", "groudon", "guzzlord", "ho-oh", "hoopa", "jirachi", "kartana", "keldeo", "klang", "klink", "klinklang", "kyogre", "kyurem", "lugia", "lunala", "lunatone", "magearna", "magnemite", "magneton", "magnezone", "manaphy", "marshadow", "meloetta", "mesprit", "metagross", "metang", "mew", "mewtwo", "minior", "moltres", "naganadel", "necrozma", "nihilego", "palkia", "pheromosa", "phione", "poipole", "porygon", "porygon-z", "porygon2", "raikou", "rayquaza", "regice", "regigigas", "regirock", "registeel", "reshiram", "rotom", "shaymin", "shedinja", "silvally", "solgaleo", "solrock", "stakataka", "starmie", "staryu", "suicune", "tapu-bulu", "tapu-fini", "tapu-koko", "tapu-lele", "terrakion", "type-null", "unown", "uxie", "victini", "virizion", "volcanion", "voltorb", "xerneas", "xurkitree", "yveltal", "zapdos", "zekrom", "zeraora", "zygarde"};

boolean maleBool = false;
boolean femaleBool = false;
boolean unspecifiedBool = false;

HashMap<Integer, String> num_male = new HashMap<Integer, String>();
HashMap<Integer, String> num_female = new HashMap<Integer, String>();
HashMap<Integer, String> num_unspecified = new HashMap<Integer, String>();

HashMap<String, Integer> names_num = new HashMap<String, Integer>();
HashMap<Integer, String> num_names = new HashMap<Integer, String>();
HashMap<String, Integer[]> names_stats = new HashMap<String, Integer[]>();

HashMap<String, String[]> names_types = new HashMap<String, String[]>();
HashMap<String, String> names_species = new HashMap<String, String>();
HashMap<String, String[]> names_height_weight = new HashMap<String, String[]>();
HashMap<String, String[]> names_abilities = new HashMap<String, String[]>();

HashMap<String, String[][]> names_moves = new HashMap<String, String[][]>();

HashMap<String, PImage> type_image = new HashMap<String, PImage>();
String[] types = {"bug", "dark", "dragon", "electric", "error", "fairy", "fighting", "fire", "flying", 
  "ghost", "grass", "ground", "ice", "normal", "poison", "psychic", "rock", "steel", "water"};
PImage tempImage;

HashMap<String, String[]> moves_data = new HashMap<String, String[]>();

JSONObject[] pokemon = new JSONObject[6];
PImage[][] pokemonAnimation = {{}, {}, {}, {}, {}, {}};

HashMap<String, PImage[]> move_animations = new HashMap<String, PImage[]>();
HashMap<String, Integer> move_animations_num = new HashMap<String, Integer>();

ArrayList<Pokemon> pokemons;

Gif loopingGif;
Gif nonLoopingGif;
boolean pause = false;
boolean drawSettingScreen=false;
boolean sound=true;
boolean soundFX=true;
boolean game=true;
int[] buttonLst={100, 100, 100, 0, 0, 0};
int idx = 1;

JSONObject curr_json;
JSONObject pokemonLocation;

Boolean mousePressValid = true;
Boolean keyPressValid = true;

PImage[] pokemonImages = new PImage[807];

int offset = 0;
int offsetMoves = 0;
int offsetNature = 0;
int offsetFriend = 0;

boolean transitionStart = false; 

boolean sliderFollow = false;
boolean moveSliderFollow = false;
boolean natureSliderFollow = false;
boolean friendSliderFollow = false;

int pokemonChangeNumber;
boolean pokemonSelectScreen = false;

float mouseWheelChange = 0;

String pokemonSearch = "";
String moveSearch = "";
String friendSearch = "";
String alphabet_lower = "abcdefghijklmnopqrstuvwxyz";
String alphabet_upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String punctuation = " -:";

boolean pokemonSearchBool = false;
boolean moveSearchBool = false;
boolean friendSearchBool = false;

StringList validPokemonSearch;
StringList validFriendSearch;
StringList allPokeMoves;
StringList validMoveSearch;

PImage infoButton;
PImage pokeBall;
PImage settingsButton;
PImage backgroundImg;
PImage startButton;
PImage pokedex;
PImage back;
PImage confirm;
PImage loginBack;
PImage loginbutton;
PImage registerbutton;
PImage registerconfirm;
PImage loadbutton;
PImage savebutton;
PImage shield;

int i_battle_state = 0;

PImage[][] tempAnimations;
boolean tempAnimationLoad = true;
boolean moveSelect = false;
boolean statSelect = true;
boolean moveScreenReset = true;
boolean moveScreenReload = false;
boolean moveSelectScreen = false;

int moveSlot;
int textRestrain;
int moveScreenNamePos = 0;

String[] selectedMoves;

int[] IV = {31, 31, 31, 31, 31, 31};
int[] EV = {0, 0, 0, 0, 0, 0};
int[] stats = {0, 0, 0, 0, 0, 0};
int[] nature = {0, 0, 0, 0, 0};
int maxEV = 508;
int EVRemaining;
int lastSliderTouched = 0;

int level;
String natureString = "";

boolean[] statSliderFollow = {false, false, false, false, false, false};

String[] natureName = {"Hardy", "Lonely", "Brave", "Adamant", "Naughty", "Bold", "Docile", "Relaxed", "Impish", "Lax", "Timid", "Hasty", "Serious", "Jolly", "Naive", "Modest", "Mild", "Quiet", "Bashful", "Rash", "Calm", "Gentle", "Sassy", "Careful", "Quirky"};
String[][] natureStat = {{}, {"Atk", "Def"}, {"Atk", "Spe"}, {"Atk", "SpA"}, {"Atk", "SpD"}, {"Def", "Atk"}, {}, {"Def", "Spe"}, {"Def", "SpA"}, {"Def", "SpD"}, {"Spe", "Atk"}, {"Spe", "Def"}, {}, {"Spe", "SpA"}, {"Spe", "SpD"}, {"SpA", "Atk"}, {"SpA", "Def"}, {"SpA", "Spe"}, 
  {}, {"SpA", "SpD"}, {"SpD", "Atk"}, {"SpD", "Def"}, {"SpD", "Spe"}, {"SpD", "SpA"}, {}};
String[] natureAbility = {"Atk", "Def", "SpA", "SpD", "Spe"};

String selectedAbility = "";
boolean chooseAbility = false;
String selectedGender = "";
boolean chooseGender = false;

String[] genders = {"Male", "Female", "Unspecified"};
String[] pictureType = {"Normal-Front", "Normal-Back", "Shiny-Front", "Shiny-Back"};
int abilityCount = 0;

boolean shinyBool = false;

int pokemonSlotNumber;
int pokemonNumber;

int selectedNature = 0;

String tempFileName;

String[] friendList = {};

//int[] settingsButton = {width - 60, 60, 100, 100};

PImage[][] loadPokemon(JSONObject file, boolean shiny) {
  PImage[][] animations = new PImage[2][];

  if (shiny) {
    tempFileName = file.getString("gifs");
    tempFileName = tempFileName.replace("xyani-shiny", "helloworld");
    if (tempFileName.indexOf("-") > 0) {
      if (tempFileName.substring(tempFileName.indexOf("-") + 1, tempFileName.indexOf("-") + 2) != "f."
        && tempFileName.substring(tempFileName.indexOf("-") + 1, tempFileName.indexOf("-") + 2) != "m.") {
        tempFileName = tempFileName.replace("-", "");
      }
    }
    tempFileName = tempFileName.replace("helloworld", "xyani-shiny");
    animations[0] = Gif.getPImages(this, tempFileName);

    tempFileName = file.getString("gifbs");
    tempFileName = tempFileName.replace("xyani-back-shiny", "helloworld");
    if (tempFileName.indexOf("-") > 0) {
      if (tempFileName.substring(tempFileName.indexOf("-") + 1, tempFileName.indexOf("-") + 2) != "f."
        && tempFileName.substring(tempFileName.indexOf("-") + 1, tempFileName.indexOf("-") + 2) != "m.") {
        tempFileName = tempFileName.replace("-", "");
      }
    }
    tempFileName = tempFileName.replace("helloworld", "xyani-back-shiny");
    animations[1] = Gif.getPImages(this, tempFileName);
  } else {
    tempFileName = file.getString("gif");
    tempFileName = tempFileName.replace("xyani", "helloworld");
    if (tempFileName.indexOf("-") > 0) {
      if (tempFileName.substring(tempFileName.indexOf("-") + 1, tempFileName.indexOf("-") + 2) != "f."
        && tempFileName.substring(tempFileName.indexOf("-") + 1, tempFileName.indexOf("-") + 2) != "m.") {
        tempFileName = tempFileName.replace("-", "");
      }
    }
    tempFileName = tempFileName.replace("helloworld", "xyani");
    animations[0] = Gif.getPImages(this, tempFileName);

    tempFileName = file.getString("gifb");
    tempFileName = tempFileName.replace("xyani-back", "helloworld");
    if (tempFileName.indexOf("-") > 0) {
      if (tempFileName.substring(tempFileName.indexOf("-") + 1, tempFileName.indexOf("-") + 2) != "f."
        && tempFileName.substring(tempFileName.indexOf("-") + 1, tempFileName.indexOf("-") + 2) != "m.") {
        tempFileName = tempFileName.replace("-", "");
      }
    }
    tempFileName = tempFileName.replace("helloworld", "xyani-back");
    animations[1] = Gif.getPImages(this, tempFileName);
  }

  return animations;
}

PImage[][] loadPokemonAll(JSONObject file) {
  PImage[][] animations = new PImage[4][];

  tempFileName = file.getString("gif");
  tempFileName = tempFileName.replace("xyani", "helloworld");
  if (tempFileName.indexOf("-") > 0) {
    if (tempFileName.substring(tempFileName.indexOf("-") + 1, tempFileName.indexOf("-") + 2) != "f."
      && tempFileName.substring(tempFileName.indexOf("-") + 1, tempFileName.indexOf("-") + 2) != "m.") {
      tempFileName = tempFileName.replace("-", "");
    }
  }
  tempFileName = tempFileName.replace("helloworld", "xyani");
  animations[0] = Gif.getPImages(this, tempFileName);

  tempFileName = file.getString("gifb");
  tempFileName = tempFileName.replace("xyani-back", "helloworld");
  if (tempFileName.indexOf("-") > 0) {
    if (tempFileName.substring(tempFileName.indexOf("-") + 1, tempFileName.indexOf("-") + 2) != "f."
      && tempFileName.substring(tempFileName.indexOf("-") + 1, tempFileName.indexOf("-") + 2) != "m.") {
      tempFileName = tempFileName.replace("-", "");
    }
  }
  tempFileName = tempFileName.replace("helloworld", "xyani-back");
  animations[1] = Gif.getPImages(this, tempFileName);

  tempFileName = file.getString("gifs");
  tempFileName = tempFileName.replace("xyani-shiny", "helloworld");
  if (tempFileName.indexOf("-") > 0) {
    if (tempFileName.substring(tempFileName.indexOf("-") + 1, tempFileName.indexOf("-") + 2) != "f."
      && tempFileName.substring(tempFileName.indexOf("-") + 1, tempFileName.indexOf("-") + 2) != "m.") {
      tempFileName = tempFileName.replace("-", "");
    }
  }
  tempFileName = tempFileName.replace("helloworld", "xyani-shiny");
  animations[2] = Gif.getPImages(this, tempFileName);

  tempFileName = file.getString("gifbs");
  tempFileName = tempFileName.replace("xyani-back-shiny", "helloworld");
  if (tempFileName.indexOf("-") > 0) {
    if (tempFileName.substring(tempFileName.indexOf("-") + 1, tempFileName.indexOf("-") + 2) != "f."
      && tempFileName.substring(tempFileName.indexOf("-") + 1, tempFileName.indexOf("-") + 2) != "m.") {
      tempFileName = tempFileName.replace("-", "");
    }
  }
  tempFileName = tempFileName.replace("helloworld", "xyani-back-shiny");
  animations[3] = Gif.getPImages(this, tempFileName);

  return animations;
}

String[] getMoveData(String move_name) {
  JSONObject move_json = loadJSONObject(POKEINFO_PATH+"move/"+move_name+".txt");
  String[] data = {move_json.getString("type"), move_json.getString("cat"), move_json.getString("power"), move_json.getString("acc"), move_json.getString("pp"), move_json.getString("prob"), move_json.getString("effect")};
  return data;
}
String username="", password="", current="", player_name="";
Boolean login=true;
Boolean register=false;
void drawMove(String move_name) {

  JSONObject move_json = loadJSONObject(POKEINFO_PATH+"move/"+move_name+".txt");
  //JSONObject move_json = loadJSONObject("https://raw.githubusercontent.com/Komputer-Kids-Klub/pokeman/master/pokeinfo/move/"+move_name+".txt");

  //println(move_json.getString("type"));
  fill(TYPE_COLOURS.get(move_json.getString("type")));
  draw_rect(300, 700, 600, 100);

  fill(255); 
  draw_text(move_json.getString("name"), 400, 720);

  //fill(TYPE_COLOURS.get(move_json.getString("type")));
  //draw_rect(300-2, 735 - 11, textWidth(move_json.getString("type"))+4, 14);
  fill(255);
  draw_text(move_json.getString("type"), 400, 735);

  draw_text(move_json.getString("cat"), 400, 750);
  draw_text(move_json.getString("prob"), 400, 765);

  draw_text(move_json.getString("power"), 700, 735);
  draw_text(move_json.getString("acc"), 700, 750);
  draw_text(move_json.getString("pp"), 700, 765);

  draw_text(move_json.getString("effect"), 400, 785);

  textAlign(RIGHT);

  draw_text("Type", 390, 735);

  draw_text("Category", 390, 750);
  draw_text("Probability", 390, 765);

  draw_text("Power", 690, 735);
  draw_text("Accuracy", 690, 750);
  draw_text("PP", 690, 765);

  textAlign(LEFT);
}

void drawStartScreen() {
  //backgroundImg.resize(width, height);

  draw_image(backgroundImg, 0, 0);

  draw_rectMode(CENTER);
  draw_imageMode(CENTER);
  textAlign(CENTER);
  //draw_rect(START_BUTTON.i_x, START_BUTTON.i_y, START_BUTTON.i_w, START_BUTTON.i_h);
  stroke(255);
  for (int i = 0; i < 6; i++) {

    //fill(0, 0, 100, 100);
    fill(0, 0, 0, 100);
    draw_rect(POKEMON_BUTTON.i_x + i*POKEMON_BUTTON.i_w, POKEMON_BUTTON.i_y, POKEMON_BUTTON.i_w, POKEMON_BUTTON.i_h);
    drawPokemon(pokemons.get(i).animation, POKEMON_BUTTON.i_x + i*POKEMON_BUTTON.i_w, POKEMON_BUTTON.i_y);
    fill(255);
    draw_text(pokemons.get(i).name, POKEMON_BUTTON.i_x + i*POKEMON_BUTTON.i_w, POKEMON_BUTTON.i_y + POKEMON_BUTTON.i_h/2 - height/90);
    //fill(255);
    draw_image(infoButton, INFO_BUTTON.i_x + i*POKEMON_BUTTON.i_w, INFO_BUTTON.i_y);
    draw_image(pokeBall, POKEBALL.i_x + i*POKEMON_BUTTON.i_w, POKEBALL.i_y);
  }
  stroke(0);
  draw_image(settingsButton, (width/140)*137, height/30);
  //draw_rect(settingsButton[0], settingsButton[1], settingsButton[2], settingsButton[3]);
  draw_imageMode(CORNER);
  textAlign(CORNER);
  draw_rectMode(CORNER);

  textAlign(CENTER);
  fill(0);
  if (i_battle_state==NOT_READY)
    draw_text("Find Match", START_BUTTON.i_x, START_BUTTON.i_y);
  else if (i_battle_state==SEARCHING)
    draw_text("Searching for Match", START_BUTTON.i_x, START_BUTTON.i_y);
  //draw_text("Find Match", startButton[0], startButton[1]);
  //draw_text("Settings", settingsButton[0], settingsButton[1]);
  fill(255);
  textAlign(CORNER);

  draw_image(savebutton, SAVE_BUTTON.i_x, SAVE_BUTTON.i_y);
  draw_image(loadbutton, PRESET_BUTTON.i_x, PRESET_BUTTON.i_y);
  //draw_rect(SAVE_BUTTON.i_x, SAVE_BUTTON.i_y, SAVE_BUTTON.i_w, SAVE_BUTTON.i_h);
  //draw_rect(PRESET_BUTTON.i_x, PRESET_BUTTON.i_y, PRESET_BUTTON.i_w, PRESET_BUTTON.i_h);

  if (mousePressed && mousePressValid == true && pokemonSelectScreen == false && i_battle_state==NOT_READY && moveSelectScreen == false && drawSettingScreen==false && friendSliderFollow == false) {
    if (mouseX >= SAVE_BUTTON.i_x && mouseX <= SAVE_BUTTON.i_x + SAVE_BUTTON.i_w && mouseY >= SAVE_BUTTON.i_y && mouseY <= SAVE_BUTTON.i_y + SAVE_BUTTON.i_h) {
      //println("SAVING");
      send_saving();
      mousePressValid = false;
    }
    if (mouseX >= PRESET_BUTTON.i_x && mouseX <= PRESET_BUTTON.i_x + PRESET_BUTTON.i_w && mouseY >= PRESET_BUTTON.i_y && mouseY <= PRESET_BUTTON.i_y + PRESET_BUTTON.i_h) {
      //println("LOADING PRESET");
      JSONObject json = new JSONObject();
      json.setString("username", player_name);
      json.setString("battlestate", "pokeread");
      myClient.write(json.toString());
      mousePressValid = false;
    }
    for (int i = 0; i < 6; i++) {
      if (dist(mouseX, mouseY, POKEBALL.i_x + i*POKEMON_BUTTON.i_w, POKEBALL.i_y) <= height/60) {
        pokemonChangeNumber = i;
        pokemonSelectScreen = true;
        pokemonSearchBool = true;
        mousePressValid = false;
      }
      if (dist(mouseX, mouseY, (width/140)*137, height/30)<=dist((width/140)*137-width/56, height/30-height/36, (width/140)*137, height/30)) {
        drawSettingScreen=true;
      }
      if (dist(mouseX, mouseY, INFO_BUTTON.i_x + i*POKEMON_BUTTON.i_w, INFO_BUTTON.i_y) <= height/60) {
        pokemonSlotNumber = i;
        pokemonNumber = pokemons.get(i).number;
        moveSelectScreen = true;
        //moveScreenReset = true;
        moveScreenReload = true;
        tempAnimationLoad = true;
        mousePressValid = false;
      }
    }
  }
  draw_image(startButton, START_BUTTON.i_x - START_BUTTON.i_w/2, START_BUTTON.i_y - START_BUTTON.i_h/2);
  // draw_line(width/2, 0, width/2, height);
  //line(0, height/2, width, height/2);
}

void drawPokemonSelectionScreen(int slotNumber) {
  strokeWeight(0);

  draw_image(backgroundImg, 0, 0);
  int BST = 0;
  float textHight = height/10 + SELECTSCREENSHIFT_Y;

  draw_rectMode(CORNER);
  fill(0, 0, 0, 150);
  draw_rect(0, 0, width, height);
  //draw_rect(width/7, height/18, width*5/7, height/18);

  fill(255);
  draw_text("#", width*43/280 + SELECTSCREENSHIFT_X, textHight);
  draw_text("Name", width*3/14, textHight);
  draw_text("Types", width*19/56 - SELECTSCREENSHIFT_X, textHight);
  draw_text("Abilities", width*9/20 + (width/14) - SELECTSCREENSHIFT_X*1.5, textHight);
  draw_text("HP", width*13/20 - SELECTSCREENSHIFT_X, textHight);
  draw_text("ATK", width*19/28 - SELECTSCREENSHIFT_X, textHight);
  draw_text("DEF", width*99/140 - SELECTSCREENSHIFT_X, textHight);
  draw_text("SPA", width*103/140 - SELECTSCREENSHIFT_X, textHight);
  draw_text("SPD", width*107/140 - SELECTSCREENSHIFT_X, textHight);
  draw_text("SPE", width*111/140 - SELECTSCREENSHIFT_X, textHight);
  draw_text("BST", width*115/140 - SELECTSCREENSHIFT_X, textHight);


  textHight = height/9 + SELECTSCREENSHIFT_Y- gridSize/2;

  textAlign(LEFT, CENTER);

  if (pokemonSearch == "" && validPokemonSearch.size()!=807) {
    for (int i = 1; i <= 807; i++) {
      validPokemonSearch.append(num_names.get(i));
    }
  }

  offset = int((SLIDER.i_y - sliderStartY)*(807.0-POKEMON_PER_PAGE)/((height - height/9 - SELECTSCREENSHIFT_Y*2)-SLIDER.i_h));
  //draw_rect(width/7 + SELECTSCREENSHIFT_X, height/9 + SELECTSCREENSHIFT_Y, width*5/7 - SELECTSCREENSHIFT_X*2, (height*38)/45 - SELECTSCREENSHIFT_Y);
  fill(255);
  stroke(255);
  strokeWeight(1);
  draw_line(width/7 + SELECTSCREENSHIFT_X, height/9 + SELECTSCREENSHIFT_Y, width/7 + SELECTSCREENSHIFT_X + width*5/7 - SELECTSCREENSHIFT_X*2, height/9 + SELECTSCREENSHIFT_Y);
  strokeWeight(0);
  for (int i = 0; i < POKEMON_PER_PAGE && i + 1 + offset <= num_names.size(); i++) {
    //line(width/7 + SELECTSCREENSHIFT_X, i*gridSize+textHight+gridSize/2, (width/7)*6 - SELECTSCREENSHIFT_X, i*gridSize+textHight+gridSize/2);
    //draw_rect(width/7 + SELECTSCREENSHIFT_X, height/9 + SELECTSCREENSHIFT_Y + i*gridSize, width*5/7 - SELECTSCREENSHIFT_X*2, gridSize);
    fill(255);
    if (i < validPokemonSearch.size()) {
      if (validPokemonSearch.size() > POKEMON_PER_PAGE) {
        offset = int(((SLIDER.i_y - sliderStartY)*(validPokemonSearch.size() - POKEMON_PER_PAGE)/((height*8/9 - SELECTSCREENSHIFT_Y*2) - SLIDER.i_h)));
      } else {
        offset = 0;
      }
      //println(validPokemonSearch.size(), validPokemonSearch.size()-POKEMON_PER_PAGE, offset, (height/9)*8 - SLIDER.i_h, SLIDER.i_y - sliderStartY);
      draw_text(names_num.get(validPokemonSearch.get(i + offset)), width*43/280 + SELECTSCREENSHIFT_X, textHight + (i+1)*gridSize);
      draw_text(validPokemonSearch.get(i + offset), width*3/14, textHight + (i+1)*gridSize);
      for (int j = 0; j < 2; j++) {
        if (names_types.get(validPokemonSearch.get(i + offset))[j] != null) {
          draw_text(names_types.get(validPokemonSearch.get(i + offset))[j], width*11/35 + j*(width/20) - SELECTSCREENSHIFT_X, textHight + (i+1)*gridSize);
        }
      }
      for (int j = 0; j < 3; j++) {
        if (names_abilities.get(validPokemonSearch.get(i + offset))[j] != null) {
          draw_text(names_abilities.get(validPokemonSearch.get(i + offset))[j].replaceAll("-", " "), width*9/20 + j*(width/14) - SELECTSCREENSHIFT_X*1.5, textHight + (i+1)*gridSize);
        }
      }
      BST = 0;
      for (int j = 0; j < 6; j++) {
        BST += names_stats.get(validPokemonSearch.get(i + offset))[j];
        draw_text(names_stats.get(validPokemonSearch.get(i + offset))[j], width*13/20 + j*(width/35) - SELECTSCREENSHIFT_X, textHight + (i+1)*gridSize);
      }
      draw_text(BST, width*115/140 - SELECTSCREENSHIFT_X, textHight + (i+1)*gridSize);
      if (mousePressed && mousePressValid == true && drawSettingScreen==false) {
        if (mouseX < width*6/7 - SLIDER.i_w - SELECTSCREENSHIFT_X && mouseX >= width/7 + SELECTSCREENSHIFT_X && mouseY < height*7/45 + i*gridSize + SELECTSCREENSHIFT_Y && mouseY > height/9 + i*gridSize + SELECTSCREENSHIFT_Y && sliderFollow == false) {
          //pokemons.set(pokemonChangeNumber, new Pokemon(names_num.get(validPokemonSearch.get(i + offset)), boolean(int(random(0, 2)))));
          pokemonSlotNumber = slotNumber;
          pokemonNumber = names_num.get(validPokemonSearch.get(i + offset));
          moveSelectScreen = true;
          moveScreenReset = true;
          tempAnimationLoad = true;

          for (int k = i; k < POKEMON_PER_PAGE && k + 1 + offset <= num_names.size(); k++) {
            //line(width/7 + SELECTSCREENSHIFT_X, i*gridSize+textHight+gridSize/2, (width/7)*6 - SELECTSCREENSHIFT_X, i*gridSize+textHight+gridSize/2);
            //draw_rect(width/7 + SELECTSCREENSHIFT_X, height/9 + SELECTSCREENSHIFT_Y + i*gridSize, width*5/7 - SELECTSCREENSHIFT_X*2, gridSize);
            fill(255);
            if (k < validPokemonSearch.size()) {
              if (validPokemonSearch.size() > POKEMON_PER_PAGE) {
                offset = int(((SLIDER.i_y - sliderStartY)*(validPokemonSearch.size() - POKEMON_PER_PAGE)/((height*8/9 - SELECTSCREENSHIFT_Y*2) - SLIDER.i_h)));
              } else {
                offset = 0;
              }
              //println(validPokemonSearch.size(), validPokemonSearch.size()-POKEMON_PER_PAGE, offset, (height/9)*8 - SLIDER.i_h, SLIDER.i_y - sliderStartY);
              draw_text(names_num.get(validPokemonSearch.get(k + offset)), width*43/280 + SELECTSCREENSHIFT_X, textHight + (k+1)*gridSize);
              draw_text(validPokemonSearch.get(k + offset), width*3/14, textHight + (k+1)*gridSize);
              for (int j = 0; j < 2; j++) {
                if (names_types.get(validPokemonSearch.get(k + offset))[j] != null) {
                  draw_text(names_types.get(validPokemonSearch.get(k + offset))[j], width*11/35 + j*(width/20) - SELECTSCREENSHIFT_X, textHight + (k+1)*gridSize);
                }
              }
              for (int j = 0; j < 3; j++) {
                if (names_abilities.get(validPokemonSearch.get(k + offset))[j] != null) {
                  draw_text(names_abilities.get(validPokemonSearch.get(k + offset))[j].replaceAll("-", " "), width*9/20 + j*(width/14) - SELECTSCREENSHIFT_X*1.5, textHight + (k+1)*gridSize);
                }
              }
              BST = 0;
              for (int j = 0; j < 6; j++) {
                BST += names_stats.get(validPokemonSearch.get(k + offset))[j];
                draw_text(names_stats.get(validPokemonSearch.get(k + offset))[j], width*13/20 + j*(width/35) - SELECTSCREENSHIFT_X, textHight + (k+1)*gridSize);
              }
              draw_text(BST, width*115/140 - SELECTSCREENSHIFT_X, textHight + (k+1)*gridSize);
            }
          }

          SLIDER.i_y = sliderStartY;
          pokemonSearch = "";
          validPokemonSearch = new StringList();
          pokemonSearchBool = false;
          pokemonSelectScreen = true;
          mousePressValid = false;
        }
      }
    }
  }
  //fill(0);
  //draw_rect((width/7)*6 - SLIDER.i_w - SELECTSCREENSHIFT_X, height/9 + SELECTSCREENSHIFT_Y, SLIDER.i_w, (height/9)*8 - SELECTSCREENSHIFT_Y*2);
  fill(255);
  draw_rect(SLIDER.i_x, SLIDER.i_y, SLIDER.i_w, SLIDER.i_h);
  fill(0, 0, 0, 150);
  stroke(255);
  strokeWeight(1);
  draw_rect(SEARCH_BUTTON.i_x, SEARCH_BUTTON.i_y, SEARCH_BUTTON.i_w, SEARCH_BUTTON.i_h);
  fill(255);
  if (pokemonSearch == "") {
    draw_text("Search by Name", width*43/280 + SELECTSCREENSHIFT_X, height/36 + SELECTSCREENSHIFT_Y);
  } else {
    draw_text(pokemonSearch, width*43/280 + SELECTSCREENSHIFT_X, height/36 + SELECTSCREENSHIFT_Y);
  }
  textAlign(CENTER);

  draw_imageMode(CORNER);
  draw_image(back, width*6/7 - SELECTSCREENSHIFT_X - width*23/350 - 10, SEARCH_BUTTON.i_y);
  //rect(1048,90,width*23/350, 50);
  //println(sliderFollow);
  //draw_image(back, 1048, 90);


  if (mousePressed && mousePressValid == true && drawSettingScreen==false) {   
    if (sliderFollow == false) {
      if (mouseX <= width*6/7 - SELECTSCREENSHIFT_X - 10 && mouseX >= width*6/7 - SELECTSCREENSHIFT_X - width*23/350 - 10 && mouseY <= SEARCH_BUTTON.i_y + height/18 && mouseY >= SEARCH_BUTTON.i_y) {
        //if (mouseX >= width*6/7 - SELECTSCREENSHIFT_X - width*23/350 - 10 && mouseY >= SEARCH_BUTTON.i_y) {
        //moveSelectScreen = false;
        //mousePressValid = false;
        pokemonSelectScreen = false;
      }

      //if (mouseX <= SEARCH_BUTTON.i_x + SEARCH_BUTTON.i_w && mouseX >= SEARCH_BUTTON.i_x && mouseY <= SEARCH_BUTTON.i_y + SEARCH_BUTTON.i_h && mouseY >= SEARCH_BUTTON.i_y) {
      //  pokemonSearchBool = true;
      //} else {
      //  pokemonSearchBool = false;
      //}

      if (mouseX < width/7 || mouseX >= (width/7)*6) {
        pokemonSelectScreen = false;
        SLIDER.i_y = sliderStartY;
        pokemonSearch = "";
        validPokemonSearch = new StringList();
        pokemonSearchBool = false;
      }
    }

    if (mouseX >= SLIDER.i_x && mouseX <= SLIDER.i_x + SLIDER.i_w && mouseY >= SLIDER.i_y && mouseY <= SLIDER.i_y + SLIDER.i_h) {
      sliderFollow = true;
    }
  } else {
    sliderFollow = false;
  }
  if (sliderFollow == true) {
    if (mouseY >= height/9 + SELECTSCREENSHIFT_Y && mouseY <= height - SLIDER.i_h/2 - SELECTSCREENSHIFT_Y) {
      SLIDER.i_y = mouseY - SLIDER.i_h/2;
    } else if (mouseY <= height/9 + SELECTSCREENSHIFT_Y) {
      SLIDER.i_y = height/9 + SELECTSCREENSHIFT_Y;
    } else if (mouseY >= height - SLIDER.i_h) {
      SLIDER.i_y = height - SELECTSCREENSHIFT_Y - SLIDER.i_h;
    }
  }
  if (SLIDER.i_y + SLIDER.i_h > height - SELECTSCREENSHIFT_Y) {
    SLIDER.i_y = height - SLIDER.i_h - SELECTSCREENSHIFT_Y;
  } else if (SLIDER.i_y < height/9 + SELECTSCREENSHIFT_Y) {
    SLIDER.i_y = height/9 + SELECTSCREENSHIFT_Y;
  }
  draw_image(pokedex, 0, 0);
  strokeWeight(1);
  stroke(0);
}

void drawPokemonInformationScreen(int slotNumber, int pokeNum, float gridsize) {
  draw_image(backgroundImg, 0, 0);
  if (moveScreenReset == true) {
    level = 100;
    maxEV = 508;
    allPokeMoves = new StringList();
    selectedMoves = new String[4];
    EVRemaining = maxEV;
    selectedAbility = "";
    chooseAbility = false;
    abilityCount = 0;
    shinyBool = false;
    selectedGender = "";
    chooseGender = false;
    maleBool = false;
    femaleBool = false;
    unspecifiedBool = false;
    selectedNature = 0;

    if (num_male.get(pokeNum) != null) {
      selectedGender = genders[0];
      maleBool = true;
    } else if (num_female.get(pokeNum) != null) {
      selectedGender = genders[1];
      femaleBool = true;
    } else if (num_unspecified.get(pokeNum) != null) {
      selectedGender = genders[2];
      unspecifiedBool = true;
    }

    for (int i = 0; i < names_abilities.get(num_names.get(pokeNum)).length; i++) {
      if (names_abilities.get(num_names.get(pokeNum))[i] != null) {
        abilityCount++;
      }
    }
    for (int i = 0; i < 4; i++) {
      selectedMoves[i] = "";
    }    
    for (int i = 0; i < 6; i++) {
      IV[i] = 31;
      EV[i] = 0;
      statSliders.get(i).i_x = statSliderStartX[i];
    }
    for (int i = 0; i < 5; i++) {
      nature[i] = 0;
    }
    textRestrain = width*3/8 - MOVESLIDER.i_w;
    for (int i = 0; i < names_moves.get(num_names.get(pokeNum)).length; i++) {
      for (int j = 0; j < names_moves.get(num_names.get(pokeNum))[i].length; j++) {
        allPokeMoves.append(names_moves.get(num_names.get(pokeNum))[i][j]);
        if (textWidth(names_moves.get(num_names.get(pokeNum))[i][j].replaceAll("-", " ")) > moveScreenNamePos) {
          moveScreenNamePos = int(textWidth(names_moves.get(num_names.get(pokeNum))[i][j].replaceAll("-", " ")));
        }
        //moves_data.put(names_moves.get(num_names.get(pokeNum))[i][j], getMoveData(names_moves.get(num_names.get(pokeNum))[i][j]));
      }
    }

    moveScreenReset = false;
  } else if (moveScreenReload == true) {
    //for (int i = 0; i < 6; i++) {
    //  println(pokemons.get(i).EV);
    //}
    maxEV = 508;
    EVRemaining = maxEV;
    level = pokemons.get(slotNumber).level;
    selectedAbility = pokemons.get(slotNumber).ability;
    selectedGender = pokemons.get(slotNumber).gender;
    selectedNature = pokemons.get(slotNumber).natureNum;
    shinyBool = pokemons.get(slotNumber).shiny;
    nature = pokemons.get(slotNumber).nature;

    EV = new int[6];
    for (int i = 0; i < 6; i++) {
      EV[i] = pokemons.get(slotNumber).EV[i];
      EVRemaining -= pokemons.get(slotNumber).EV[i];
      statSliders.get(i).i_x = pokemons.get(slotNumber).sliderPos[i];
    }

    selectedMoves = new String[4];
    for (int i = 0; i < 4; i++) {
      selectedMoves[i] = pokemons.get(slotNumber).moves[i];
    }

    allPokeMoves = new StringList();
    chooseAbility = false;
    abilityCount = 0;
    chooseGender = false;
    maleBool = false;
    femaleBool = false;
    unspecifiedBool = false;

    for (int i = 0; i < names_abilities.get(num_names.get(pokeNum)).length; i++) {
      if (names_abilities.get(num_names.get(pokeNum))[i] != null) {
        abilityCount++;
      }
    }

    if (num_male.get(pokeNum) != null) {
      selectedGender = genders[0];
      maleBool = true;
    } else if (num_female.get(pokeNum) != null) {
      selectedGender = genders[1];
      femaleBool = true;
    } else if (num_unspecified.get(pokeNum) != null) {
      selectedGender = genders[2];
      unspecifiedBool = true;
    }

    textRestrain = width*3/8 - MOVESLIDER.i_w;
    for (int i = 0; i < names_moves.get(num_names.get(pokeNum)).length; i++) {
      for (int j = 0; j < names_moves.get(num_names.get(pokeNum))[i].length; j++) {
        allPokeMoves.append(names_moves.get(num_names.get(pokeNum))[i][j]);
        if (textWidth(names_moves.get(num_names.get(pokeNum))[i][j].replaceAll("-", " ")) > moveScreenNamePos) {
          moveScreenNamePos = int(textWidth(names_moves.get(num_names.get(pokeNum))[i][j].replaceAll("-", " ")));
        }
        //moves_data.put(names_moves.get(num_names.get(pokeNum))[i][j], getMoveData(names_moves.get(num_names.get(pokeNum))[i][j]));
      }
    }

    moveScreenReload = false;
  }
  stats[0] = ((((2*names_stats.get(num_names.get(pokeNum))[0] + IV[0] + int(EV[0]/4))*level))/100 + level + 10);
  stats[1] = (((2*names_stats.get(num_names.get(pokeNum))[1] + IV[1] + int(EV[1]/4))*level)/100 + 5);
  stats[2] = (((2*names_stats.get(num_names.get(pokeNum))[2] + IV[2] + int(EV[2]/4))*level)/100 + 5);
  stats[3] = (((2*names_stats.get(num_names.get(pokeNum))[3] + IV[3] + int(EV[3]/4))*level)/100 + 5);
  stats[4] = (((2*names_stats.get(num_names.get(pokeNum))[4] + IV[4] + int(EV[4]/4))*level)/100 + 5);
  stats[5] = (((2*names_stats.get(num_names.get(pokeNum))[5] + IV[5] + int(EV[5]/4))*level)/100 + 5);
  for (int i = 0; i < 5; i++) {
    if (nature[i] == 1) {
      stats[i+1] *= 1.1;
    } else if (nature[i] == -1) {
      stats[i+1] = int(stats[i+1] / 1.1);
    }
  }
  EVRemaining = maxEV - EV[0] - EV[1] - EV[2] - EV[3] - EV[4] - EV[5];
  //draw_image(pokedex, 0, 0);

  offsetMoves = int((MOVESLIDER.i_y - moveSliderStartY)*(allPokeMoves.size()-MOVES_PER_PAGE)/((height - SELECTSCREENSHIFT_Y - moveSliderStartY)-MOVESLIDER.i_h));
  offsetNature = int((NATURESLIDER.i_y - natureSliderStartY)*(natureName.length-NATURES_PER_PAGE)/((height - SELECTSCREENSHIFT_Y - natureSliderStartY)-NATURESLIDER.i_h));

  if (tempAnimationLoad) {
    tempAnimations = loadPokemonAll(loadJSONObject(POKEINFO_PATH+"pokemon/"+pokeNum+".txt")); 
    tempAnimationLoad = false;
  }
  draw_rectMode(CORNER);
  //draw_rect(width/7 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y, width*5/7 - SELECTSCREENSHIFT_X*2 + 100, height - SELECTSCREENSHIFT_Y*2);

  fill(0, 0, 0, 150);
  draw_rect(0, 0, width, height);
  stroke(255);
  textAlign(CENTER, CENTER);
  fill(255);
  for (int i = 0; i < 4; i++) {
    //draw_rect(width/7 + SELECTSCREENSHIFT_X + (height/4)*i, SELECTSCREENSHIFT_Y, height/4, height/4);
    if (i > 0) {
      draw_line(width/7 + SELECTSCREENSHIFT_X + (width*9/56)*i, SELECTSCREENSHIFT_Y, width/7 + SELECTSCREENSHIFT_X + (width*9/56)*i, SELECTSCREENSHIFT_Y + height/4);
    }
    draw_text(pictureType[i], width/7 + SELECTSCREENSHIFT_X + (width*9/56)*i + width*9/112, SELECTSCREENSHIFT_Y + height*41/180);
    draw_imageMode(CENTER);
    drawPokemon(tempAnimations[i], width/7 + SELECTSCREENSHIFT_X + (width*9/56)*i + width*9/112, SELECTSCREENSHIFT_Y + height/8);
    draw_imageMode(CORNER);
  }
  draw_line(width/7 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height/4, width*6/7 - SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height/4);
  draw_line(width/7 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*19/60, width*6/7 - SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*19/60);
  //draw_rect(width/7 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height/4, width*5/7 - SELECTSCREENSHIFT_X*2, 60);
  draw_image(back, width*3/20 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*23/90);
  draw_image(confirm, width*549/700 - SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*23/90);
  //draw_rect(width*3/20 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*23/90, width*23/350, height/18);
  //draw_rect(width*549/700 - SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*23/90, width*23/350, height/18);
  //draw_text("Back", width*3/20 + SELECTSCREENSHIFT_X + width*23/700, SELECTSCREENSHIFT_Y + height*23/90 + height/36);
  //draw_text("Confirm", width*549/700 - SELECTSCREENSHIFT_X + width*23/700, SELECTSCREENSHIFT_Y + height*23/90 + height/36);
  //draw_image(confirm, width*549/700 - SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*23/90);

  fill(0, 0, 0, 150);
  strokeWeight(3);
  if (shinyBool == false) {
    stroke(100);
    draw_rect(width*16/35, SELECTSCREENSHIFT_Y + height*58/225, width*3/35, height*23/450);
    draw_rect(width*129/280, SELECTSCREENSHIFT_Y + height*79/300, width*3/70, height/25);
    fill(255);
    draw_text("SHINY", width*27/56, SELECTSCREENSHIFT_Y + height*17/60);
  } else {
    stroke(#36FAFF);
    draw_rect(width*16/35, SELECTSCREENSHIFT_Y + height*58/225, width*3/35, height*23/450);
    draw_rect(width*139/280, SELECTSCREENSHIFT_Y + height*79/300, width*3/70, height/25);
    fill(255);
    draw_text("SHINY", width*29/56, SELECTSCREENSHIFT_Y + height*17/60);
  }
  textAlign(LEFT);
  fill(0, 0, 0, 150);
  stroke(0);
  strokeWeight(1);
  //draw_rect(width/7 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + 900/4 + 60, width*5/7 - SELECTSCREENSHIFT_X*2, 187);
  if (moveSelect) {
    if (moveSearch == "" && validMoveSearch.size() < names_moves.get(num_names.get(pokemonNumber))[0].length + names_moves.get(num_names.get(pokemonNumber))[1].length + names_moves.get(num_names.get(pokemonNumber))[2].length + names_moves.get(num_names.get(pokemonNumber))[3].length) {
      for (int i = 0; i < 4; i++) {
        for (int j = 0; j < names_moves.get(num_names.get(pokemonNumber))[i].length; j++) {
          validMoveSearch.append(names_moves.get(num_names.get(pokemonNumber))[i][j]);
        }
      }
    }
    //draw_rect(width/7 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height/4 + 248, width*5/7 - SELECTSCREENSHIFT_X*2, 44);
    //draw_rect(width/7 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height/4 + 291, width*5/7 - SELECTSCREENSHIFT_X*2, 224);
    stroke(255);
    draw_line(width/7 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*43/75, width*6/7 - SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*43/75);
    fill(255);
    if (MOVESLIDER.i_y + MOVESLIDER.i_h > height - SELECTSCREENSHIFT_Y) {
      MOVESLIDER.i_y = height - MOVESLIDER.i_h - SELECTSCREENSHIFT_Y;
    } else if (MOVESLIDER.i_y < SELECTSCREENSHIFT_Y + height*43/75) {
      MOVESLIDER.i_y = SELECTSCREENSHIFT_Y + height*43/75;
    }
    draw_rect(MOVESLIDER.i_x, MOVESLIDER.i_y, MOVESLIDER.i_w, MOVESLIDER.i_h);
    for (int i = 0; i < MOVES_PER_PAGE && i + 1 + offsetMoves <= names_moves.get(num_names.get(pokemonNumber))[0].length + names_moves.get(num_names.get(pokemonNumber))[1].length + names_moves.get(num_names.get(pokemonNumber))[2].length + names_moves.get(num_names.get(pokemonNumber))[3].length; i++) {
      if (i < validMoveSearch.size()) {
        if (validMoveSearch.size() > MOVES_PER_PAGE) {
          offsetMoves = int((MOVESLIDER.i_y - moveSliderStartY)*(validMoveSearch.size()-MOVES_PER_PAGE)/((height - SELECTSCREENSHIFT_Y - moveSliderStartY)-MOVESLIDER.i_h));
        } else {
          offsetMoves = 0;
        }
        if (offsetMoves < 0) {
          offsetMoves = 0;
        }

        draw_text(validMoveSearch.get(i + offsetMoves).replaceAll("-", " "), width*43/280 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*521/900 + gridsize/2 + i*gridsize);
        //println(validMoveSearch.get(i + offsetMoves), moves_data.get(validMoveSearch.get(i + offsetMoves))[0]);
        // println(moves_data.get("rollout"));
        draw_text(moves_data.get(validMoveSearch.get(i + offsetMoves))[0], width*43/280 + SELECTSCREENSHIFT_X + width*3/35, SELECTSCREENSHIFT_Y + height*521/900 + gridsize/2 + i*gridsize);
        draw_text(moves_data.get(validMoveSearch.get(i + offsetMoves))[1], width*43/280 + SELECTSCREENSHIFT_X + width*9/70, SELECTSCREENSHIFT_Y + height*521/900 + gridsize/2 + i*gridsize);
        draw_text(moves_data.get(validMoveSearch.get(i + offsetMoves))[2], width*43/280 + SELECTSCREENSHIFT_X + width*6/35, SELECTSCREENSHIFT_Y + height*521/900 + gridsize/2 + i*gridsize);
        draw_text(moves_data.get(validMoveSearch.get(i + offsetMoves))[3], width*43/280 + SELECTSCREENSHIFT_X + width/5, SELECTSCREENSHIFT_Y + height*521/900 + gridsize/2 + i*gridsize);
        draw_text(moves_data.get(validMoveSearch.get(i + offsetMoves))[4], width*43/280 + SELECTSCREENSHIFT_X + width*8/35, SELECTSCREENSHIFT_Y + height*521/900 + gridsize/2 + i*gridsize);
        if (textWidth(moves_data.get(validMoveSearch.get(i + offsetMoves))[6]) < textRestrain) {
          draw_text(moves_data.get(validMoveSearch.get(i + offsetMoves))[6], width*43/280 + SELECTSCREENSHIFT_X + width*9/35, SELECTSCREENSHIFT_Y + height*521/900 + gridsize/2 + i*gridsize);
        } else {
          for (int j = moves_data.get(validMoveSearch.get(i + offsetMoves))[6].length(); j > 0; j--) {
            if (textWidth(moves_data.get(validMoveSearch.get(i + offsetMoves))[6].substring(0, j) + "...") < textRestrain) {
              draw_text(moves_data.get(validMoveSearch.get(i + offsetMoves))[6].substring(0, j) + "...", width*43/280 + SELECTSCREENSHIFT_X + width*9/35, SELECTSCREENSHIFT_Y + height*521/900 + gridsize/2 + i*gridsize);
              break;
            }
          }
        }
        if (mousePressed && mousePressValid == true && drawSettingScreen==false) {
          if (mouseX < width*6/7 - MOVESLIDER.i_w - SELECTSCREENSHIFT_X && mouseX >= width/7 + SELECTSCREENSHIFT_X && mouseY < height*521/900 + (i+1)*gridSize + SELECTSCREENSHIFT_Y && mouseY > height*521/900 + i*gridSize + SELECTSCREENSHIFT_Y && moveSliderFollow == false) {
            selectedMoves[moveSlot] = validMoveSearch.get(i + offsetMoves);
            MOVESLIDER.i_y = moveSliderStartY;
            validMoveSearch = new StringList();
            moveSelect = false;
            moveSearch = "";
            mousePressValid = false;
          }
        }
      }
      //textAlign(CENTER);
      draw_text("Move Name", width*43/280 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*499/900);
      draw_text("Type", width*43/280 + SELECTSCREENSHIFT_X + width*3/35, SELECTSCREENSHIFT_Y + height*499/900);
      draw_text("Category", width*43/280 + SELECTSCREENSHIFT_X + width*9/70, SELECTSCREENSHIFT_Y + height*499/900);
      draw_text("Pow", width*43/280 + SELECTSCREENSHIFT_X + width*6/35, SELECTSCREENSHIFT_Y + height*499/900);
      draw_text("Acc", width*43/280 + SELECTSCREENSHIFT_X + width/5, SELECTSCREENSHIFT_Y + height*499/900);
      draw_text("PP", width*43/280 + SELECTSCREENSHIFT_X + width*8/35, SELECTSCREENSHIFT_Y + height*499/900);
      draw_text("Description", width*43/280 + SELECTSCREENSHIFT_X + width*9/35, SELECTSCREENSHIFT_Y + height*499/900);
      /*
      draw_text("Move Name", width*43/280 + SELECTSCREENSHIFT_X + moveScreenNamePos/2, SELECTSCREENSHIFT_Y + height*499/900);
       draw_text("Type", width*43/280 + SELECTSCREENSHIFT_X + width*3/35 + textWidth("fighting")/2, SELECTSCREENSHIFT_Y + height*499/900);
       draw_text("Category", width*43/280 + SELECTSCREENSHIFT_X + width*9/70 + textWidth("physical")/2, SELECTSCREENSHIFT_Y + height*499/900);
       draw_text("Pow", width*43/280 + SELECTSCREENSHIFT_X + width*6/35 + textWidth("150")/2, SELECTSCREENSHIFT_Y + height*499/900);
       draw_text("Acc", width*43/280 + SELECTSCREENSHIFT_X + width/5 + textWidth("100")/2, SELECTSCREENSHIFT_Y + height*499/900);
       draw_text("PP", width*43/280 + SELECTSCREENSHIFT_X + width*8/35 + textWidth("60")/2, SELECTSCREENSHIFT_Y + height*499/900);
       draw_text("Description", width*43/280 + SELECTSCREENSHIFT_X + width*9/35 + textRestrain/2, SELECTSCREENSHIFT_Y + height*499/900);
       */
      textAlign(LEFT);

      fill(0, 0, 0, 150);
      stroke(255);
      strokeWeight(1);
      draw_rect(MOVE_SEARCH_BUTTON.i_x, MOVE_SEARCH_BUTTON.i_y, MOVE_SEARCH_BUTTON.i_w, MOVE_SEARCH_BUTTON.i_h);
      fill(255);
      if (moveSearch == "") {
        draw_text("Search by Move", width*19/28, SELECTSCREENSHIFT_Y + height*499/900);
      } else {
        draw_text(moveSearch, width*19/28, SELECTSCREENSHIFT_Y + height*499/900);
      }
      //println(offsetMoves, allPokeMoves.size(), MOVESLIDER.i_y, offset);

      if (moveSliderFollow == true) {
        if (mouseY >= SELECTSCREENSHIFT_Y + height*43/75 && mouseY <= height - MOVESLIDER.i_h/2 - SELECTSCREENSHIFT_Y) {
          MOVESLIDER.i_y = mouseY - MOVESLIDER.i_h/2;
        } else if (mouseY <= SELECTSCREENSHIFT_Y + height*43/75) {
          MOVESLIDER.i_y = SELECTSCREENSHIFT_Y + height*43/75;
        } else if (mouseY >= height - SELECTSCREENSHIFT_Y - MOVESLIDER.i_h) {
          MOVESLIDER.i_y = height - SELECTSCREENSHIFT_Y - MOVESLIDER.i_h;
        }
      }
    }
  } else if (statSelect == true) {
    fill(255);
    stroke(255);
    draw_line(width*113/280 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*473/900, width*113/280 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*247/300);
    draw_line(width*21/40 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*473/900, width*21/40 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*247/300);
    draw_line(width*23/280 + SELECTSCREENSHIFT_X + (width*5/7 - SELECTSCREENSHIFT_X*2)/2, SELECTSCREENSHIFT_Y + height*259/450, width*57/280 + SELECTSCREENSHIFT_X + (width*5/7 - SELECTSCREENSHIFT_X*2)/2, SELECTSCREENSHIFT_Y + height*259/450);
    //draw_rect(width/7 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height/4 + 60 + 188, 365, 268); 
    //draw_rect(width/7 + SELECTSCREENSHIFT_X + (width*5/7 - SELECTSCREENSHIFT_X*2)/2 + 85, SELECTSCREENSHIFT_Y + height/4 + 60 + 188, 365, 268);    
    //draw_rect(width/7 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height/4 + 60 + 188, (width*5/7 - SELECTSCREENSHIFT_X*2)/2 - 85, 268);    
    //draw_rect(width/7 + SELECTSCREENSHIFT_X + (width*5/7 - SELECTSCREENSHIFT_X*2)/2 - 85, SELECTSCREENSHIFT_Y + height/4 + 60 + 188 + 45, 170, 223);
    //draw_rect(width/7 + SELECTSCREENSHIFT_X + (width*5/7 - SELECTSCREENSHIFT_X*2)/2 - 85, SELECTSCREENSHIFT_Y + height/4 + 60 + 188, 170, 45);

    if (NATURESLIDER.i_y + NATURESLIDER.i_h > height - SELECTSCREENSHIFT_Y) {
      NATURESLIDER.i_y = height - NATURESLIDER.i_h - SELECTSCREENSHIFT_Y;
    } else if (NATURESLIDER.i_y < natureSliderStartY) {
      NATURESLIDER.i_y = natureSliderStartY;
    }
    draw_rect(NATURESLIDER.i_x, NATURESLIDER.i_y, NATURESLIDER.i_w, NATURESLIDER.i_h);
    fill(255);
    textAlign(RIGHT, CENTER);
    draw_text("HP", width*9/40, height*61/90);
    draw_text("Attack", width*9/40, height*64/90);
    draw_text("Defence", width*9/40, height*67/90);
    draw_text("Sp. Atk.", width*9/40, height*70/90);
    draw_text("Sp. Def.", width*9/40, height*73/90);
    draw_text("Speed", width*9/40, height*76/90);

    textAlign(LEFT, CENTER);
    natureString = natureName[selectedNature];
    if (natureStat[selectedNature].length > 0) {
      natureString += " (+" + natureStat[selectedNature][0] + ", -" + natureStat[selectedNature][1] + ")";
    }
    draw_text("Nature : " + natureString, width*9/40, height*80/90);

    textAlign(RIGHT, CENTER);
    draw_text("Base", width/4, height*29/45);
    for (int i = 0; i < 6; i++) {
      fill(255);
      draw_text(names_stats.get(num_names.get(pokeNum))[i], width/4, height*61/90 + i*(height/30));
      //draw_rect(355, 606 + i*30, 250, 10);
      if (i == 0) {
        fill(-13 + (stats[i]*180)/714, 205, 205);
        draw_rect(width*71/280, height*101/150 + i*(height/30), (stats[i] * (width*5/28)) / 714, height/90);
      } else {
        fill(-13 + (stats[i]*180)/614, 205, 205);
        draw_rect(width*71/280, height*101/150 + i*(height/30), (stats[i] * (width*5/28)) / 614, height/90);
      }
    }
    fill(255);
    textAlign(CENTER, CENTER);
    draw_text("Nature", width/2, height*29/45);
    textAlign(LEFT, CENTER);
    for (int i = 0; i < NATURES_PER_PAGE; i++) {
      offsetNature = max(0, offsetNature);
      natureString = natureName[i + offsetNature];
      if (natureStat[i + offsetNature].length > 0) {
        natureString += " (+" + natureStat[i + offsetNature][0] + ", -" + natureStat[i + offsetNature][1] + ")";
      }
      draw_text(natureString, width*25/56, height*61/90 + i*(height/45));
    }
    draw_text("Remaining EV: " + EVRemaining, width*4/7, height*44/45 - SELECTSCREENSHIFT_Y);
    textAlign(CENTER, CENTER);
    draw_text("EVs", width*163/280, height*29/45);
    draw_text("IVs", width*4/5 - SELECTSCREENSHIFT_X, height*29/45);

    for (int i = 0; i < 6; i++) {
      EV[i] = round((statSliders.get(i).i_x - statSliderStartX[i])*(252)/((width*31/40 - SELECTSCREENSHIFT_X - statSliderStartX[i])-statSliders.get(i).i_w));

      if (statSliderFollow[i] == true) {
        if (mouseX >= statSliderStartX[i] && mouseX <= width*31/40 - SELECTSCREENSHIFT_X - statSliders.get(i).i_w/2) {
          statSliders.get(i).i_x = mouseX - statSliders.get(i).i_w/2;
        } else if (mouseX <= statSliderStartX[i]) {
          statSliders.get(i).i_x = statSliderStartX[i];
        } else if (mouseX >= width*31/40 - SELECTSCREENSHIFT_X - statSliders.get(i).i_w) {
          statSliders.get(i).i_x = width*31/40 - SELECTSCREENSHIFT_X - statSliders.get(i).i_w;
        } 

        EV[i] = round((statSliders.get(i).i_x - statSliderStartX[i])*(252)/((width*31/40 - SELECTSCREENSHIFT_X - statSliderStartX[i])-statSliders.get(i).i_w));

        int EVRemaining = maxEV;
        for (int j=0; j<6; j++) {
          if (i!=j)
            EVRemaining -= EV[j];
        }

        while (EV[i]>EVRemaining) {
          statSliders.get(i).i_x--;
          EV[i] = round((statSliders.get(i).i_x - statSliderStartX[i])*(252)/((width*31/40 - SELECTSCREENSHIFT_X - statSliderStartX[i])-statSliders.get(i).i_w));
        }
      }
      if (statSliders.get(i).i_x + statSliders.get(i).i_w > width*31/40 - SELECTSCREENSHIFT_X) {
        statSliders.get(i).i_x = width*31/40 - SELECTSCREENSHIFT_X;
      } else if (statSliders.get(i).i_x < statSliderStartX[i]) {
        statSliders.get(i).i_x = statSliderStartX[i];
      }

      EV[i] = round((statSliders.get(i).i_x - statSliderStartX[i])*(252)/((width*31/40 - SELECTSCREENSHIFT_X - statSliderStartX[i])-statSliders.get(i).i_w));

      fill(150);
      strokeWeight(0);
      draw_rect(width*169/280, height*152/225 + i*(height/30), width*6/35 - SELECTSCREENSHIFT_X, height/150);
      strokeWeight(1);
      fill(0, 0, 0, 150);
      draw_rect(width*159/280, height*601/900 + i*(height/30), width/35, height/45);
      draw_rect(width*11/14 - SELECTSCREENSHIFT_X, height*601/900 + i*(height/30), width/35, height/45);
      fill(255);
      draw_rect(statSliders.get(i).i_x, statSliders.get(i).i_y, statSliders.get(i).i_w, statSliders.get(i).i_h);
      fill(255);
      textAlign(LEFT, CENTER);
      draw_text(EV[i], width*4/7, height*611/900 + i*(height/30));
      draw_text(IV[i], width*221/280 - SELECTSCREENSHIFT_X, height*611/900 + i*(height/30));
      textAlign(CENTER, CENTER);
      draw_text(stats[i], width*117/140 - SELECTSCREENSHIFT_X, height*611/900 + i*(height/30));
    }

    textAlign(LEFT);
    fill(255);

    if (natureSliderFollow == true) {
      if (mouseY >= natureSliderStartY && mouseY <= height - NATURESLIDER.i_h/2 - SELECTSCREENSHIFT_Y) {
        NATURESLIDER.i_y = mouseY - NATURESLIDER.i_h/2;
      } else if (mouseY <= natureSliderStartY) {
        NATURESLIDER.i_y = natureSliderStartY;
      } else if (mouseY >= height - SELECTSCREENSHIFT_Y - NATURESLIDER.i_h) {
        NATURESLIDER.i_y = height - SELECTSCREENSHIFT_Y - NATURESLIDER.i_h;
      }
    }
  } else {
    fill(0, 0, 0, 150);
    draw_rect(width/7 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*473/900, width*5/7 - SELECTSCREENSHIFT_X*2, height*67/225);
  }
  fill(0, 0, 0, 150);
  stroke(255);
  for (int i = 0; i < 2; i++) {
    //draw_rect(width/7 + SELECTSCREENSHIFT_X + i*((width*5/7 - SELECTSCREENSHIFT_X*2)/3), SELECTSCREENSHIFT_Y + height/4 + 60, (width*5/7 - SELECTSCREENSHIFT_X*2)/3, 188);
    draw_line(width/7 + SELECTSCREENSHIFT_X + (width*3/14)*(i+1), SELECTSCREENSHIFT_Y + height*19/60, width/7 + SELECTSCREENSHIFT_X + (width*3/14)*(i+1), SELECTSCREENSHIFT_Y + height*473/900);
  }
  draw_line(width/7 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*473/900, width*6/7 - SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y + height*473/900);
  //draw_rect(width/7 + SELECTSCREENSHIFT_X, SELECTSCREENSHIFT_Y,400,400);
  //draw_rect(width/7 + SELECTSCREENSHIFT_X + 400, SELECTSCREENSHIFT_Y,width*5/7 - SELECTSCREENSHIFT_X*2 - 400,60);
  //for (int i = 0; i < 3; i++) {
  //draw_rect(width/7 + SELECTSCREENSHIFT_X + 400, SELECTSCREENSHIFT_Y + 60 + i*50,width*5/7 - SELECTSCREENSHIFT_X*2 - 400,50);
  //}
  //println(width/7 + SELECTSCREENSHIFT_X + 2*((width*5/7 - SELECTSCREENSHIFT_X*2)/3));
  textAlign(LEFT, CENTER);
  for (int i = 0; i < 4; i++) {
    fill(0, 0, 0, 150);
    draw_rect(width*29/70, height*79/180 + i*(height*2/45), width*6/35, height/30);
    fill(255);
    if (selectedMoves[i] == "") {
      draw_text("Select a move", width*117/280, height*79/180 + i*(height*2/45) + height/60);
    } else {
      draw_text(selectedMoves[i], width*117/280, height*79/180 + i*(height*2/45) + height/60);
    }
  }
  fill(0, 0, 0, 150);
  textAlign(LEFT);

  draw_rect(width*31/140, SELECTSCREENSHIFT_Y + height*31/72, height/30, height/30);
  draw_rect(width/4, SELECTSCREENSHIFT_Y + height*31/72, height/15, height/30);
  draw_rect(width*3/10, SELECTSCREENSHIFT_Y + height*31/72, height/30, height/30);
  draw_rect(width*31/140, height*103/180, width*11/70, height/30);
  draw_rect(width*39/140 + SELECTSCREENSHIFT_X, height*187/450, width/14, height/30);
  draw_rect(width*43/70, height*79/180, width*141/700, height/6, height/90);

  if (chooseAbility) {
    draw_rect(width*31/140, height*103/180, width*11/70, (abilityCount + 1)*(height/30));
    //draw_rect(310, 515, 220, height/30);
  }
  if (chooseGender) {
    draw_rect(width*39/140 + SELECTSCREENSHIFT_X, height*187/450, width/14, height*3/30);
  }
  //draw_rect(896,405, 205,10);
  //println((names_stats.get(num_names.get(pokeNum))[0]*2  + IV[0] + EV[0] + 5), ((names_stats.get(num_names.get(pokeNum))[0]*2  + IV[0] + EV[0] + 5)*205)/714, ((names_stats.get(num_names.get(pokeNum))[0]*2  + IV[0] + EV[0] + 5) / 714)*205);
  for (int i = 0; i < 6; i++) {
    if (i == 0) {
      fill(-13 + (stats[i]*180)/714, 205, 205);
      draw_rect(width*179/280, height*9/20, (stats[i] * (width*41/280)) / 714, height/90);
    } else {
      fill(-13 + (stats[i]*180)/614, 205, 205);
      draw_rect(width*179/280, height*9/20 + i*(height*23/900), (stats[i] * (width*41/280)) / 614, height/90);
    }
  }
  fill(255);

  textAlign(CENTER, CENTER);
  draw_text(level, width/4 + height/30, SELECTSCREENSHIFT_Y + height*161/360);
  draw_text("-", width*31/140 + height/60, SELECTSCREENSHIFT_Y + height*161/360);
  draw_text("+", width*3/10 + height/60, SELECTSCREENSHIFT_Y + height*161/360);
  textAlign(LEFT);
  //draw_text("Name: " + num_names.get(pokeNum), 700,150);
  draw_text("Name : " + num_names.get(pokeNum), width*3/20 + SELECTSCREENSHIFT_X, height*79/180);
  draw_text("Gender :", width*33/140 + SELECTSCREENSHIFT_X, height*79/180);
  //+ names_types.get(num_names.get(pokeNum))[0] + " & " + names_types.get(num_names.get(pokeNum))[1]
  draw_text("Types :", width*3/20 + SELECTSCREENSHIFT_X, height*221/450);
  draw_text("Level :", width*3/20 + SELECTSCREENSHIFT_X, height*163/300);
  draw_text("Ability :", width*3/20 + SELECTSCREENSHIFT_X, height*134/225);

  textAlign(CENTER);
  draw_image(type_image.get(names_types.get(num_names.get(pokeNum))[0]), width*3/20 + SELECTSCREENSHIFT_X + 53, height*221/450 - height*17/1200 - 2);
  draw_text(names_types.get(num_names.get(pokeNum))[0], width*3/20 + SELECTSCREENSHIFT_X + 53 + width*9/448, height*221/450);
  if (names_types.get(num_names.get(pokeNum))[1] != null) {
    draw_image(type_image.get(names_types.get(num_names.get(pokeNum))[1]), width*3/20 + SELECTSCREENSHIFT_X + 63 + width*9/224, height*221/450 - height*17/1200 - 2);
    draw_text(names_types.get(num_names.get(pokeNum))[1], width*3/20 + SELECTSCREENSHIFT_X + 63 + width*9/448 + width*9/224, height*221/450);
  }
  textAlign(LEFT);
  //fill(TYPE_COLOURS.get(names_types.get(num_names.get(pokeNum))[0]));
  //rectMode(CORNER);
  ///draw_rect(width/7 + SELECTSCREENSHIFT_X + 200, height*221/450, int(textWidth(names_types.get(num_names.get(pokeNum))[0])+4), 14);
  //fill(255);
  //draw_text(names_types.get(num_names.get(pokeNum))[0], width/7 + SELECTSCREENSHIFT_X + 200, height*221/450 + 7);
  //if (names_types.get(num_names.get(pokeNum))[1] != null) {
  //fill(TYPE_COLOURS.get(names_types.get(num_names.get(pokeNum))[1]));
  //draw_rect(width*3/20 + SELECTSCREENSHIFT_X + 10, height*221/450, int(textWidth(names_types.get(num_names.get(pokeNum))[1])+4), 14);
  //fill(255);
  //draw_text(names_types.get(num_names.get(pokeNum))[1], width*3/20 + SELECTSCREENSHIFT_X + 8 + 100, height*221/450);
  //}

  if (maleBool) {
    draw_text("Male", width*79/280 + SELECTSCREENSHIFT_X, height*79/180);
  } else if (femaleBool) {
    draw_text("Female", width*79/280 + SELECTSCREENSHIFT_X, height*79/180);
  } else if (unspecifiedBool) {
    draw_text("Unspecified", width*79/280 + SELECTSCREENSHIFT_X, height*79/180);
  } else if (selectedGender == "" || chooseGender == true) {
    draw_text("Select a gender", width*79/280 + SELECTSCREENSHIFT_X, height*79/180);
  } else {
    draw_text(selectedGender, width*79/280 + SELECTSCREENSHIFT_X, height*79/180);
  }

  if (chooseGender) {
    for (int i = 0; i < 2; i++) {
      draw_text(genders[i], width*79/280 + SELECTSCREENSHIFT_X, height*79/180 + (i+1)*height/30);
    }
  }

  textAlign(LEFT, CENTER);
  if (selectedAbility == "" || chooseAbility == true) {
    draw_text("Select an ability", width*8/35, height*103/180 + height/60);
  } else {
    draw_text(selectedAbility, width*8/35, height*103/180 + height/60);
  }


  if (chooseAbility) {
    for (int i = 0; i < abilityCount; i++) {
      if (names_abilities.get(num_names.get(pokeNum))[i] == null) {
        draw_text(names_abilities.get(num_names.get(pokeNum))[i+1], width*8/35, height*103/180 + height/60 + (i+1)*height/30);
      } else {
        draw_text(names_abilities.get(num_names.get(pokeNum))[i], width*8/35, height*103/180 + height/60 + (i+1)*height/30);
      }
    }
  }  
  textAlign(LEFT);
  draw_text("Moves", width*2/5, height*77/180);
  draw_text("1.", width*2/5, height*83/180);
  draw_text("2.", width*2/5, height*91/180);
  draw_text("3.", width*2/5, height*11/20);
  draw_text("4.", width*2/5, height*107/180);
  draw_text("Stats", width*87/140, height*77/180);
  textAlign(RIGHT);
  draw_text("HP", width*89/140, height*83/180);
  draw_text("ATK", width*89/140, height*73/150);
  draw_text("DEF", width*89/140, height*461/900);
  draw_text("SPA", width*89/140, height*121/225);
  draw_text("SPD", width*89/140, height*169/300);
  draw_text("SPE", width*89/140, height*53/90);
  textAlign(LEFT);
  fill(255);

  if (mousePressed && mousePressValid == true && drawSettingScreen==false) {
    if (moveSliderFollow == false && natureSliderFollow == false && statSliderFollow[0] == false && statSliderFollow[1] == false && statSliderFollow[2] == false && statSliderFollow[3] == false && statSliderFollow[4] == false && statSliderFollow[5] == false) {
      if (mouseX <= width*19/35 && mouseX >= width*16/35 && mouseY <= SELECTSCREENSHIFT_Y + height*139/450 && mouseY >= SELECTSCREENSHIFT_Y + height*58/225) {
        shinyBool = !shinyBool;
        mousePressValid = false;
      }
      if (mouseX <= width*17/20 - SELECTSCREENSHIFT_X && mouseX >= width*559/700 - SELECTSCREENSHIFT_X && mouseY <= SELECTSCREENSHIFT_Y + height*23/90 + height/18 && mouseY >= SELECTSCREENSHIFT_Y + height*23/90) {
        if (selectedAbility == "") {
          selectedAbility = names_abilities.get(num_names.get(pokeNum))[0];
        }
        if (selectedGender == "") {
          selectedGender = "Male";
        }
        moveSearch = "";
        int[] sliderPositions = new int[6];
        for (int i = 0; i < 6; i++) {
          sliderPositions[i] = statSliders.get(i).i_x;
        }
        pokemons.set(slotNumber, new Pokemon(pokeNum, shinyBool, level, selectedAbility, stats, selectedMoves, selectedGender, selectedNature, nature, EV, sliderPositions));
        pokemonSelectScreen = false;
        moveSelectScreen = false;
        //moveScreenReset = true;
        tempAnimationLoad = true;
        mousePressValid = false;
      }
      if (mouseX <= width*151/700 + SELECTSCREENSHIFT_X && mouseX >= width*3/20 + SELECTSCREENSHIFT_X && mouseY <= SELECTSCREENSHIFT_Y + height*23/90 + height/18 && mouseY >= SELECTSCREENSHIFT_Y + height*23/90) {
        MOVESLIDER.i_y = moveSliderStartY;
        moveSearch = "";
        moveSelect = false;
        moveSelectScreen = false;
        pokemonSearchBool = true;
        moveSearchBool = false;
        mousePressValid = false;
      }
      if (mouseX <= width*53/140 && mouseX >= width*31/140 && mouseY <= height*103/180 + height/30 && mouseY >= height*103/180) {
        chooseAbility = true;
      } else if (mouseX > width*53/140 || mouseX < width*31/140 || mouseY > height*103/180 + (height/30)*(abilityCount+1) || mouseY < height*103/180) {
        chooseAbility = false;
      }
      if (maleBool == false && femaleBool == false && unspecifiedBool == false) {
        if (mouseX <= width*7/20 + SELECTSCREENSHIFT_X && mouseX >= width*39/140 + SELECTSCREENSHIFT_X && mouseY <= height*187/450 + height/30 && mouseY >= height*187/450) {
          chooseGender = true;
        }
      }
    }
    if (chooseGender == false) {
      if (mouseX < width*39/140 + SELECTSCREENSHIFT_X || mouseX > width*7/20 + SELECTSCREENSHIFT_X || mouseY > height*187/450 + height/30 || mouseY < height*187/450) {
        chooseGender = false;
      }
    } else {
      if (mouseX < width*39/140 + SELECTSCREENSHIFT_X || mouseX > width*7/20 + SELECTSCREENSHIFT_X|| mouseY > height*187/450 + height*3/30 || mouseY < height*187/450) {
        chooseGender = false;
      }
    }
    if (chooseAbility == true) {
      for (int i = 0; i < abilityCount; i++) {
        if (mouseX <= width*53/140 && mouseX >= width*31/140 && mouseY <= height*103/180 + (i+2)*(height/30) && mouseY >= height*103/180 + (i+1)*(height/30)) {
          if (names_abilities.get(num_names.get(pokeNum))[i] == null) {
            selectedAbility = names_abilities.get(num_names.get(pokeNum))[i+1];
          } else {
            selectedAbility = names_abilities.get(num_names.get(pokeNum))[i];
          }
          chooseAbility = false;
        }
      }
    }
    if (chooseGender == true) {
      for (int i = 0; i < 2; i++) {
        if (mouseX <= width*7/20 + SELECTSCREENSHIFT_X && mouseX >= width*39/140 + SELECTSCREENSHIFT_X && mouseY <= height*187/450 + (i+2)*height/30 && mouseY >= height*187/450 + (i+1)*height/30) {
          selectedGender = genders[i];
          chooseGender = false;
        }
      }
    }
    if (moveSelect == false) {
      if (mouseX <= width*571/700 && mouseX >= width*43/70 && mouseY <= height*109/180 && mouseY >= height*59/180) {
        statSelect = true;
      }
    }
    if (mouseY <= SELECTSCREENSHIFT_Y + height*31/72 + height/30 && mouseY >= SELECTSCREENSHIFT_Y + height*31/72) {
      if (mouseX <= width*31/140 + height/30 && mouseX >= width*31/140) {
        if (level > 0 && moveSliderFollow == false && natureSliderFollow == false && statSliderFollow[0] == false && statSliderFollow[1] == false && statSliderFollow[2] == false && statSliderFollow[3] == false && statSliderFollow[4] == false && statSliderFollow[5] == false) {
          level -= 1;
          mousePressValid = false;
        }
      }
      if (mouseX <= width*3/10 + height/30 && mouseX >= width*3/10) {
        if (level < 100 && moveSliderFollow == false && natureSliderFollow == false && statSliderFollow[0] == false && statSliderFollow[1] == false && statSliderFollow[2] == false && statSliderFollow[3] == false && statSliderFollow[4] == false && statSliderFollow[5] == false) {
          level += 1;
          mousePressValid = false;
        }
      }
    }
    if (natureSliderFollow == false && statSliderFollow[0] == false && statSliderFollow[1] == false && statSliderFollow[2] == false && statSliderFollow[3] == false && statSliderFollow[4] == false && statSliderFollow[5] == false) {
      for (int i = 0; i < 4; i++) {
        if (mouseX <= width*41/70 && mouseX >= width*29/70 && mouseY <= height*17/36 + i*(height*2/45) && mouseY >= height*79/180 + i*(height*2/45)) {
          moveSelect = true;
          moveSearchBool = true;
          moveSlot = i;
        }
      }
    }
    if (moveSelect) {
      if (mouseX >= MOVESLIDER.i_x && mouseX <= MOVESLIDER.i_x + MOVESLIDER.i_w && mouseY >= MOVESLIDER.i_y && mouseY <= MOVESLIDER.i_y + MOVESLIDER.i_h) {
        moveSliderFollow = true;
      }
      //if (moveSliderFollow == false) {
      //  if (mouseX <= MOVE_SEARCH_BUTTON.i_x + MOVE_SEARCH_BUTTON.i_w && mouseX >= MOVE_SEARCH_BUTTON.i_x && mouseY <= MOVE_SEARCH_BUTTON.i_y + MOVE_SEARCH_BUTTON.i_h && mouseY >= MOVE_SEARCH_BUTTON.i_y) {
      //    moveSearchBool = true;
      //  } else {
      //    moveSearchBool = false;
      //  }
      //}
    } else if (statSelect && moveSelect == false) {
      if (natureSliderFollow == false && statSliderFollow[0] == false && statSliderFollow[1] == false && statSliderFollow[2] == false && statSliderFollow[3] == false && statSliderFollow[4] == false && statSliderFollow[5] == false) {
        for (int i = 0; i < NATURES_PER_PAGE; i++) {
          if (mouseX <= width*157/280 - NATURESLIDER.i_w && mouseX >= width*123/280 && mouseY <= natureSliderStartY + (i+1)*(height/45) && mouseY >= natureSliderStartY + i*(height/45)) {
            selectedNature = i + offsetNature;
            if (natureStat[i + offsetNature].length > 0) {
              for (int j = 0; j < 5; j++) {
                if (natureStat[i + offsetNature][0] == natureAbility[j]) {
                  nature[j] = 1;
                } else if (natureStat[i + offsetNature][1] == natureAbility[j]) {
                  nature[j] = -1;
                } else {
                  nature[j] = 0;
                }
              }
            } else {
              for (int j = 0; j < 5; j++) {
                nature[j] = 0;
              }
            }
            mousePressValid = false;
          }
        }
      }
      if (statSliderFollow[0] == false && statSliderFollow[1] == false && statSliderFollow[2] == false && statSliderFollow[3] == false && statSliderFollow[4] == false && statSliderFollow[5] == false) {
        if (mouseX >= NATURESLIDER.i_x && mouseX <= NATURESLIDER.i_x + NATURESLIDER.i_w && mouseY >= NATURESLIDER.i_y && mouseY <= NATURESLIDER.i_y + NATURESLIDER.i_h) {
          natureSliderFollow = true;
        }
      }
      for (int i = 0; i < 6; i++) {
        if (EVRemaining >= 0) {
          if (statSliderFollow[0] == false && statSliderFollow[1] == false && statSliderFollow[2] == false && statSliderFollow[3] == false && statSliderFollow[4] == false && statSliderFollow[5] == false && natureSliderFollow == false) {
            if (mouseX <= statSliders.get(i).i_x + statSliders.get(i).i_w && mouseX >= statSliders.get(i).i_x && mouseY <= statSliders.get(i).i_y + statSliders.get(i).i_h && mouseY >= statSliders.get(i).i_y) {
              statSliderFollow[i] = true;
              lastSliderTouched = i;
            }
          }
        }
      }
    }
  } else {
    moveSliderFollow = false;
    natureSliderFollow = false;
    for (int i = 0; i < 6; i++) {
      statSliderFollow[i] = false;
    }
  }
  draw_image(pokedex, 0, 0);
}

void drawFriendsList() {
  //fill(0, 0, 100, 100);
  fill(0, 0, 0, 100);
  stroke(255);
  draw_rect(width*3/256, height/48, width*5/32, height*5/12 - int(gridSize));
  //draw_rect(15, 15, 200, 20);
  //draw_rect(15, 35, 200, 280 - int(gridSize));
  draw_rect(FRIEND_SEARCH.i_x, FRIEND_SEARCH.i_y, FRIEND_SEARCH.i_w, FRIEND_SEARCH.i_h);
  draw_rect(FRIEND_ADD.i_x, FRIEND_ADD.i_y, FRIEND_ADD.i_w, FRIEND_ADD.i_h);
  //strokeWeight(1);
  line(FRIEND_ADD.i_x + width*3/1280, FRIEND_ADD.i_y + FRIEND_ADD.i_h/2, FRIEND_ADD.i_x + FRIEND_ADD.i_w - width*3/1280, FRIEND_ADD.i_y + FRIEND_ADD.i_h/2);
  line(FRIEND_ADD.i_x + FRIEND_ADD.i_w/2, FRIEND_ADD.i_y + height/240, FRIEND_ADD.i_x + FRIEND_ADD.i_w/2, FRIEND_ADD.i_y + FRIEND_ADD.i_h - height/240);
  // strokeWeight(1);
  for (int i = 0; i*gridSize < 280 - int(gridSize); i++) {
    draw_line(width*3/256, height*7/144 + int(i*gridSize), width*43/256, height*7/144 + int(i*gridSize));
  }

  if (friendSearch == "" && validFriendSearch.size() != friendList.length) {
    for (int i = 0; i < friendList.length; i++) {
      validFriendSearch.append(friendList[i]);
    }
  }

  fill(255);
  draw_rect(FRIEND_SLIDER.i_x, FRIEND_SLIDER.i_y, FRIEND_SLIDER.i_w, FRIEND_SLIDER.i_h);

  textAlign(CENTER, CENTER);
  offsetFriend = int((FRIEND_SLIDER.i_y - friendSliderStartY)*(friendList.length-10)/((height*7/16 - int(gridSize) - friendSliderStartY)-FRIEND_SLIDER.i_h));
  if (validFriendSearch.size() > 0) {
    for (int i = 0; i < 10 && i + 1 + offsetFriend <= friendList.length; i++) {  
      if (i < validFriendSearch.size()) {
        if (validFriendSearch.size() > 10) {
          //println("MORE");
          offsetFriend = int((FRIEND_SLIDER.i_y - friendSliderStartY)*(validFriendSearch.size()-10)/((height*7/16 - int(gridSize) - friendSliderStartY)-FRIEND_SLIDER.i_h));
        } else {
          //println("zero");
          offsetFriend = 0;
        }
        if (offsetFriend < 0) {
          offsetFriend = 0;
        }
        fill(0, 0, 0, 100);
        draw_rect(FRIEND_SEARCH.i_x, height*7/144 + int(i*gridSize) + int(gridSize/2) - FRIEND_ADD.i_h/2, FRIEND_ADD.i_w, FRIEND_ADD.i_h);
        draw_rect(FRIEND_SEARCH.i_x + FRIEND_ADD.i_w + width/640, height*7/144 + int(i*gridSize) + int(gridSize/2) - FRIEND_ADD.i_h/2, FRIEND_ADD.i_w, FRIEND_ADD.i_h);
        fill(255);
        draw_text(validFriendSearch.get(i + offsetFriend), width*23/256, height*7/144 + int(i*gridSize) + int(gridSize/2));
        line(FRIEND_SEARCH.i_x + width*3/1280, height*7/144 + int(i*gridSize) + int(gridSize/2), FRIEND_SEARCH.i_x + FRIEND_ADD.i_w - width*3/1280, height*7/144 + int(i*gridSize) + int(gridSize/2));
        imageMode(CENTER);
        draw_image(shield, FRIEND_SEARCH.i_x + FRIEND_ADD.i_w + width/640 + FRIEND_ADD.i_w/2, height*7/144 + int(i*gridSize) + int(gridSize/2));
        imageMode(CORNER);

        if (mousePressed && mousePressValid == true) {
          if (mouseX >= FRIEND_SEARCH.i_x && mouseX <= FRIEND_SEARCH.i_x + FRIEND_ADD.i_w && 
            mouseY >= height*7/144 + int(i*gridSize) + int(gridSize/2) - FRIEND_ADD.i_h/2 && mouseY <= height*7/144 + int(i*gridSize) + int(gridSize/2) + FRIEND_ADD.i_h/2 && friendSliderFollow == false) {
            //println("REMOVING");
            JSONObject json = new JSONObject();
            json.setString("username", player_name);
            json.setString("newfriend", validFriendSearch.get(i + offsetFriend));
            json.setString("battlestate", "removefriend");
            myClient.write(json.toString());
            mousePressValid = false;
            //validFriendSearch = new StringList();
            //json = new JSONObject();
            //json.setString("username", player_name);
            //json.setString("battlestate", "friendread");
            //myClient.write(json.toString());
          }
        }
      }
    }
  } else {
    fill(255);
    draw_text("Add a friend", width*23/256, height*7/144 + int(gridSize/2));
  }

  // validFriendSearch = new StringList();
  //println(offsetFriend, friendList.length, validFriendSearch.size());

  textAlign(LEFT, CENTER);
  fill(255);
  if (friendSearch == "") {
    draw_text("Search by Friend", FRIEND_SEARCH.i_x + 2, FRIEND_SEARCH.i_y + (FRIEND_SEARCH.i_h/2) - 2);
  } else {
    draw_text(friendSearch, FRIEND_SEARCH.i_x + 2, FRIEND_SEARCH.i_y + (FRIEND_SEARCH.i_h/2) - 2);
  }

  if (mousePressed && mousePressValid == true) {
    if (mouseX >= FRIEND_SEARCH.i_x && mouseX <= FRIEND_SEARCH.i_x + FRIEND_SEARCH.i_w && mouseY >= FRIEND_SEARCH.i_y && mouseY <= FRIEND_SEARCH.i_y + FRIEND_SEARCH.i_h && friendSliderFollow == false) {
      friendSearchBool = true;
      mousePressValid = false;
    } else {
      friendSearchBool = false;
    }
    if (mouseX >= FRIEND_SLIDER.i_x && mouseX <= FRIEND_SLIDER.i_x + FRIEND_SLIDER.i_w && mouseY >= FRIEND_SLIDER.i_y && mouseY <= FRIEND_SLIDER.i_y + FRIEND_SLIDER.i_h) {
      friendSliderFollow = true;
    }    
    if (mouseX >= FRIEND_ADD.i_x && mouseX <= FRIEND_ADD.i_x + FRIEND_ADD.i_w && mouseY >= FRIEND_ADD.i_y && mouseY <= FRIEND_ADD.i_y + FRIEND_ADD.i_h && friendSliderFollow == false) {
      JSONObject json = new JSONObject();
      json.setString("username", player_name);
      json.setString("newfriend", friendSearch);
      json.setString("battlestate", "addfriend");
      myClient.write(json.toString());

      json = new JSONObject();
      json.setString("username", player_name);
      json.setString("battlestate", "friendread");
      myClient.write(json.toString());

      friendSearch = "";

      mousePressValid = false;
    }
  } else {
    friendSliderFollow = false;
  }
  if (friendSliderFollow == true) {
    if (mouseY >= height*7/144 && mouseY <= height*7/16 - int(gridSize) - FRIEND_SLIDER.i_h/2) {
      FRIEND_SLIDER.i_y = mouseY - FRIEND_SLIDER.i_h/2;
    } else if (mouseY <= height*7/144) {
      FRIEND_SLIDER.i_y = height*7/144;
    } else if (mouseY >= height*7/16 - int(gridSize) - FRIEND_SLIDER.i_h) {
      FRIEND_SLIDER.i_y = height*7/16 - int(gridSize) - FRIEND_SLIDER.i_h;
    }
  }
  if (FRIEND_SLIDER.i_y + FRIEND_SLIDER.i_h > height*7/16 - int(gridSize)) {
    FRIEND_SLIDER.i_y = height*7/16 - int(gridSize) - FRIEND_SLIDER.i_h;
  } else if (FRIEND_SLIDER.i_y < height*7/144) {
    FRIEND_SLIDER.i_y = height*7/144;
  }
}

void drawPokemon(PImage[] pAnimation, int x, int y, float s) {
  if (pAnimation.length>0) {
    pushMatrix();
    translate(x, y);
    scale(s, s);
    draw_image(pAnimation[(int) frameCount%pAnimation.length], 0, 0);
    popMatrix();
  }
}

void drawPokemon(PImage[] pAnimation, int x, int y) {
  drawPokemon(pAnimation, x, y, 1);
}

PFont font_plain;
PFont font_plain_big;
PFont font_plain_mid;
PFont font_plain_middle;
PFont font_big_solid;
PFont font_big_hollow;

int i_plain_font_size = 12;

boolean loading = true;

void setup() {
  size(1280, 720, P2D);
  //size(1400,900, P2D);
  //fullScreen();
  //size(displayWidth, displayHeight, P2D);
  frameRate(50);
  draw_imageMode(CENTER);
  noSmooth();
  colorMode(HSB);
  noSmooth();

  //font_plain = createFont("andalemo.ttf", 128);
  font_plain = createFont("SansSerif", 12);
  font_plain_big = createFont("SansSerif", 128);
  font_plain_mid = createFont("SansSerif", 32);
  font_plain_middle = createFont("SansSerif", 24);
  font_big_solid = createFont("Pokemon Solid.ttf", 128);
  font_big_hollow = createFont("Pokemon Hollow.ttf", 128);
  //textFont(font_plain);

  //String[] fontList = PFont.list();
  //printArray(fontList);

  myClient = new Client(this, IPv4, PORT);
}

void better_setup() {
  init_constants();

  Gif.tmpPath = dataPath("");

  validPokemonSearch = new StringList();
  validFriendSearch = new StringList();
  validMoveSearch = new StringList();

  infoButton = loadImage("infoButton.png");
  pokeBall = loadImage("Pokeball.png");
  settingsButton = loadImage("Settings.png");
  backgroundImg = loadImage("Background.jpg");
  startButton = loadImage("Button.png");
  pokedex = loadImage("pokedex2.png");
  back = loadImage("back.png");
  confirm = loadImage("Confirm.png");
  loginBack = loadImage("loginBackground.png");
  loginbutton = loadImage("Login.png");
  registerbutton = loadImage("Register.png");
  registerconfirm = loadImage("Confirm.png");
  loadbutton = loadImage("Load.png");
  savebutton = loadImage("Save.png");
  shield = loadImage("shield.png");

  settingsButton.resize(width/28, height/18);
  pokeBall.resize(height/30, height/30);
  infoButton.resize(height/30, height/30);
  backgroundImg.resize(width, height);
  startButton.resize(START_BUTTON.i_w, START_BUTTON.i_h);
  pokedex.resize(width, height);
  back.resize(width*23/350, height/18);
  confirm.resize(width*23/350, height/18);
  loginBack.resize(width, height);
  loginbutton.resize(width/5, height/6);
  registerbutton.resize(width/5, height/6);
  registerconfirm.resize(width/5, height/6);
  loadbutton.resize(width*5/32, height*5/36);
  savebutton.resize(width*5/32, height*5/36);
  shield.resize(int(FRIEND_ADD.i_w*0.75), int(FRIEND_ADD.i_h*0.75));

  for (int i = 0; i < types.length; i++) {
    tempImage = loadImage(types[i] + ".png");
    tempImage.resize(width*9/224, height/50);
    type_image.put(types[i], tempImage);
  }

  for (int i = 1; i <= 807; i++) {
    JSONObject file = loadJSONObject(POKEINFO_PATH+"pokemon/"+i+".txt");
    //JSONObject file = loadJSONObject("https://raw.githubusercontent.com/Komputer-Kids-Klub/pokeman/master/pokeinfo/pokemon/"+i+".txt");
    names_num.put(file.getString("name"), i);
    num_names.put(i, file.getString("name"));
    Integer[] stats = {int(file.getString("HP")), int(file.getString("ATK")), int(file.getString("DEF")), int(file.getString("SPA")), int(file.getString("SPD")), int(file.getString("SPE"))};
    String[] types = {file.getString("type1"), file.getString("type2")};
    String[] height_weight = {file.getString("height"), file.getString("weight")};
    String ab1 = file.getString("ability1");
    String ab2 = file.getString("ability2");
    String ab3 = file.getString("hiddenability");
    String[] abilities = {ab1, ab2, ab3};
    names_stats.put(file.getString("name"), stats);
    names_types.put(file.getString("name"), types);
    names_species.put(file.getString("name"), file.getString("species"));
    names_height_weight.put(file.getString("name"), height_weight);
    names_abilities.put(file.getString("name"), abilities);

    String[] levelMoves = new String[file.getJSONArray("levelmoves").size()];
    for (int j = 0; j < file.getJSONArray("levelmoves").size(); j++) {
      if (file.getJSONArray("levelmoves").getJSONObject(j).getString("move") != "error") {
        levelMoves[j] = file.getJSONArray("levelmoves").getJSONObject(j).getString("move");
      }
    }
    String[] eggMoves = new String[file.getJSONArray("eggmoves").size()];
    for (int j = 0; j < file.getJSONArray("eggmoves").size(); j++) {
      if (file.getJSONArray("eggmoves").getJSONObject(j).getString("move") != "error") {
        eggMoves[j] = file.getJSONArray("eggmoves").getJSONObject(j).getString("move");
      }
    }
    String[] tutorMoves = new String[file.getJSONArray("tutormoves").size()];
    for (int j = 0; j < file.getJSONArray("tutormoves").size(); j++) {
      if (file.getJSONArray("tutormoves").getJSONObject(j).getString("move") != "error") {
        tutorMoves[j] = file.getJSONArray("tutormoves").getJSONObject(j).getString("move");
      }
    }
    String[] tmMoves = new String[file.getJSONArray("tmmoves").size()];
    for (int j = 0; j < file.getJSONArray("tmmoves").size(); j++) {
      if (file.getJSONArray("tmmoves").getJSONObject(j).getString("move") != "error") {
        tmMoves[j] = file.getJSONArray("tmmoves").getJSONObject(j).getString("move");
      }
    }
    String[][] allMoves = {levelMoves, eggMoves, tutorMoves, tmMoves};
    names_moves.put(file.getString("name"), allMoves);
  }

  PImage[] tempMoveAni = new PImage[8];
  for (int i = 1; i < 9; i++) {
    PImage tempAniImage = loadImage("Normal" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("normal", 8);
  move_animations.put("normal", tempMoveAni);

  tempMoveAni = new PImage[10];
  for (int i = 1; i < 11; i++) {
    PImage tempAniImage = loadImage("Fire" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("fire", 10);
  move_animations.put("fire", tempMoveAni);

  tempMoveAni = new PImage[16];
  for (int i = 1; i < 17; i++) {
    PImage tempAniImage = loadImage("Sound" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("sound", 16);
  move_animations.put("sound", tempMoveAni);

  tempMoveAni = new PImage[28];
  for (int i = 1; i < 29; i++) {
    PImage tempAniImage = loadImage("Electric" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("electric", 28);
  move_animations.put("electric", tempMoveAni);

  tempMoveAni = new PImage[32];
  for (int i = 1; i < 33; i++) {
    PImage tempAniImage = loadImage("Dragon" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("dragon", 32);
  move_animations.put("dragon", tempMoveAni);

  tempMoveAni = new PImage[24];
  for (int i = 1; i < 25; i++) {
    PImage tempAniImage = loadImage("Ground" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("ground", 24);
  move_animations.put("ground", tempMoveAni);

  tempMoveAni = new PImage[28];
  for (int i = 1; i < 29; i++) {
    PImage tempAniImage = loadImage("Flying" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("flying", 28);
  move_animations.put("flying", tempMoveAni);

  tempMoveAni = new PImage[44];
  for (int i = 1; i < 45; i++) {
    PImage tempAniImage = loadImage("Ghost" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("ghost", 44);
  move_animations.put("ghost", tempMoveAni);

  tempMoveAni = new PImage[17];
  for (int i = 1; i < 18; i++) {
    PImage tempAniImage = loadImage("Water" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("water", 17);
  move_animations.put("water", tempMoveAni);

  tempMoveAni = new PImage[39];
  for (int i = 1; i < 40; i++) {
    PImage tempAniImage = loadImage("Fighting" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("fighting", 39);
  move_animations.put("fighting", tempMoveAni);

  tempMoveAni = new PImage[28];
  for (int i = 1; i < 27; i++) {
    PImage tempAniImage = loadImage("Grass" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("grass", 28);
  move_animations.put("grass", tempMoveAni);

  tempMoveAni = new PImage[40];
  for (int i = 1; i < 41; i++) {
    PImage tempAniImage = loadImage("Ice" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("ice", 40);
  move_animations.put("ice", tempMoveAni);

  tempMoveAni = new PImage[48];
  for (int i = 1; i < 49; i++) {
    PImage tempAniImage = loadImage("Psychic" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("psychic", 48);
  move_animations.put("psychic", tempMoveAni);

  tempMoveAni = new PImage[12];
  for (int i = 1; i < 13; i++) {
    PImage tempAniImage = loadImage("Punch" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("punch", 12);
  move_animations.put("punch", tempMoveAni);

  tempMoveAni = new PImage[41];
  for (int i = 1; i < 42; i++) {
    PImage tempAniImage = loadImage("Rock" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("rock", 41);
  move_animations.put("rock", tempMoveAni);

  tempMoveAni = new PImage[24];
  for (int i = 1; i < 25; i++) {
    PImage tempAniImage = loadImage("Steel" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("steel", 24);
  move_animations.put("steel", tempMoveAni);

  tempMoveAni = new PImage[16];
  for (int i = 1; i < 17; i++) {
    PImage tempAniImage = loadImage("Bite" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("bite", 16);
  move_animations.put("bite", tempMoveAni);

  tempMoveAni = new PImage[24];
  for (int i = 1; i < 25; i++) {
    PImage tempAniImage = loadImage("Bug" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("bug", 24);
  move_animations.put("bug", tempMoveAni);

  tempMoveAni = new PImage[24];
  for (int i = 1; i < 25; i++) {
    PImage tempAniImage = loadImage("Dark" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("dark", 24);
  move_animations.put("dark", tempMoveAni);

  tempMoveAni = new PImage[34];
  for (int i = 1; i < 35; i++) {
    PImage tempAniImage = loadImage("Fairy" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("fairy", 34);
  move_animations.put("fairy", tempMoveAni);

  tempMoveAni = new PImage[36];
  for (int i = 1; i < 37; i++) {
    PImage tempAniImage = loadImage("Poison" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("poison", 36);
  move_animations.put("poison", tempMoveAni);

  tempMoveAni = new PImage[12];
  for (int i = 1; i < 13; i++) {
    PImage tempAniImage = loadImage("Punch" + i + ".png");
    tempAniImage.resize(TEXT_CHAT_DIVIDE, height*13/18);
    tempMoveAni[i-1] = tempAniImage;
  }
  move_animations_num.put("punch", 12);
  move_animations.put("punch", tempMoveAni);

  pokemons = new ArrayList<Pokemon>();
  for (int i = 0; i < 6; i ++) {
    int pokemonNumber = int(random(1, 808));
    int[] statListPoke = {
      (2*names_stats.get(num_names.get(pokemonNumber))[0] + 31 + int(88/4))*100/100 + 100 + 10, 
      (2*names_stats.get(num_names.get(pokemonNumber))[1] + 31 + int(84/4))*100/100 + 5, 
      (2*names_stats.get(num_names.get(pokemonNumber))[2] + 31 + int(84/4))*100/100 + 5, 
      (2*names_stats.get(num_names.get(pokemonNumber))[3] + 31 + int(84/4))*100/100 + 5, 
      (2*names_stats.get(num_names.get(pokemonNumber))[4] + 31 + int(84/4))*100/100 + 5, 
      (2*names_stats.get(num_names.get(pokemonNumber))[5] + 31 + int(84/4))*100/100 + 5
    };
    String[] movelistPoke = new String[4];
    String[][] l_possible_moves = names_moves.get(num_names.get(pokemonNumber));
    // generate ranbo moves

    Set<String> l_possible_moves_condensed = new HashSet<String>();
    for (int k=0; k<l_possible_moves.length; k++) {
      for (int j=0; j<l_possible_moves[k].length; j++) {
        l_possible_moves_condensed.add(l_possible_moves[k][j]);
      }
    }
    l_possible_moves_condensed.remove("error");

    for (int j=0; j<movelistPoke.length && l_possible_moves_condensed.size()>0; j++) {
      int item = int(random(l_possible_moves_condensed.size()));
      int k = 0;
      for (String cur_move : l_possible_moves_condensed)
      {
        if (k == item) {
          movelistPoke[j] = cur_move;
          l_possible_moves_condensed.remove(cur_move);
          break;
        }
        k++;
      }

      //int i_rand_cat_move = int(random(l_possible_moves_condensed.size()));
      //movelistPoke[j] = l_possible_moves_condensed.get(i_rand_cat_move);
    }
    int[] sliderStartingPosition = {width*169/280, width*169/280, width*169/280, width*169/280, width*169/280, width*169/280};
    pokemons.add(new Pokemon(pokemonNumber, boolean(int(random(0, 2))), 100, names_abilities.get(num_names.get(pokemonNumber))[0], statListPoke, movelistPoke, "Male", 0, new int[5], new int[6], sliderStartingPosition));

    /*for (int j = 0; j < movelistPoke.length; j++) {
     moves_data.put(movelistPoke[j], getMoveData(movelistPoke[j]));
     }*/

    String[] filenames = listFileNames(sketchPath()+"/pokeinfo/move");
    for (int j = 0; j < filenames.length; j++) {
      String fn = filenames[j].substring(0, filenames[j].length()-4);
      if (!fn.equals(".DS_S") && !fn.equals("_DS_S")) {
        moves_data.put(fn, getMoveData(fn));
      }
    }
  }
  for (int i = 0; i < male.length; i++) {
    num_male.put(names_num.get(male[i]), male[i]);
  }
  for (int i = 0; i < female.length; i++) {
    num_female.put(names_num.get(female[i]), female[i]);
  }
  for (int i = 0; i < unspecified.length; i++) {
    num_unspecified.put(names_num.get(unspecified[i]), unspecified[i]);
  }
  /*println(names_stats.get("bulbasaur"));
   println(names_types.get("bulbasaur"));
   println(names_species.get("bulbasaur"));
   println(names_height_weight.get("bulbasaur"));
   println(names_abilities.get("bulbasaur"));
   println();
   println(names_moves.get("bulbasaur"));
   println(names_moves.get("bulbasaur")[1]);*/

  init_console();
  init_battle_screen();
}

void draw() {
  //println(mouseX, mouseY);
  //tint(255,0,100);

  if (loading) {
    background(int(random(255)), 255, 255);
    loading = false;
    better_setup();
    return;
  }

  textFont(font_plain);
  textSize(i_plain_font_size);

  recieve_data();

  background(0);
  stroke(0);

  if (i_battle_state == BATTLING) {
    draw_battle();
  } else if (login) {
    login();
  } else if (register) {
    register();
  } else {
    drawStartScreen();
    drawFriendsList();
    if (moveSelectScreen == true) {
      drawPokemonInformationScreen(pokemonSlotNumber, pokemonNumber, gridSize);
    } else if (pokemonSelectScreen == true) {
      drawPokemonSelectionScreen(pokemonChangeNumber);
    } else if (drawSettingScreen) {
      textFont(font_plain_big);
      textSize(i_plain_font_size);
      drawSettingScreen();
      textFont(font_plain);
      textSize(i_plain_font_size);
    }
    if (i_battle_state == SEARCHING) {
      fill(50, 50);
      draw_rect(0, 0, width, height);
      if (random(100)<10) {
        add_searching_text_effect();
      }
    }
  }

  for (int i=0; i<1; i++) {
    if (random(100)<50) {
      String new_text = num_names.get(int(random(1, 808)));
      add_text_effect(new_text, int(random(width)), int(random(height)), TYPE_COLOURS.get(names_types.get(new_text)[0]));
    }
  }

  draw_all_effects();

  draw_console();
}