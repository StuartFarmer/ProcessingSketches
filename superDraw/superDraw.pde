int fillColor;
int strokeSize;

// Constants
int maxStroke;
int minStroke;

void clearScreen(){
  noStroke();
  fill(255);
  rect (0, 0, 480, 480);
  fill(0);
  textSize(10);
  text("Controls: A & S: Cycle colors, Q & W: Cycle stroke width, X: Clear Screen, Right-click: Eraser", 4, 392);
}

void setup() {
  size (480, 480);
  println("Type A or S to cycle through colors.");
  println("Type Q or W to cycle through stroke sizes.");
  println("Type X to clear the screen.");
  clearScreen();
  fillColor = 0;
  strokeSize = 8;
}

void draw() {
  
  // Drawing code
  if (mousePressed) {
    if (mouseButton == LEFT) {
    stroke(fillColor);
    strokeWeight(strokeSize);
    line(mouseX, mouseY, pmouseX, pmouseY);
    }
    else {
    stroke(255);
    strokeWeight(strokeSize);
    line(mouseX, mouseY, pmouseX, pmouseY);  
    }
  }
  
  // Selected color box and stroke size visualizations
  noStroke();
  fill(fillColor);
  rect(0, 400, 480, 80);
  
  
  fill(255);
  ellipse (24, 24, 28, 28);
  fill(fillColor);
  ellipse(24, 24, strokeSize, strokeSize);
}

void keyPressed() {
  // Clear screen
  if ((key == 'X') || (key == 'x')) {
    clearScreen();
   }
   
   // Cycle backwards a color
   else if ((key == 'A') || (key == 'a')) {
     if (fillColor > 249) {
       fillColor = 0;
     }
     else {
      fillColor = fillColor + 25;
     }
   }
   
   // Cycle forwards a color
   else if ((key == 'S') || (key == 's')) {
     if (fillColor <= 0) {
       fillColor = 250;
     }
     else {
      fillColor = fillColor - 25;
     }
   }
   
   // Cycle backwards a stroke size
   else if ((key == 'Q') || (key == 'q')) {
     if (strokeSize < 4) {
       strokeSize = 24;
     }
     else {
      strokeSize = strokeSize - 4;
     }
   }
   
   // Cycle forwards a stroke size
   else if ((key == 'W') || (key == 'w')) {
     if (strokeSize >= 24) {
       strokeSize = 2;
     }
     else {
      strokeSize = strokeSize + 4;
     }
   }
}
