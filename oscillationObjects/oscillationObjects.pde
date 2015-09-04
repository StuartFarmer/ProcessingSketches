class Oscillator {
  PVector angle;
  PVector velocity;
  PVector amplitude;
  
  Oscillator() {
    angle = new PVector();
    velocity = new PVector(1, 1);
    amplitude = new PVector(random(width/2), random(height/2));
  }
  
  void oscillate() {
    angle.add(velocity);
  }
  
  void display() {
    float x = sin(angle.x) * amplitude.x;
    float y = sin(angle.y) * amplitude.y;
    
    pushMatrix();
    translate(width/2, height/2);
    stroke(0);
    fill(175);
    line(0,0,x,y);
    ellipse(x, y, 16, 16);
    popMatrix();
  }
}

Oscillator o;
void setup() {
  size(500, 500);
  o = new Oscillator();
}

void draw() {
  fill(255, 25);
  noStroke();
  rect(0, 0, width, height);
  o.oscillate();
  o.display();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      o.velocity.y += 0.1;
    }
    else if (keyCode == DOWN) {
      o.velocity.y -= 0.1;
    }
    else if (keyCode == RIGHT) {
      o.velocity.x += 0.1;
    }
    else if (keyCode == LEFT) {
      o.velocity.x -= 0.1;
    }
    println("\n");
    println("x period: ", o.velocity.x);
    println("y period: ", o.velocity.y);
  }
}