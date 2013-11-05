import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.io.File; 
import java.io.FileWriter; 
import java.io.BufferedWriter; 
import processing.serial.*; 
import mindset.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class are_you_interested extends PApplet {







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

PFont font;
PFont second_font;

public void setup() {
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

public void draw() {
    
		
    fill(background_color,122);
    rect(-2,-2,width+2, height+2);
    stroke(text_color);
    
    update_stimulus();
    
    if (show_stimulus) {
      drawRedditInterface(mindset.data.attention);
    } else {
      drawRestInterface();
    }
   
}

public void keyPressed() {
  
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

public boolean sketchFullScreen() {
  return true;
}

public class Reddit {
  
  
  // you need your private home feed json.
  //find this by going to to Preferences > RSS Feeds 
  //then, next to Private Listings > your front page, copy the JSON link.
  JSONObject json;

  int curr_time = 0;

  ArrayList articles = new ArrayList();
  int curr = 0; //current article index
  Article currentArticle; // current title


  Reddit() {
    
    // get the json array the holds the list of articles
    JSONObject feed = loadJSONObject("feed.json");
    feed = feed.getJSONObject("data");
    JSONArray values = feed.getJSONArray("children");
  
    for (int i = 0; i < values.size(); i++) {
      
      // get the payload
      JSONObject article = values.getJSONObject(i); 
      article = article.getJSONObject("data");
  
      //parse the payload
      String title = article.getString("title");
      String url = article.getString("url");
      String subreddit = article.getString("subreddit");
      
      //add the parsed article to our list
      Article a  = new Article(title, url, subreddit);
      articles.add(a);
      
    }
    
    // set the first article
    currentArticle = (Article)articles.get(curr);
    
    // set stimulus display timing for the first article
     // set the length for which this should be displayed
      current_display_length = show_stimulus_constant*currentArticle.title.length();
      // set this stimulus's end time
      stimulus_end = millis() + current_display_length;
      // set the end of the rest period
      rest_end = millis() + between_stimulus_pause;
  }
  
  public int advance() { 
    curr++;

    if (curr > articles.size()-1) {
      quit();
      return 0;
    }
    
    //TODO: timestamped change to a log
    
    //set this as our current article
    currentArticle = (Article)articles.get(curr);
    return 1;
    
  }
  
  public void markCurrentAsCool() {
    Article a = (Article)articles.get(curr);
    a.setCool();
  }

}

public class Article {

  public String title;
  public String url;
  public String img;
  public String subreddit;
  public boolean isCool;
  
  Article (String s, String u, String sr) {
    title = s;
    url = u;
    subreddit = sr;
    isCool = false;
  }

  Article () {
    title = "error!!";
  }
  
  public void setCool() {
    isCool = true;
  }
}



int timeout = 5000; //how long in ms before reader auto-advances
int x = 120;
int y = 60;
int tbox_topbar_padding = 10;
int topbar_height = 50;
 

public void drawRedditInterface(int attention_value) {
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
		text(neurosky.attn_pulse, 0, 0, 50, 50);
}

public void drawRestInterface() {
}

public void checkForTimeout() {
  if (reddit.curr_time+timeout > millis()) { }
    // attn.lvldown();  TIMEOUTS NOT WORKING RN .. QUESTIONABLE IF WE EVEN WANT THIS FEATURE LIKE JUST USE THE KEYBOARD U KNOW
}








public String getLeadingHTML() {
	return "<!doctype HTML>\n" +
        "<head><link rel='stylesheet' href='http://people.berkeley.edu/~nick/dump/style.css' type='text/css'></head>\n" +
	"<body>\n" +
        "<h1>check the articles you were interested in.</h1>" + 
        "<div class = 'squaredOne'>\n" +
	"<form name='reviewform' action='' method='POST'>\n";
}

public String articleToHTML(Article a, int index) {
	return "<p> <input type='checkbox' class = 'big-check' name='" + index + "'>" 
+ (int)(index+1) + " - " + a.title + "</p>";
}

public String getTrailingHTML() {
	return "</form>\n" +
        "</div>\n" +
        "</body>\n" + 
	"</html>";
}
public void quit() {
  
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
int background_color = color(48,16,45);
int text_color = color(244,223,241);
int secondary_text_color = color(53,159,120);


public void change_colors() {

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

public void update_stimulus() {
  
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
    
    
/*
NEUROSKY
yes@cosmopol.is

hand-rolled in los angeles
august 2011

* * * / 

this class stores data from a neurosky mindset. 
it uses those data to calculate some in-house metrics:

float attn,
float med
  0-100 - e-sense attention/meditation score. 
  (these scores are produced by dark magic
  (ML) inside the neurosky API.)
  
float attn_pulse, 
float med_pulse
  0-100 - eased/smoothed version of attn
  and med. ideally, these values guard
  against the spikes we sometimes see
  in the the e-sense readings.
  
*/

public class Neurosky {
  PApplet parent;
  MindSet ns;
  
  String com_port;
  boolean god;
  
  float attn = 50;
  float med = 50;
  
  float attn_pulse;
  float med_pulse;
  
  boolean is_meditating = false;
  boolean is_attentive = false;
  
  boolean has_initialized = false;

   float pulse_easing = .1f; 

  public void initialize(PApplet parent, String com_port, boolean god) {
    this.god = god;
    this.parent = parent;
    this.com_port = com_port;
    ns = new MindSet(parent);
    ns.connect(this.com_port);
  }
  
  public int update() {
    
    try {
        med = ns.data.meditation; 
        attn = ns.data.attention; 
     
      
      if (!has_initialized) {
        if (attn == -1.0f)
          return 1;
        else {
          if (attn < 20)  //hack: signal is overall low at beginning of stream 
            return 1;
            println("okay! i'm on!");
            THUMBS_UP = true;
        }
          has_initialized=true;
      } else {
        set_attn_pulse();
      set_med_pulse();
      }
      
      
      
      
    } catch( ArrayIndexOutOfBoundsException e ) {
        return 1;
      }
     
     return 0;
    }
  
  public void set_attn_pulse() {
    attn_pulse += (attn - attn_pulse) * pulse_easing;
    attn_pulse = constrain(attn_pulse, 0.0f, 100.0f);
  }
  
  public void set_med_pulse() {
    med_pulse += (med - med_pulse) * pulse_easing;
    med_pulse = constrain(med_pulse, 0.0f, 100.0f);
  }

}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "are_you_interested" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
