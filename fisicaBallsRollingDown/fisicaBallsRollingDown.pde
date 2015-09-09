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
  
  poly.vertex(width/4, height/4);
  poly.vertex(width/2, height/2);
  poly.vertex(width/2, height/2+10);
  poly.vertex(width/4, height/4+10);
  
  poly.setStatic(true);
  world.add(poly);
  
  poly2 = new FPoly();
  
  poly2.vertex(0.75*width, 0.5*height);
  poly2.vertex(0.75*width, 0.5*height +10);
  poly2.vertex(0.5*width, 0.75*height+10);
  poly2.vertex(0.5*width, 0.75*height);
  
  poly2.setStatic(true);
  world.add(poly2);
  
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
   b.setPosition(170+random(-10, 10), 70+random(-10, 10));
   b.setRestitution(0.6);
   world.add(b);
}