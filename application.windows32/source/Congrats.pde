class Congrats {
  PVector position = new PVector(0, 0);
  color mycolor;
  float thesize;
  int yspeed = int(random(4, 20));


  Congrats(PVector _pos) {
    position = _pos.copy();
    mycolor = color(random(100, 255), random(100, 255), random(100, 255), 70);
    thesize = random(5, 50);
  }

  void move() {
    position.y-= yspeed;
    if (position.y < 0) {
      position.y = height+(int(random(0, 50)));
    }
  }

  void display() {
    fill(mycolor);
    rect(position.x, position.y, thesize, thesize);
  }
}
