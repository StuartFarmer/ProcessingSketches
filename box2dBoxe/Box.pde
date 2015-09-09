class Box {
  Body body;
  float x, y;
  float w, h;
  
  Box() {
    w = (int)random(4, 32);
    h = (int)random(4, 32);
    
    BodyDef bodyDef = new BodyDef();
    bodyDef.type = BodyType.DYNAMIC;
    bodyDef.position.set(box2d.coordPixelsToWorld(mouseX, mouseY));
    body = box2d.createBody(bodyDef);
    
    PolygonShape ps = new PolygonShape();
    
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    
    ps.setAsBox(box2dW, box2dH);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.7;
    
    body.createFixture(fd);
  }
  
  void display() {
    fill(175);
    stroke(0);
    rectMode(CENTER);
    Vec2 position = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    pushMatrix();
      translate(position.x, position.y);
      rotate(-a);
      rect(0, 0, w, h);
    popMatrix();
  }
  
  void delete() {
    box2d.destroyBody(body);
  }
}