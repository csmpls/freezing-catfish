String getLeadingHTML() {
	return "<!doctype HTML>\n" +
        "<head><script src='http://code.jquery.com/jquery-1.9.1.js'></script></head>\n" + 
	"<body>\n" +
        "<h1>check the articles you were interested in.  if you didn't see an article, just skip it.</h1>" + 
        "<div class = 'squaredOne'>\n" +
	"<form name='reviewform' action='' method='POST'>\n";
}

String articleToHTML(Article a, int index) {
	return "<p> <input type='checkbox' class = 'big-check' id='" + index + "' name='" + a.title + "'>" 
+ (int)(index) + " - " + a.title + "</p>";
}

String getTrailingHTML() {
	return "<input type='submit'></form>\n" + 
        "</div>\n" +
        "</body>\n" + 
	"</html>";
}  
