public class HTML {
    
  String getLeadingHTML() {
  	return "<!doctype HTML>\n" +
          "<head><script src='http://code.jquery.com/jquery-1.9.1.js'></script></head>\n" + 
  	"<body>\n" +
          "<h1>check the articles you were interested in.</h1>" + 
          "<div class = 'squaredOne'>\n" +
  	"<form name='reviewform' action='http://cosmopol.is/interestminer/index.py/' method='POST'>\n";
  }
  
  String articleToHTML(Article a, int index) {
  	return "<p> <input type='checkbox' class = 'big-check' name = '" + index + "'>" 
  + (int)(index) + " - " + a.title + "</p>";
  }
  
  String getTrailingHTML() {
  	return "<input type='submit'></form>\n" +
          "</div>\n" +
          "</body>\n" + 
  	"</html>";
  }  

}
