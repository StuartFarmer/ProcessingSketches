int screenWidth = 480;
int screenHeight = 480;

ArrayList<Rectangle> rectangles = new ArrayList<Rectangle>();

void setup() {
  size(screenWidth, screenHeight);
  colorMode(HSB, 100, 100, 100, 100);
  background(0);
}

void draw() {
  fill(0);
  noStroke();
  rect(0, 0, screenWidth, screenHeight);
  
  for (Rectangle r : rectangles) {
    r.fade();
    r.display(); 
  }
}

void mousePressed() {
  rectangles.add(new Rectangle());
  println(rectangles.size());
}

class Rectangle {
  // Dimensions
  int bodyWidth;
  int bodyHeight;
  
  // Positioning
  int xPos;
  int yPos;
  
  // Color components
  int hue;
  int saturation;
  int brightness;
  int alpha;
  
  Rectangle() {
    bodyWidth = int(random(250));
    bodyHeight = bodyWidth;
    
    xPos = int(random(screenWidth));
    yPos = int(random(screenHeight));
    
    hue = int(random(100));
    saturation = 100;
    brightness = 100;
    alpha = 100;
  }
  
  void fade() {
    alpha--;
  }
  
  void display() {
    fill(hue, saturation, brightness, alpha);
    rect(xPos, yPos, bodyWidth, bodyHeight);
  }
}
