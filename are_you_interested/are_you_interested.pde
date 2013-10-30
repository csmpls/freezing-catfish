import processing.serial.*;
import controlP5.*;
import ddf.minim.*;

/*
        ////////////////////////////////////////////////
        //////////////// A   R   E /////////////////////
        //////////////// Y   O   U /////////////////////
        /////////////////INTERESTED/////////////////////
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        !!!!!!!!! HAND-ROLLED IN !!!!!!!!!!!!!!!!!!!!!!!
        !!!!!!!!!!!!!!!!!!!!!!!!!THE XANA-KITCHEN!!!!!!!
        !!!!!!! EVANSTON, IL 2013 !!!! !!!!!!!!!!!!!!!!!
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        ////////////////////////////////////////////////
        ////////////////////////////////////////////////
        ////////////////////////////////////////////////
* * */

Reddit reddit;
boolean No;

ControlP5 cP5;
Minim minim;
AudioSample winsound;
AudioSample losesound;


ControlP5 cp5;
PFont font;
PFont second_font;

void setup() {
  size (displayWidth, displayHeight);
  frameRate(24);
  smooth(); 
  stroke(255);
  textLeading(-5);
  frameRate(24);
 
   
   reddit = new Reddit();
   font =  loadFont("LMSans.vlw");
   second_font = loadFont("Monoxil-Regular-68.vlw");
   
   smooth();
   noStroke();
     
    minim = new Minim(this);
    winsound = minim.loadSample("winsound.aiff", 512);
    losesound = minim.loadSample("losesound.aiff", 512);

}

void draw() {
    
    fill(background_color,122);
    rect(-2,-2,width+2, height+2);
    stroke(text_color);
    checkForTimeout();
    
    
    if (!No) {
      drawRedditInterface();
    }
   
}

void keyPressed() {
  
  if (key == 'j') {
    reddit.advance(); 
  }
    
    
  if (key == 'q') {
    quit(); 
  }
  
  if (key =='c') {
    change_colors();
  }
  
}

boolean sketchFullScreen() {
  return true;
}

void stop() {
  winsound.close();
  losesound.close();
  minim.stop();
  super.stop();
}

