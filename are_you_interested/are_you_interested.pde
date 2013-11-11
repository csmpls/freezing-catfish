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
Neurosky neurosky = new Neurosky();
String com_port = "/dev/tty.MindWave";
Logger log = new Logger(neurosky);
boolean neuroskyOn = false; // a global var that changes to true when we detect the neurosky is on + connected
Display display;

void setup() {
  size (displayWidth, displayHeight);
  frameRate(24);
  smooth(); 
  stroke(255);
  textLeading(-5);
  frameRate(24);
   
	display = new Display();
  neurosky.initialize(this, com_port, false);

  smooth();
  noStroke();
}
 
void draw() {
    fill(display.background_color,122);
    rect(-2,-2,width+2, height+2);
    stroke(display.text_color);
    
    display.update_stimulus();
    log.updateLog(display.getCurrentStimulus());
   
}

void keyPressed() {
  
  if (key == 'j') {
    display.advance(); 
  }
    
    
  if (key == 'q') {
    quit(); 
  }
  
  if (key =='c') {
    display.change_colors();
  }
  
}

boolean sketchFullScreen() {
  return true;
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
    
    for (int i = 0; i < display.getReddit().articles.size()-1;i++) {
  
      Article a = (Article)display.getReddit().articles.get(i);
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

