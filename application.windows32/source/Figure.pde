class Figure {
  int posX;
  int size;
  int posY;
  PImage img;
  int sizeY;
  int sizeX;
  
  Figure(int w, int h, int _sizeY, int _sizeX) {
    img = loadImage(int(random(9)) + ".png");
    posY = int(random(h/2 + _sizeY, h - _sizeY));
    posX = int(random(_sizeX, w - _sizeX));
    sizeY = _sizeY;
    sizeX = _sizeX;
  }

  void display() {
    //fill(255);
    //rect(posX, posY, 40, 40);
    
    //println(posX);
    //println(posY);
    
    image(img, posX, posY, sizeX, sizeY);
  }
}
