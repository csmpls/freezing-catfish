void quit() {
  
  for (int i = 0; i < reddit.articles.size()-1;i++) {
    
    Article a = (Article)reddit.articles.get(i);
    
    // open all interesting articles
    if (a.isCool)
      open((String)a.title);
    
    // TODO: add this article to an html-based 'dossier'
  }
  
  // TODO: launch the browser
  
  exit();
}
