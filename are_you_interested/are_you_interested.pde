import processing.serial.*;
import mindset.*;
import java.util.Date;

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
Display display;

String session_id;

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

    neurosky.update();
    
    display.update_stimulus();
    log.updateLog(display.getStimulusIndex(), display.getStimulusName());
   
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

  if (key == 'q') {
    quit();
  }

  if (key == 'k') {
    display.show_splashscreen = false;
  }
  
}

boolean sketchFullScreen() {
  return true;
}

void set_session_id() {
     // get a unix timestamp
  Date d = new Date();
  session_id = String.valueOf(d.getTime()/1000);
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
    HTML html = new HTML();
    bufferedWriter.write(html.getLeadingHTML());
    
    for (int i = 0; i < display.getReddit().articles.size()-1;i++) {
  
      Article a = (Article)display.getReddit().articles.get(i);
      bufferedWriter.write(html.articleToHTML(a,i));
      
    }
    
    //finish html
    bufferedWriter.write(html.getTrailingHTML());
    bufferedWriter.close();
    
    // launch a browser page with the html
    open("review.html");
  }
  
  catch (Exception e) {
    e.printStackTrace();
  }

  exit();
}

