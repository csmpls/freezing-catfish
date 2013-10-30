
  
  int timeout = 5000; //how long in ms before reader auto-advances
  int x = 60;
  int y = 40;
  int tbox_topbar_padding = 10;
  int topbar_height = 50;
 
  
  void drawRedditInterface() {
    int tbox_width = width-x-x-20;
    
    
    
      fill (bar_color);
      textSize(24);
      textAlign(LEFT, CENTER);
      text(reddit.currentArticle.subreddit,
      x, y, tbox_width, topbar_height);
      
      fill(text_color);
      textSize(48);
      textAlign(LEFT, TOP);
      text(reddit.currentArticle.title, 
      x, y+tbox_topbar_padding+topbar_height, tbox_width, height-10);
  }
  
  void checkForTimeout() {
    if (reddit.curr_time+timeout > millis()) { }
      // attn.lvldown();  TIMEOUTS NOT WORKING RN .. QUESTIONABLE IF WE EVEN WANT THIS FEATURE LIKE JUST USE THE KEYBOARD U KNOW
  }
  
  void drawPauseInterface() {
    
    int tbox_width = width-x-x-40;
    
      fill(text_color);
      textSize(48);
      textAlign(LEFT, TOP);
      text("reading an article rn...press any key to continue", 
      x, y+tbox_topbar_padding+topbar_height, tbox_width, height-10);
  }
  






