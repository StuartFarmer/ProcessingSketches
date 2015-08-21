import fisica.*;

FWorld world;

void setup() {
  Fisica.init(this);
  world = new FWorld();
  size(200, 700); 
  world.setGravity(0,500);
  world.setEdges();
  
  FCircle ball = new FCircle(25);
  ball.setPosition(100, 350);
  ball.setDensity(20);
  ball.setDamping(0.0);
  world.add(ball);
  
  FBlob blob = new FBlob();
  blob.setAsCircle(100, 400, 100);
  blob.setDensity(20);
  blob.setDamping(0.0);
  blob.setRestitution(0.5);
  blob.setFill(map(0, 0, 0, 0, 0));
  blob.setNoStroke();
  world.add(blob);
}

void draw() {
  background(255);
  
  world.step();
  world.draw();
}