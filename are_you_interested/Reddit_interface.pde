int timeout = 5000; //how long in ms before reader auto-advances
int x = 120;
int y = 60;
int tbox_topbar_padding = 10;
int topbar_height = 50;
 

void drawRedditInterface() {
  int tbox_width = width-x-x-20;
  
  
  
    fill (secondary_text_color);
    textAlign(LEFT, CENTER);
    textSize(24);//textFont(second_font,24);
    text(reddit.currentArticle.subreddit,
    x, y, tbox_width, topbar_height);
    
    fill(text_color);
    textAlign(LEFT, TOP);
    textSize(52);//textFont(font,52);
    text(reddit.currentArticle.title, 
    x, y+tbox_topbar_padding+topbar_height, tbox_width, height-10);
}








