class Population {
  
  // The active pool of organisms
  ArrayList<Rocket> organisms;
  
  // The collection of dead organisms for evaluation and reproduction
  ArrayList<Rocket> deadOrganisms;
  
  // The mating pool for reproduction to occur
  ArrayList<Rocket> matingPool;
  
  // The new born organisms before they are transferred to organisms to start the process over again.
  // draw() is a continuous function, so active organisms must copied over in one go 
  ArrayList<Rocket> fetuses;
  
  // size and total fitness
  int size;
  //int totalFitness;
  
  // target location
  PVector target;
  
  // Statistics for viewing pleasure
  int generations;
  int frames;
  int frameRecord;
  
  Obstacle obstacle;
  
  Population() {
    size = 100;
    organisms = new ArrayList<Rocket>();
    for (int i = 0; i < size; i++) {
      organisms.add(new Rocket());
    }
    
    deadOrganisms = new ArrayList<Rocket>();
    matingPool = new ArrayList<Rocket>();
    fetuses = new ArrayList<Rocket>();
    
    obstacle = new Obstacle();
    
    target = new PVector(random(width), random(height));
    
    generations = 0;
    frames = 0;
    frameRecord = 100;
  }
  
  float evaluateTotalFitness() {
    // Determine the total fitness to scale fitness relative to a 100 percentile scale
    float totalFitness = 0;
    for (int i = 0; i < deadOrganisms.size(); i++) {
      Rocket rocket = deadOrganisms.get(i);
      rocket.evaluateFitness(target);
      totalFitness += rocket.fitness;
    }
    return totalFitness;
  }
  
  void reproduce() {
    if (frames < frameRecord) frameRecord = frames;
    frames = 0;
    println(frameRecord);
    for (int i = 0; i < deadOrganisms.size(); i++) {
      Rocket rocket = deadOrganisms.get(i);
      
      // Determine how relatively fit an organism is compared to the total population's fitness
      int organismFitness = (int)map(rocket.fitness, 0, evaluateTotalFitness(), 0, 100);
      
      // Copy that organism into the mating pool that many times to improve the likelihood of them being selected for breeding
      for (int j = 0; j < organismFitness; j++) {
        matingPool.add(rocket);
      }
    }
    
    // Produce new children from the mating pool
    for (int i = 0; i < population.size; i++) {
      
      // Select parents
      int a = (int)random(matingPool.size());
      int b = (int)random(matingPool.size());
      
      Rocket parentA = matingPool.get(a);
      Rocket parentB = matingPool.get(b);
      
      Rocket c = new Rocket(parentA, parentB);
      fetuses.add(c);
      
    }
    // Copy over new children to the organisms array and continue living!
    for (int i = 0; i < fetuses.size(); i++) {
      Rocket rocket = fetuses.get(i);
      organisms.add(rocket);
    }
    
    // Dispose of all arrays to make room for the next population
    deadOrganisms.clear();
    matingPool.clear();
    fetuses.clear();
    
    generations++;
  }
  
  void kill(Rocket r) {
    population.deadOrganisms.add(r);
    population.organisms.remove(r);
  }
  
  void reallyKill(Rocket r) {
    population.organisms.remove(r);
  }
  
  void killAll(ArrayList<Rocket> r) {
    for (int i = 0; i < r.size(); i++) {
      Rocket rocket = r.get(i);
      rocket.isAlive = false;
      kill(rocket);
    }
    r.clear();
  }
  
}

class DNA {
  int lifespan;
  PVector[] forces;
  float mutationRate;
  
  float maxForce = 0.1;
  
  DNA() {
    lifespan = 100;
    mutationRate = 0.02;
    forces = new PVector[lifespan];
    for (int i = 0; i < forces.length; i++) {
     forces[i] = new PVector(random(-1, 1), random(-1, 1));
     forces[i].normalize();
    }
  }
}

class Rocket {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  DNA genes;
  int index;
  
  float fitness;
  
  boolean isAlive;
  
  Rocket() {
    genes = new DNA();
    location = new PVector(width/2, height);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    index = 0;
    isAlive = true;
  }
  
