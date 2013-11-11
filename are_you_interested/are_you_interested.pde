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



void quit() {
  
  try {
    // set up html file for reviewing
    File file = new File("review.html");
    file.createNewFile();
    
    //wipe file contents
    PrintWriter wiper = new PrintWriter(file);
    wiper.print("");
    wiper.close();

    // set up a buffered writer for it
    FileWriter fileWritter = new FileWriter(file,true);
    BufferedWriter bufferedWriter = new BufferedWriter(fileWritter);
    
    //start the HTML file off
    bufferedWriter.write(getLeadingHTML());
    
    for (int i = 0; i < reddit.articles.size()-1;i++) {
  
      Article a = (Article)reddit.articles.get(i);
      bufferedWriter.write(articleToHTML(a,i));
      
    }
    
    //finish html
    bufferedWriter.write(getTrailingHTML());
    bufferedWriter.close();
    
    // launch a browser page with the html
    open("review.html");
  }
  
  catch (Exception e) {
    e.printStackTrace();
  }

  exit();
}





//colors
int color_num = 0;
int num_colors = 4;


// dark default
color background_color = color(48,16,45);
color text_color = color(244,223,241);
color secondary_text_color = color(53,159,120);


void change_colors() {

  color_num++;
  if (color_num > num_colors) {
    color_num=0; }
    
    //dark default
    if (color_num == 0) {
     background_color = color(48,16,45);
      text_color = color(244,223,241);
      secondary_text_color = color(53,159,120);
    }

  if (color_num == 1) {

     // pinky
     background_color = color(157,68,52);
     text_color = color(226,179,168);
     secondary_text_color = color(82,24,24);
  }

  if (color_num == 2) {
    // light blue
    background_color = color(26, 43, 79);
    text_color = color(216, 224, 242);
    secondary_text_color = color(61, 184, 98);
  }

  if (color_num == 3) {
    // vintage yellow/white-on-blue
    background_color = color(54, 41, 124);
    text_color = color(236, 228, 246);
    secondary_text_color = color(255, 255, 0);
  }
  
  if (color_num == 4) {
    // aquamarine
    background_color = color(53, 160, 144);
    text_color = color(22, 67, 54);
    secondary_text_color = color(200,234,236);
  }
  
  if (color_num == 5) {
    // autumnal king
    background_color = color(29,88,44);
    text_color = color(191,178,64);
    secondary_text_color = color(210,198,197);
  }

}


//stimulus timing
float stimulus_end = 0;  
float current_display_length; //how long current slide should be shown for
float rest_end;

void update_stimulus() {
  
  if (show_stimulus) {
    if (millis() > stimulus_end) {
      
      reddit.advance();
      
      // set the length for which this should be displayed
      current_display_length = show_stimulus_constant*reddit.currentArticle.title.length();
      current_display_length = constrain(current_display_length, stimulus_display_minimum, stimulus_display_maximum);
      
      // set this stimulus's end time
      stimulus_end = millis() + current_display_length;
      
      // set the end of the rest period
      rest_end = millis() + between_stimulus_pause;
      
      // now hide the stimulus - its time for the rest period
      show_stimulus = false;
    }
  }
  
  else if (!show_stimulus) {
    if (millis() > rest_end) {
      
      // show the next stimulus
      show_stimulus = true;    
    }
  }
}
    
    





