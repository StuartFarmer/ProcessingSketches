
float angle;
Item item;

ArrayList<Square>squares = new ArrayList<Square>();
void setup() {
  size(512, 512);
  for (int i = 1; i <= 4; i++) {
     squares.add(new Square(64,i*0.125*PI));
  }
  item = new Item(width/2, height/2, 32);
}

void draw() {
  background(0);
  for (Square s : squares) {
    s.update(); 
  }
  item.update();
}

class Square {
  int xPos;
  int yPos;
  int size;
  float angle;
  
  color strokeColor;
  
  Square(int squareSize, float angleOffset) {
    angle = angleOffset+(PI/100);
    size = squareSize;
    strokeColor = 255;
  }
  
  void update() {
    pushMatrix();
    translate(mouseX, mouseY);
    rotate(angle);
    
    stroke(strokeColor);
    noFill();
    strokeWeight(1);
    rect(-size/2,-size/2,size,size);
  
    angle += PI/100;
    popMatrix();
  }
}

class Item {
  int centerX;
  int centerY;
  int size;
  
  boolean engaged;
  
  Item(int x, int y, int s) {
    centerX = x;
    centerY = y;
    size = s;
    rect(centerX, centerY, size, size);
  }
  
  void update() {
    noFill();
    stroke(255);
    if (mousePressed) {
      println(abs(sqrt(pow(centerX-mouseX,2)+pow(centerY-mouseY,2))) || engaged);
      if(abs(sqrt(pow(centerX-mouseX,2)+pow(centerY-mouseY,2)))<=24) {
        centerX = mouseX;
        centerY = mouseY;
        engaged = true;
      } 
    } else engaged = false;
    rect(centerX-(size/2), centerY-(size/2), size, size); 
  }
}

