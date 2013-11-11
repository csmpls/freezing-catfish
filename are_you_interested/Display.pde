

class Display {
	//stimulus timing
	float stimulus_end = 0;  
	float current_display_length; //how long current slide should be shown for
	float rest_end;
	
	//colors
	int color_num = 0;
	int num_colors = 4;


	// dark default
	color background_color = color(48,16,45);
	color text_color = color(244,223,241);
	color secondary_text_color = color(53,159,120);

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
}