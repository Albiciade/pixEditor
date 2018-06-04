void activation() {
  if (!activation) {
    surface.setSize(500, 500);
    background(51);
    keys = loadStrings("http://isn.alcibiade-desprez.fr/keys.txt");
    if (keys == null) {
      println("Erreur !");
      keys = new String[1];
      keys[0] = "8772868748877286874887728687";
    }
    textSize(20);
    activation = true;
  }
  surface.setSize(500, 500);
  background(51);
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(30);
  text("Activation de pixEditor", width/2, height/8);
  textSize(10);
  fill(150);
  text("Merci de rentrer votre clé d'activation dans la zone de texte ci-dessous.", width/2, height/4);
  text("Vous pouvez demander une clé d'activation à l'adresse suivante :", width/2, height/4+20);
  text("http://isn.alcibiade-desprez.fr/key.html", width/2, height/4+40);
  textSize(20);
  fill(255);
  stroke(0);
  rectMode(CENTER);
  rect(width/2, height/2.5, width/1.5, textAscent() + 20);
  if (bOn) {
    fill(80);
    text("|", width/2 + textWidth(myText)/2 + 3, height/2.5);
  } else {
    fill(255);
    text("|", width/2 + textWidth(myText)/2 + 3, height/2.5);
  }
  if (millis() - 500 > bTime) {
    bTime = millis();
    bOn = !bOn;
  }

  fill(0);
  text(myText, width/2, height/2.5);

  if (ent) {
    if (val) {
      fill(0, 255, 0);
      text("La clé que vous avez entré est valide !\nMerci de quitter cet assistant\net d'exécuter votre programme.", width/2, height/1.5);
      String[] act = {"1"};     
      saveStrings(path, act);
      noLoop();
    } else {
      println(encode(myText));
      fill(255, 0, 0);
      text("Clé invalide !", width/2, height/1.5);
      String[] act = {"0"};     
      saveStrings(path, act);
    }
  }
}

void keyPressed() {
  if (oui == 0) {
    if (keyCode == BACKSPACE) {
      if (myText.length() > 0) {
        ent = false;
        myText = myText.substring(0, myText.length()-1);
      }
    } else if (keyCode == DELETE) {
      ent = false;
      myText = "";
    } else if (keyCode == ENTER) {
      ent = true;
      println(encode(myText));
      for (int i = 0; i < keys.length; i++) {
        if (keys[i].equals(encode(myText))) {
          fill(0, 255, 0);
          val = true;
          break;
        } else {
          fill(255, 0, 0);
          val = false;
        }
      }
    } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT && keyCode != 20 && keyCode != 144 && keyCode != 155) {
      if (width/2 + textWidth(myText) < width/2 + width/1.5 - textWidth("a")) {
        ent = false;
        if (myText.length() <= 13) {
          myText = myText + str(key).toUpperCase();
        }
      }
    }
  }
}

String encode(String input) {
  char[] chars = new char[input.length()];
  String[] hexs = new String[input.length()];
  int[] ints = new int[input.length()];

  int[] eints = new int[input.length()];

  String input_encode = "";

  for (int i = 0; i < chars.length; i++) {
    char c = input.charAt(i);
    chars[i] = c;
    hexs[i] = hex(c);
    ints[i] = unhex(hexs[i]);

    eints[i] = ints[i] + 3;
  }

  for (int a = 0; a < eints.length; a++) {
    input_encode = input_encode + str(eints[a]);
  }

  return input_encode;
}