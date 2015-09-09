import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;
ArrayList<Box> boxes;
ArrayList<Boundary> boundaries;

void setup() {
  size(500, 500);
  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  boundaries.add(new Boundary(0, height-16, 500, 20));
}

void draw() {
  background(255);
  box2d.step();
  for (Box b : boxes) {
    b.display();
  }
  for (Boundary b : boundaries) {
    b.display();
  }
}

void mousePressed() {
  boxes.add(new Box());
}