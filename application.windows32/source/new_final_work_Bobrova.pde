import ddf.minim.*;
Minim minim;
AudioPlayer mp3;

//images
PImage bc;
PImage hide; //this makes the effect of light
ArrayList <Figure> fig = new ArrayList();
ArrayList <Congrats> congrats = new ArrayList();
PImage retry;

//sizes
int figSizeY = 50;
int figSizeX = 50;
int pad = 40;

//logic values
int counter = 1;
int hardness = 0;
boolean play;
int lost;


void settings() {
  bc = loadImage("0.jpg"); //background image could be randomly uploaded in a future
  size(bc.width, bc.height*2+2*pad);
  hide = loadImage("hide.png");
  retry = loadImage("retry.png");
  int buffer = 1024;
  minim=new Minim(this);
  mp3=minim.loadFile("applause.mp3", buffer);
}

void setup() {
  //INTRO
  rectMode(CENTER);
  background(0);
  noStroke();
  textSize(pad/2);
  textAlign(CENTER);
  fill(255, 0, 255);
  rect(width/2, height/3*2, 100, 40);
  fill(255);
  text("You have to find all the diferences", width/2, height/3);
  text("between 2 pictures.", width/2, height/3+pad);
  text("Choose the level:", width/2, height/3+2*pad);
  textSize(30);
  text("Play!", width/2, height/3*2+10);
  image(retry, width-pad, pad/2.5, pad/3, pad/3);

  //LEVELS
  fill(150, 255, 200);
  rect(pad*4, height/2, 50, 30);
  fill(255, 255, 150);
  rect(width/2, height/2, 50, 30);
  fill(255, 150, 150);
  rect((width - 4*pad), height/2, 50, 30);
  fill(255, 0, 255);
}

void draw() {
  //HARDNESS
  if (hardness <= 0) {
    if (mousePressed && pow(pad * 4 - mouseX, 2) + pow(height/2 - mouseY, 2) < 50 * 30) {
      hardness = 2;
      rect(pad*4, height/2, 50, 30);
    } else if (mousePressed && pow(width/2 - mouseX, 2) + pow(height/2 - mouseY, 2) < 50 * 30) {
      hardness = 5;
      rect(width/2, height/2, 50, 30);
    } else if (mousePressed && pow((width - 4*pad) - mouseX, 2) + pow(height/2 - mouseY, 2) < 50 * 30) {
      hardness = 7;
      rect((width - 4*pad), height/2, 50, 30);
    } 

    for (int i = 0; i < hardness; i++) {
      fig.add(new Figure(width, height, figSizeY, figSizeX));
    }
    for (int i =0; i < hardness*10; i++) {
      congrats.add(new Congrats(new PVector(int(random(-5, width)), height+50)));
    }
  }

  if (hardness > 0 && mousePressed && pow(width/2 - mouseX, 2) + pow(height/3*2 - mouseY, 2) < 100 * 40) {
    play = true;
  }

  if (play) {
    for (int i = 0; i < fig.size(); i++) {
      if (mousePressed && pow(fig.get(i).posX - mouseX, 2) + pow(fig.get(i).posY - mouseY, 2) <= figSizeY * figSizeX && fig.size() == 1) {
        fig.remove(i);
        counter+=10;
      } else if (mousePressed && pow(fig.get(i).posX - mouseX, 2) + pow(fig.get(i).posY - mouseY, 2) <= figSizeY * figSizeX) {
        delay(100);
        fig.remove(i);
        counter+=11;
      }
    }
    
    //LOSING
    if(lost == 10) {
       clear();
      background(50, 0, 50);
      fill(255);
      textSize(20);
      textAlign(CENTER, CENTER);
      text("You lost! Your score is " + counter + "!", width/2, height/2);
      fill(255);
      rect(width/2, height/1.5, pad*3, pad);
      fill(0);
      text("Play Again!", width/2, height/1.5);
      if (mousePressed && pow(width/2 - mouseX, 2) + pow(height/1.5 - mouseY, 2) <= pad*3*pad) {
        lost = 0;
        counter = 1;
        hardness = 0;
        mp3.pause();
        mp3.rewind();
        play = false;
        setup();
      }
    }else if (fig.size() == 0) {
      clear();
      background(50, 0, 50);
      for (int i = 0; i < congrats.size(); i++) {
        congrats.get(i).move();
        congrats.get(i).display();
      }
      fill(255);
      textSize(20);
      textAlign(CENTER, CENTER);
      text("You found them all! Your score is " + counter + "!", width/2, height/2);
      fill(255);
      rect(width/2, height/1.5, pad*3, pad);
      fill(0);
      text("Play Again!", width/2, height/1.5);
      mp3.play();
      if (mousePressed && pow(width/2 - mouseX, 2) + pow(height/1.5 - mouseY, 2) <= pad*3*pad) {
        lost = 0;
        counter = 1;
        hardness = 0;
        mp3.pause();
        mp3.rewind();
        play = false;
        setup();
      }
    } else {
      imageMode(CENTER);
      image(bc, width/2, (bc.height)*3/2+2*pad); //displays pic with differences
      for (int i = 0; i < fig.size(); i++) {
        fig.get(i).display(); //displays differences
      }
      image(bc, width/2, (bc.height+pad)/2+pad/4); //displays normal pic
      if (hardness >= 3) {
        image(hide, mouseX, mouseY, hide.width/2, hide.height/2);
      } else if (hardness >=5) {
        image(hide, mouseX, mouseY, hide.width/3, hide.height/3);
      } else {
        image(hide, mouseX, mouseY);
      }
      fill(0);
      rect(width/2, height/2+pad/2, width, pad);


      //HEADER
      fill(0);
      rect(width/2, 0, width, pad);
      fill(255);
      textSize(pad/3);
      textAlign(LEFT);
      text("There are " + hardness + " in total. Your score: " + counter, pad, pad/2);
      image(retry, width-pad, pad/2.5, pad/3, pad/3);
    }
  }
}

void mouseReleased() {
  for (int i = 0; i < fig.size(); i++) {
    if (play == true && pow(fig.get(i).posX - mouseX, 2) + pow(fig.get(i).posY - mouseY, 2) > figSizeY * figSizeX) {
      counter-= 1;
      lost+=1;
      break;
    }
  }
  if (hardness >0 && pow(width-pad - mouseX, 2) + pow(pad/2.5 - mouseY, 2) <= (pad/3) * (pad/3)) {
    lost = 0;
    counter = 1;
    hardness = 0;
    mp3.pause();
    mp3.rewind();
    play = false;
    setup();
  }
}
