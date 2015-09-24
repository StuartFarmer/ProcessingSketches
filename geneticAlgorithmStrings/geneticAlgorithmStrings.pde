class Organism {
  Organism() {
    
  }
}

class Population {
  ArrayList<Organism> organisms;
  Population() {
    organisms = new ArrayList<Organism>();
  }
}

String randomString(int length) {
  String lowerAlpha = "abcdefghijklmnopqrstuvwxyz";
  String upperAlpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  String fullAlpha = lowerAlpha + upperAlpha;
  
  String generatedString = "";
  for (int i = 0; i < length; i++) {
    generatedString += fullAlpha.charAt(int(random(fullAlpha.length()-1)));
  }
  return generatedString;
}

void setup() {
  println(randomString(25));
}