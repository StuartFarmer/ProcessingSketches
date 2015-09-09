import fisica.*;

FWorld world;
FPoly poly;
FPoly poly2;
ArrayList<FBody> bodies;

void setup() {
  size(500, 500);
  Fisica.init(this);
  world = new FWorld();
  
  // Add ground
  poly = new FPoly();
  
  poly.vertex(0, height);
  for (int x = 0; x <= width; x += 20) {
    float y = height - 25;
    poly.vertex(x, (cos(x)*20)+height-25);
  }
  poly.vertex(width, height);
  
  poly.setStatic(true);
  world.add(poly);
  
  // Init bodies
  bodies = new ArrayList<FBody>();
}

void draw() {
  background(255);
  world.step();
  world.draw();
}

void mousePressed() {
   FCircle b = new FCircle(random(8, 24));
   b.setPosition(mouseX, mouseY);
   b.setRestitution(0.6);
   world.add(b);
}