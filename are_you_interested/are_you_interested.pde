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

PFont redditFont;

//==============ui vars
color background_color = color(12,12,12);
color slider_bg_color = color(31,30,30);
color text_color = color(226, 227, 223);
color text_color_win = color(200, 255, 200);
color text_color_lose = color(227, 56, 49);
color bar_color = color(202, 242, 0);
ControlP5 cp5;
PFont font;

void setup() {
  size (displayWidth, displayHeight);
  frameRate(24);
  smooth(); 
  stroke(255);
  textLeading(-5);
  frameRate(24);
     
     reddit = new Reddit();
     //redditFont =  loadFont("nobile.vlw");
     
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
    
    //textFont(redditFont);
    
    if (!No) {
      drawRedditInterface();
    }
   
}

void keyPressed() {
  
  if (key == 'j') 
    reddit.advance();
    
  if (key == ENTER || key == RETURN) 
    winsound.trigger(); reddit.markCurrentAsCool(); reddit.advance();
    
  if (key == 'q')
    quit();
  
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

