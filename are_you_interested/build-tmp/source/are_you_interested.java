import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 
import mindset.*; 
import java.util.Date; 
import java.io.File; 
import java.io.PrintWriter; 
import java.io.FileWriter; 
import java.io.BufferedWriter; 
import java.io.FileNotFoundException; 

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
Neurosky neurosky = new Neurosky();
String com_port = "/dev/tty.MindWave";
Logger log = new Logger(neurosky);
Display display;

String session_id;

public void setup() {
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
 
public void draw() {
    fill(display.background_color,122);
    rect(-2,-2,width+2, height+2);
    stroke(display.text_color);

    neurosky.update();
    
    display.update_stimulus();
    log.updateLog(display.getStimulusIndex(), display.getStimulusName());
   
}

public void keyPressed() {
  
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

public boolean sketchFullScreen() {
  return true;
}

public void set_session_id() {
     // get a unix timestamp
  Date d = new Date();
  session_id = String.valueOf(d.getTime()/1000);
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



class Display {
	
	public int stimulusCount = 0;

	boolean show_splashscreen = true;
	
	float show_stimulus_constant = 50; //ms per character - how long titles will be displayed
	float stimulus_display_minimum = 2000; //never show a stimulus for fewer than 2000 ms
	float stimulus_display_maximum = 10000; //or more than 10s
	float between_stimulus_pause = 1000; //ms
	boolean show_stimulus = true;
	
	//stimulus timing
	float stimulus_end = 0;  
	float current_display_length; //how long current slide should be shown for
	float rest_end;
	
	//colors
	int color_num = 0;
	int num_colors = 4;


	// dark default
	public int background_color = color(48,16,45);
	public int text_color = color(244,223,241);
	public int secondary_text_color = color(53,159,120);

	Reddit reddit;
	
	PFont font;
	PFont second_font;

	Display() {
		reddit = new Reddit();
		
		current_display_length = reddit.getInitialLength() * show_stimulus_constant;
    // set this stimulus's end time
    stimulus_end = millis() + current_display_length;
    // set the end of the rest period
    rest_end = millis() + between_stimulus_pause;
		
    font =  loadFont("LMSans.vlw");
    second_font = loadFont("Monoxil-Regular-68.vlw");
	}
	
	public Reddit getReddit() {
  	return reddit;
	}
	
	public void advance() {
		reddit.advance();
		stimulusCount++;
	}
	
	public int getStimulusIndex() {
		if(show_stimulus) {
			return stimulusCount;
		}
		else {
			return -1;
		}
	}

        public String getStimulusName() {
               if(show_stimulus) {
                  return reddit.currentArticle.title;
                }
                else {
                  return "";
                }
        }

	public void update_stimulus() {

		/// show an initial splash at first to make sure setup is working
		if (show_splashscreen) {
			drawSplashInterface();			
		}
  		

  		// draw interface in which titles are displayed
  		else {

			if (show_stimulus) {
				if (millis() > stimulus_end) {

				  reddit.advance();
				  stimulusCount++;

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

			if (show_stimulus) {
			drawRedditInterface();
			} else {
			drawRestInterface();
			}

		}
		
	}


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
	
	public void drawRedditInterface() {

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

	public void drawRestInterface() {
	}

	public void drawSplashInterface() {
		int x = 120;
	  int y = 60;
	  int tbox_topbar_padding = 10;
	  int topbar_height = 50;
  
	    int tbox_width = width-x-x-20;


	    fill(text_color);
	    textAlign(LEFT, TOP);
	    textFont(font,68);
	    text(getSplashMessage(), 
	    x, y+tbox_topbar_padding+topbar_height, tbox_width, height-10);

	}

	public String getSplashMessage() {
		String attn = Float.toString(neurosky.attn);
		String med = Float.toString(neurosky.med);
		String message = "Below I'm showing some readings I get from your Neurosky. Give it a few seconds to initialize.\n\nWhen you see plausible values (1-100), press 'k' to start viewing the stimuli.\n\n";
		return message + attn + "    " + med;
	}
}






class Logger {
	Neurosky eeg;
	FileWriter log;

	Logger(Neurosky eeg) {
  
		this.eeg = eeg;


	 	 set_session_id();
		
	  	try {
	            //create a log file in the user's hoem directory
	            String dir = System.getProperty("user.home") + "/interestminer/"; 
				File log_dir = new File(dir);
				//make log directory if it doesn't exist
				if (!log_dir.exists()) {
				  log_dir.mkdirs();
				}

				File file = new File(log_dir + "/" + session_id + "-eeg.csv");
				file.createNewFile();
				log = new FileWriter(file);
			}
			catch (Exception except) {
				println("File not found.");
			}
			
			println("opened new log file!");
	}

	public void updateLog(int stimulusIndex, String stimulusName){
  	String[] logline = { getTimestamp(), Float.toString(eeg.attn), Float.toString(eeg.med), Integer.toString(stimulusIndex), stimulusName  };
  	try {
    	log.write(get_csv_line(logline));
			println(get_csv_line(logline));
			log.flush();
    } catch (Exception e) {
      e.printStackTrace();
    }
	}

	public String get_csv_line(String[] values) {
  	String ll = "";

  	for (int i = 0; i < values.length; i++) {
    	if (i < values.length-1) 
      	ll += values[i] + ",";
    	else 
      	ll += values[i] + "\n";
		} 
		
		return ll;
	}


	public void closeLog() {
		try {
			log.flush();
			log.close();
		} catch (Exception e) {
			println("ERROR: Problem flushing or closing log data.");
		}
	}

	public String getTimestamp() {
  	int s = second(); 
  	int m = minute(); 
  	int h = hour(); 
  	return(h + ":" + m + ":" + s);
	}
} 
public class NeuroMock extends Neurosky {
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
    
  }
	
	public int getInitialLength() {
		// set stimulus display timing for the first article
    // set the length for which this should be displayed
    return currentArticle.title.length();
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


public class HTML {
    
  public String getLeadingHTML() {
  	return "<!doctype HTML>\n" +
          "<head><script src='http://code.jquery.com/jquery-1.9.1.js'></script></head>\n" + 
  	"<body>\n" +
          "<h1>check the articles you were interested in.</h1>" + 
          "<div class = 'squaredOne'>\n" +
  	"<form name='reviewform' action='http://cosmopol.is/interestminer/index.py/' method='POST'>\n" +
    "<input type ='text' name='session-id' value = " + session_id + ">this is your session id - don't change (this will be hidden soon)<p>\n";
  }
  
  public String articleToHTML(Article a, int index) {
  	return "<input type='checkbox' class = 'big-check' name = '" + index + "'>" 
  + (int)(index) + " - " + a.title + "</p>";
  }
  
  public String getTrailingHTML() {
  	return 
          "<input type='submit'></form>\n" +
          "</div>\n" +
          "</body>\n" + 
  	"</html>";
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
  
  float attn;
  float med;
  
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
     
      
        set_attn_pulse();
        set_med_pulse();
      
      
      
      
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
