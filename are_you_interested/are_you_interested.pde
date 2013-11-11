import processing.serial.*;
import mindset.*;

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

float show_stimulus_constant = 50; //ms per character - how long titles will be displayed
float stimulus_display_minimum = 2000; //never show a stimulus for fewer than 2000 ms
float stimulus_display_maximum = 10000; //or more than 10s
float between_stimulus_pause = 1000; //ms
boolean show_stimulus = true;

Reddit reddit;
Neurosky neurosky = new Neurosky();
String com_port = "/dev/tty.MindWave";
Logger log = new Logger(neurosky);
boolean neuroskyOn = false; // a global var that changes to true when we detect the neurosky is on + connected

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
   
   neurosky.initialize(this, com_port, false);

	 
   smooth();
   noStroke();

}
 
void draw() {
    
		
    fill(background_color,122);
    rect(-2,-2,width+2, height+2);
    stroke(text_color);
    
    update_stimulus();
    log.updateLog();
		
    if (show_stimulus) {
      drawRedditInterface();
    } else {
      drawRestInterface();
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



 

void drawRedditInterface() {

  int x = 120;
  int y = 60;
  int tbox_topbar_padding = 10;
  int topbar_height = 50;
  
    int tbox_width = width-x-x-20;
  
  
    fill (secondary_text_color);
    textAlign(LEFT, CENTER);
    textFont(second_font,24);
    text(reddit.currentArticle.subreddit,
    x, y, tbox_width, topbar_height);
    
    fill(text_color);
    textAlign(LEFT, TOP);
    textFont(font,68);
    text(reddit.currentArticle.title, 
    x, y+tbox_topbar_padding+topbar_height, tbox_width, height-10);
}

void drawRestInterface() {
}