  Rocket(Rocket a, Rocket b) {
    genes = new DNA();
    
    // Select a cross over point, and copy the first parents genes up to that point, and the second parents genes past that point
    int crossoverIndex = (int)random(0, genes.forces.length);
    for (int i = 0; i < genes.forces.length; i++) {
      if (i > crossoverIndex) {
        // Remember to mutate accordingly for each case
        if (random(0, 1) > genes.mutationRate) {
          genes.forces[i] = a.genes.forces[i];
        } else {
          genes.forces[i] = new PVector(random(-1, 1), random(-1, 1));
        }
      } else {
        if (random(0, 1) > genes.mutationRate) {
          genes.forces[i] = b.genes.forces[i];
        } else {
          genes.forces[i] = new PVector(random(-1, 1), random(-1, 1));
        }
      }
    }
    
    location = new PVector(width/2, height);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    index = 0;
    isAlive = true;
  }
  
  void update() {
    // Apply the next force in the index of genes if the organism is still alive
    index++;
    if (index < genes.lifespan) {
      applyForce(genes.forces[index]);
      velocity.add(acceleration);
      location.add(velocity);
      acceleration.mult(0);
      display();
    } else {
      isAlive = false;
    }
  }
  
  void display() {
    fill(0);
    rect(location.x, location.y, 16, 16);
  }
  
  void applyForce(PVector f) {
    acceleration.add(f);
  }
  
  void evaluateFitness(PVector target) {
    fitness = pow(1/PVector.dist(location, target), 2);
  }
}

class Obstacle {
  PVector location;
  PVector widthAndHeight;
  Obstacle() {
    location = new PVector (width/2, height/2);
    widthAndHeight = new PVector(width/2, height/16);
  }
  
  boolean contains(PVector coordinates) {
    if (coordinates.x > location.x - widthAndHeight.x/2 && coordinates.x < location.x + widthAndHeight.x/2 && coordinates.y > location.y - widthAndHeight.y/2 && coordinates.y < location.y + widthAndHeight.y/2) {
      return true;
    } else {
      return false;
    }
  }
  
  void display() {
    noStroke();
    fill(127);
    rectMode(CENTER);
    rect(location.x, location.y, widthAndHeight.x, widthAndHeight.y);
  }
  
}

// Set up the population
Population population;

// Set target endpoint
PVector target;

// Font for drawing board
PFont font;

void setup() {
  size(displayWidth, displayHeight);
  background(255);
  
  population = new Population();
  
  font = loadFont("HelveticaNeue-48.vlw");
}

void draw() {
  background(255);
  
  fill(0);
  ellipse(population.target.x, population.target.y, 8, 8);
  
  population.obstacle.display();
  
  drawBoard();
  
  // If there are still rockets alive, update them
  if (population.organisms.size() > 0) {
    for (int i = 0; i < population.organisms.size(); i++) {
      Rocket rocket = population.organisms.get(i);
      // Update is the rocket is alive
      if (rocket.isAlive) {
           rocket.update();
           
           // If it collides with the obstacle, remove it from play and don't give it a chance to reproduce
           if (population.obstacle.contains(rocket.location)) {
             population.reallyKill(rocket);
           }
           
           // Otherwise, evaluate it's fitness.
           else {
              rocket.evaluateFitness(population.target);
              
             // Check if it's within the target distance, and if so, destroy all organisms and reproduce immediately to speed up evolution.
             if (PVector.dist(rocket.location, population.target) < 10) {
               rocket.isAlive = false;
               population.killAll(population.organisms);
             }
           }
        }
     else {
       
       // Otherwise, if all have died naturally, evaluate rockets fitness, move to mating pool and then wait until everyone is dead to create a new population
       rocket.evaluateFitness(population.target);
       population.kill(rocket);
      }
    }
  } else {
    population.reproduce();
  }
  
  // Increment the frames for visual statistics
  population.frames++;
}

void drawBoard() {
  fill(0);
  textFont(font, 14);
  
  // Generation #
  textAlign(LEFT);
  text("Generation #: " + population.generations, 20, 24);
  text("Quickest Completion in Frames: " + population.frameRecord, 20, 48);
  text("Current Alive Organisms: " + population.organisms.size(), 20, 72);
}

void keyPressed() {
  population = new Population();
}