class Population {
  int size;
  int totalFood;
  ArrayList<Bloop> bloops;
  ArrayList<Food> food;
  Population() {
    size = 50;
    totalFood = 25;
    bloops = new ArrayList<Bloop>();
    food = new ArrayList<Food>();
    for (int i = 0; i < size; i++) {
      bloops.add(new Bloop());
    }
    for (int i = 0; i < totalFood; i++) {
      food.add(new Food());
    }
  }
  
  void update() {
    for (int i = 0; i < size; i++) {
      Bloop bloop = bloops.get(i);
      if (bloop.isDead()) {
        bloops.remove(bloop);
        size--;
      }
      else {
        if (random(1) < 0.005) {
          Bloop child = new Bloop();
          DNA genes = bloop.genes;
          child.genes = genes;
          genes.mutate();
          population.bloops.add(child);
          population.size++;
        }
        bloop.update();
        bloop.eat(food);
        bloop.display();
      }
    }
  }
  
  void display() {
    for (Food f : food) {
      f.display();
    }
  }
}

class Bloop {
  DNA genes;
  int health;
  int index;
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  Bloop() {
    genes = new DNA();
    health = genes.lifespan;
    location = new PVector(random(width), random(height));
    velocity = new PVector();
    acceleration = new PVector();
  }
  
  void update() {
    // adjust for off screen action
    checkEdges();
    // increment the index and apply the next gene force
    index++;
    if (index >= genes.forceGeneLength) index = 0;
    applyForce(genes.forces[index]);
    
    velocity.add(acceleration);
    velocity.limit(5);
    location.add(velocity);
    acceleration.mult(0);
    
    // check to see if bloop reproduced
    //if (random(1) < 0.005) reproduce();
    
    // decrement health
    health--;
  }
  
  void display() {
    noStroke();
    fill(255-map(health, 0, genes.lifespan, 0, 255));
    ellipse(location.x, location.y, 2*genes.radius, 2*genes.radius);
  }
  
  void checkEdges() {
    if (location.x > width) location.x = 0;
    else if (location.x < 0) location.x = width;
    if (location.y > height) location.y = 0;
    else if (location.y < 0) location.y = height;
  }
  
  void reproduce() {
    Bloop child = new Bloop();
    DNA childGenes = genes;
    child.genes = childGenes;
    genes.mutate();
    population.bloops.add(child);
    population.size++;
  }
  
  void eat(ArrayList<Food>food) {
    for (int i = food.size()-1; i >= 0; i--) {
      Food f = food.get(i);
      if (PVector.dist(location, f.location) < genes.radius*2) {
        health += 100;
        if (health > genes.lifespan) health = genes.lifespan;
        food.remove(i);
        food.add(new Food());
      }
    }
  }
  
  boolean isDead() {
    if (health < 0.0) return true;
    else return false;
  }
  
  void applyForce(PVector f) {
    acceleration.add(f);
  }
  
}

class DNA {
  int radius;
  int forceGeneLength;
  int lifespan;
  PVector[] forces;
  float mutationRate;
  
  DNA() {
    radius = (int)random(2, 24);
    lifespan = (int)random(50, 200);
    forceGeneLength = (int)random(12, 200);
    mutationRate = 0.02;
    forces = new PVector[forceGeneLength];
    for (int i = 0; i < forces.length; i++) {
     forces[i] = PVector.random2D();
     forces[i].normalize();
    }
  }
  
  void mutate() {
    // Mutate each of the gene array force values
    for (int i = 0; i < forces.length; i++) {
      if (random(1) < mutationRate) {
        forces[i] = PVector.random2D();
        forces[i].normalize();
      }
    }
    
    // Mutate all values of the other variables
    if (random(1) < mutationRate) radius = (int)random(2, 24);
    if (random(1) < mutationRate) lifespan = (int)random(50, 200);
    //if (random(1) < mutationRate) forceGeneLength = (int)random(12, 200);
  }
}

class Food {
  PVector location;
  
  Food() {
    location = new PVector(random(width), random(height));
  }
  
  void display() {
    fill(0, 255, 0);
    ellipse(location.x, location.y, 4, 4);
  } 
}

Population population;
Bloop b;
void setup() {
  size(displayWidth, displayHeight);
  background(255);
  population = new Population();
  b = new Bloop();
}

void draw() {
  background(255);
  population.update();
  population.display();
}

void keyPressed() {
  if (key == ' ') {
    population.bloops.add(new Bloop());
    population.size++;
  }
}