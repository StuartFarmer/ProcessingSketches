class Population {
  
  DNA[] organisms;
  ArrayList<DNA> matingPool = new ArrayList<DNA>();
  
  DNA bestOrganism;
  float averageFitness;
  
  int generations;
  
  Population(int size, float mutationRate, String target) {
    organisms = new DNA[size];
    for (int i = 0; i < organisms.length; i++) {
      organisms[i] = new DNA(mutationRate, target);
    }
    bestOrganism = new DNA(mutationRate, target);
    averageFitness = 0;
    generations = 0;
  }
  
  void runFitness() {
    // Run fitness on each organism, sort them, find the fittest organism, and determine the average fitness of the population
    for (int i = 0; i < organisms.length; i++) {
      organisms[i].fitness();
      averageFitness += organisms[i].fitness;
    }
    averageFitness /= organisms.length;
    
    sortOrganismsByFitness(organisms);
    
    bestOrganism = organisms[0];
  }
  
  void generateMatingPool() {
    for (int i = 0; i < organisms.length; i++) {
      // Rate each organism by fitness
      int n = int(organisms[i].fitness * 100);
      
      // Then add that number of organism copies to the pool, so that those with higher fitness have a higher chance of being selected
      for (int j = 0; j < n; j++) {
        matingPool.add(organisms[i]);
      }
    }
  }
  
  void reproduce() {
    // Select two random parents from the mating pools
    for (int i = 0; i < organisms.length; i++) {
      int a = int(random(matingPool.size()));
      int b = int(random(matingPool.size()));
      
      DNA parentA = matingPool.get(a);
      DNA parentB = matingPool.get(b);
      
      DNA child = parentA.crossover(parentB);
      
      child.mutate();
      
      organisms[i] = child;
    }
    generations++;
  }
  
  void sortOrganismsByFitness(DNA[] orgs) {
  boolean flag = true;
  float tempFitness;
  
  while (flag) {
    flag = false;
    for (int i = 0; i < orgs.length-1; i++) {
      if (orgs[i].fitness < orgs[i+1].fitness) {
        tempFitness = orgs[i].fitness;
        orgs[i] = orgs[i+1];
        flag = true;
      }
    }
  }
}
}

class DNA {
  char[] genes;
  String target;
  float fitness;
  float mutationRate;
  
  DNA(float _mutationRate, String _target) {
    target = _target;
    genes = new char[target.length()];
    mutationRate = _mutationRate;
    for (int i = 0; i < genes.length; i++) {
      genes[i] = (char)random(32, 128);
    }
  }
  
  void fitness() {
    int score = 0;
    for (int i = 0; i < genes.length; i++) {
      if (genes[i] == target.charAt(i)) {
        score++;
      }
    }
    fitness = (float)score / target.length();
  }
  
  DNA crossover(DNA partner) {
    DNA child = new DNA(mutationRate, target);
    
    int midpoint = int(random(genes.length));
    
    for (int i = 0; i < genes.length; i++) {
      if (i > midpoint) child.genes[i] = genes[i];
      else child.genes[i] = partner.genes[i];
    }
    
    return child;
  }
  
  void mutate() {
    for (int i = 0; i < genes.length; i++) {
      if (random(1) < mutationRate) {
        genes[i] = (char)random(32, 128);
      }
    }
  }
  
  String phrase() {
    return new String(genes);
  }
  
}

Population population = new Population(1000, 0.02, "Trevor, smokes. Let's go.");
PFont font;
void setup() {
  size(1000, 500);
  background(255);
  font = loadFont("HelveticaNeue-48.vlw");
}

void draw() {
  // evolve the population until optimized
  if(population.bestOrganism.fitness < 1) {
    background(255);
    population.runFitness();
    population.generateMatingPool();
    population.reproduce();
    drawBoard();
    
    // reset new text string to allow for another entry
    newText = "";
  }
}

void drawBoard() {
  fill(0);
  textFont(font, 48);
  
  // Best organism
  textAlign(CENTER);
  text(population.bestOrganism.phrase(), 300, 250);
  
  textFont(font, 24);
  // Best fitness
  textAlign(LEFT);
  text("Avg fit: " + population.averageFitness, 25, 475);
  
  // Average fitness
  text("Best fit: " + population.bestOrganism.fitness, 300, 475);
  
  // Target phrase
  textAlign(CENTER);
  text(population.bestOrganism.target, 300, 25);
  
  text("Gen #:" + population.generations, 300, 50);
  
  // Top 20
  textAlign(LEFT);
  textFont(font, 16);
  for (int i = 0; i < 10; i++) {
    text(population.organisms[i].phrase(), 600, i*50 + 25);
    text(population.organisms[i+10].phrase(), 800, i*50 + 25);
  }
}

String newText = new String();
void keyPressed() {
  if(population.bestOrganism.fitness == 1) {
    // Allow typing of new phrase
    if (keyCode == ENTER) {
      population = new Population(1000, 0.02, newText);
    }
    else if (keyCode == BACKSPACE) {
      if (newText.length() > 0) newText = newText.substring(0, newText.length()-1);
    }
    else {
      // Concatinate the new string (only if it is valid ASCII)
      if (int(key) > 31 && int(key) < 129) {
        newText += key;
      }
    }
    // Display the text above
    // Hacky way to do this...
    background(255);
    population.bestOrganism.target = newText;
    drawBoard();
  }
}