class Population {
  
  DNA[] organisms;
  ArrayList<DNA> matingPool = new ArrayList<DNA>();
  
  Population() {
    organisms = new DNA[100];
  }
  
  void runFitness() {
    for (int i = 0; i < organisms.length; i++) {
      organisms[i].fitness();
    }
  }
  
  void generateMatingPool() {
    for (int i = 0; i < organisms.length; i++) {
      // Rate each organism by fitness
      int n = int(population[i].fitness * 100);
      
      // Then add that number of organism copies to the pool, so that those with higher fitness have a higher chance of being selected
      for (int j = 0; j < n; j++) {
        matingPool.add(population[i]);
      }
    }
  }
  
  void reproduce() {
    // Select two random parents from the mating pools
    int a = int(random(matingPool.size()));
    int b = int(random(matingPool.size()));
    DNA parentA = matingPool.get(a);
    DNA parentB = matingPool.get(b);
    
    
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

class DNA {
  String genes;
  String target;
  float fitness;
  
  DNA() {
    target = "To be or not to be";
    genes = randomString(target.length());
  }
  
  void fitness() {
    int score = 0;
    for (int i = 0; i < genes.length(); i++) {
      if (genes.charAt(i) == target.charAt(i)) {
        score++;
      }
    }
    fitness = (float)score / target.length();
  }
}

DNA[] population = new DNA[100];

void setup() {
  for (int i = 0; i < population.length; i++) {
    population[i] = new DNA();
  }
}

void draw() {
  for (int i = 0; i < population.length; i++) {
    population[i].fitness();
    println(population[i].genes + " - " + population[i].fitness);
  }
}