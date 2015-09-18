class VisionBall {
  PVector size;
  
  PVector location;
  PVector velocity;
  
  PVector mouseVector;
  
  VisionBall() {
    size = new PVector(12, 12);
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, -1);
    velocity.mult(100);
    mouseVector = new PVector();
  }
  
  void display() {
    ellipse(location.x, location.y, size.x, size.y);
    line(location.x, location.y, location.x+velocity.x, location.y+velocity.y);
    line(location.x, location.y, mouseVector.x+location.x, mouseVector.y+location.y);
  }
  
  void update() {
    // Find the mouse vector relative to the object
    PVector mouse = new PVector(mouseX, mouseY);
    mouseVector = PVector.sub(mouse, location);
    
    // find the degrees between the two vectors
    float theta = PVector.angleBetween(mouseVector, velocity);
    theta = degrees(theta);
    println("theta: " + theta);
    
    // adjust stroke according to whether or not the vector is within the sight of the ball
    if (abs(theta) < 45) {
      stroke(50, 255, 50);
      fill(50, 255, 50);
    }
    else {
      stroke(255, 50, 50);
      fill(255, 50, 50);
    }
    
    // rotate theta
    float r = sqrt(pow(velocity.x, 2) + pow(velocity.y, 2));
    float t = atan(velocity.y / velocity.x);
    
    t += 0.01;
    
    velocity.y = r * sin(t);
    velocity.x = r * cos(t);
    
  }
  
}

VisionBall vb;

void setup() {
  size(500, 500);
  background(127);
  vb = new VisionBall();
}

void draw() {
  background(127);
  vb.update();
  vb.display();
}