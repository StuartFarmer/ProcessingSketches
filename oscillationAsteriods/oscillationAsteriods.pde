class RocketShip {
  
  float heading = 0;
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  boolean isThrusting;
  
  RocketShip() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.limit(7);
    velocity.mult(0.99);
    location.add(velocity);
   
    acceleration.mult(0);
  }
  
  void display() {
    pushMatrix();
      translate(location.x, location.y);
      noStroke();
      if (isThrusting == true) fill(127, 0, 0);
      else fill(0);
      rotate(heading);
      beginShape();
        vertex(-10,10);
        vertex(0,-10);
        vertex(10,10);
      endShape(CLOSE);
    popMatrix();
    isThrusting = false;
  }
  
  void checkEdges() {
    if (location.x > width) location.x = 0;
    else if (location.x < 0) location.x = width;
    
    if (location.y > height) location.y = 0;
    else if (location.y < 0) location.y = height;
  }
  
  void thrust() {
    float angle = heading - PI/2;
    PVector thrust = new PVector(cos(angle), sin(angle));
    isThrusting = true;
    applyForce(thrust);
  }
  
  void reverseThrust() {
    float angle = heading - PI/2;
    PVector thrust = new PVector(cos(angle), sin(angle));
    thrust.mult(-1);
    isThrusting = true;
    applyForce(thrust);
  }
  
  void applyForce(PVector f) {
    PVector force = f.get();
    acceleration.add(force);
  }

}

RocketShip ship;

void setup() {
  size(500, 500);
  ship = new RocketShip();
}

void draw() {
  background(255);
  ship.update();
  ship.checkEdges();
  ship.display();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      ship.heading -= 0.1;
    }
    else if (keyCode == RIGHT) {
      ship.heading += 0.1;
    }
    else if (keyCode == UP) {
      ship.thrust();
    }
    else if (keyCode == DOWN) {
      ship.reverseThrust();
    }
  }
}