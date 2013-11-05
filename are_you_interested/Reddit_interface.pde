

int timeout = 5000; //how long in ms before reader auto-advances
int x = 120;
int y = 60;
int tbox_topbar_padding = 10;
int topbar_height = 50;
 

void drawRedditInterface(int attention_value) {
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

void drawRestInterface() {
}








