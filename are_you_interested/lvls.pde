void quit() {
 

  for (int i = 0; i < reddit.articles.size()-1;i++) {

    Article a = (Article)reddit.articles.get(i);

    
    // open all interesting articles
    if (a.isCool)
      open((String)a.url);
    



    // TODO: add this article to an html-based 'dossier'
  }

  // TODO: launch the browser

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


//==============ui vars
//color background_color = color(12,12,12);
//color slider_bg_color = color(31,30,30);
//color text_color = color(226, 227, 223);
//color text_color_win = color(200, 255, 200);
//color text_color_lose = color(227, 56, 49);
//color bar_color = color(202, 242, 0);

