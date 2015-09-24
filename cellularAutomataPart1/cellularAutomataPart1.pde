class CA {
  int[] cells;
  int[] ruleset = {0, 1, 0, 1, 1, 0, 1, 0};
  int w;
  int generation = 0;
  CA() {
    w = 5;
    cells = new int[width/2];
    
    for (int i = 0; i < cells.length; i++) {
      cells[i] = 0;
    }
    
    cells[cells.length/2] = 1;
    cells[0] = 1;
  }
  
  void generate() {
    
    int[] nextgen = new int[cells.length];
    for (int i = 1; i < cells.length-1; i++) {
      int left = cells[i-1];
      int middle = cells[i];
      int right = cells[i];
      nextgen[i] = rules(left, middle, right);
    }
    cells = nextgen;
    generation++;
    if (generation*w > height) generation = 0;
  }
  
  void display() {
    for (int i = 0; i < cells.length; i++) {
      if (cells[i] == 1) fill(0);
      else fill(255);
      rect(i*w, generation*w, w, w);
    }
  }
  
  int rules(int x, int y, int z) {
    
         if (x == 1 && y == 1 && z == 1) return ruleset[0];
    else if (x == 1 && y == 1 && z == 0) return ruleset[1];
    else if (x == 1 && y == 0 && z == 1) return ruleset[2];
    else if (x == 1 && y == 0 && z == 0) return ruleset[3];
    else if (x == 0 && y == 1 && z == 1) return ruleset[4];
    else if (x == 0 && y == 1 && z == 0) return ruleset[5];
    else if (x == 0 && y == 0 && z == 1) return ruleset[6];
    else if (x == 0 && y == 0 && z == 0) return ruleset[7];
    
    return 0;
  }
}
CA c;
void setup() {
  size(600, 500);
  c = new CA();
  background(255);
}

void draw() {
  //background(255);
  c.generate();
  c.display();
}

void mousePressed() {
  int i = (mouseX/width)/c.w;
  c.cells[i] = 1;
}