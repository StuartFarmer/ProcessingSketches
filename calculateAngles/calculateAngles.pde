class Angle {
  PVector center;
  PVector direction;
  PVector arm;
  
  Angle() {
    center = new PVector(width/2, height/2);
    direction = new PVector(1, 0);
    direction.mult(100);
    arm = new PVector(0, 0);
  }
  
  void display() {
    pushMatrix();
      stroke(0);
      strokeWeight(1);
      translate(center.x, center.y);
      line(0, 0, direction.x, direction.y);
      line(0, 0, arm.x, arm.y);
    popMatrix();
  }
  
  void update() {
    PVector mouse = new PVector(mouseX, mouseY);
    arm = PVector.sub(mouse, center);
    arm.normalize();
    arm.mult(100);
    
    float theta = PVector.angleBetween(arm, direction);
    theta = degrees(theta);
    println("theta: " + theta);
  }
}

Angle a;

void setup() {
  size(500, 500);
  background(255);

  a = new Angle();
}

void draw() {
  background(255);
  a.update();
  a.display();
}