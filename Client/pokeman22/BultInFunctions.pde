void mousePressed() {
  /*print(mouseX);
   print(" ");
   println(mouseY);*/
  if (START_BUTTON.i_x-START_BUTTON.i_w/2<=mouseX && mouseX<=START_BUTTON.i_x+START_BUTTON.i_w/2 &&
    START_BUTTON.i_y-START_BUTTON.i_h/2<=mouseY && mouseY<=START_BUTTON.i_y+START_BUTTON.i_h/2 && i_battle_state == NOT_READY && !pokemonSelectScreen) {
    send_pokes();
    i_battle_state = SEARCHING;
    println("pressed");
  }
}

void mouseReleased() {
  mousePressValid = true;
}

void mouseClicked() {
}
void mouseWheel(MouseEvent event) {
  if (pokemonSelectScreen == true && moveSelect == false) {
    if (SLIDER.i_y >= height/9 && SLIDER.i_y + SLIDER.i_h <= height) {
      int count = (event.getCount())*5;
      if (count > 0) {
        if (SLIDER.i_y + SLIDER.i_h < height - SELECTSCREENSHIFT_Y) {
          SLIDER.i_y += (event.getCount())*5;
        }
      } else {
        if (SLIDER.i_y > sliderStartY) {
          SLIDER.i_y += (event.getCount())*5;
        }
      }
    }
    if (SLIDER.i_y + SLIDER.i_h > height - SELECTSCREENSHIFT_Y) {
      SLIDER.i_y = height - SLIDER.i_h - SELECTSCREENSHIFT_Y;
    } else if (SLIDER.i_y < height/9 + SELECTSCREENSHIFT_Y) {
      SLIDER.i_y = height/9 + SELECTSCREENSHIFT_Y;
    }
  } else if (moveSelect == true) {
    if (MOVESLIDER.i_y >= SELECTSCREENSHIFT_Y + height/4 + 291 && MOVESLIDER.i_y + MOVESLIDER.i_h <= height) {
      int count = (event.getCount())*5;
      if (count > 0) {
        if (MOVESLIDER.i_y + MOVESLIDER.i_h < height - SELECTSCREENSHIFT_Y) {
          MOVESLIDER.i_y += (event.getCount())*5;
        }
      } else {
        if (MOVESLIDER.i_y > moveSliderStartY) {
          MOVESLIDER.i_y += (event.getCount())*5;
        }
      }
    }
    if (MOVESLIDER.i_y + MOVESLIDER.i_h > height - SELECTSCREENSHIFT_Y) {
      MOVESLIDER.i_y = height - MOVESLIDER.i_h - SELECTSCREENSHIFT_Y;
    } else if (MOVESLIDER.i_y < SELECTSCREENSHIFT_Y + height/4 + 291) {
      MOVESLIDER.i_y = SELECTSCREENSHIFT_Y + height/4 + 291;
    }
  }
}

void keyPressed() {
  //  pokemons = new ArrayList<Pokemon>();
  //  for (int i = 0; i < 6; i ++) {
  //    pokemons.add(new Pokemon(int(random(1, 808)), boolean(int(random(0, 2)))));
  //  }

  if (i_battle_state == BATTLING) {
    if ('1'<=key&&key<='6'&&(i_selection_stage == SELECT_POKE||i_selection_stage == SELECT_POKE_OR_MOVE)) {
      select_poke(int(key-'1'));
      i_selection_stage = AWAITING_SELECTION;
    } else if (KEY_TO_ID.get(key)!=null&&(i_selection_stage == SELECT_MOVE||i_selection_stage == SELECT_POKE_OR_MOVE)) {
      select_move(KEY_TO_ID.get(key));
      i_selection_stage = AWAITING_SELECTION;
    }
  }

  /*if (key=='h') {
   send_hey();
   }
   if (key=='s') {
   send_pokes();
   }*/
  if (key=='`') {
    reconnect();
  }

  if (pokemonSearchBool == true) {
    for (int i = 0; i < 26; i++) {
      if (key == alphabet_lower.charAt(i) || key == alphabet_upper.charAt(i) || key == punctuation.charAt(i%punctuation.length())) {
        if (pokemonSearch == "") {
          pokemonSearch = str(key);
          break;
        } else {
          pokemonSearch += key;
          break;
        }
      }
    }
    if (key == BACKSPACE) {
      if (pokemonSearch.length() > 1) {
        pokemonSearch = pokemonSearch.substring(0, pokemonSearch.length()-1);
      } else if (pokemonSearch.length() > 0) {
        pokemonSearch = pokemonSearch.substring(0, pokemonSearch.length()-1);
        pokemonSearch = "";
      } else {
        pokemonSearch = "";
      }
    }
    SLIDER.i_y = sliderStartY;
    validPokemonSearch = new StringList();
    for (int i = 1; i <= 807; i++) {
      if (pokemonSearch.length() <= num_names.get(i).length()) {
        if (pokemonSearch.equals(num_names.get(i).substring(0, pokemonSearch.length()))) {
          validPokemonSearch.append(num_names.get(i));
        }
      }
    }
  }
}

void keyReleased() {
}