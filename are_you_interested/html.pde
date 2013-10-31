String getLeadingHTML() {
	return "<!doctype HTML>\n" +
        "<head><link rel='stylesheet' href='http://people.berkeley.edu/~nick/dump/style.css' type='text/css'></head>\n" +
	"<body>\n" +
        "<h1>check the articles you were interested in.</h1>" + 
        "<div class = 'squaredOne'>\n" +
	"<form name='reviewform' action='' method='POST'>\n";
}

String articleToHTML(Article a, int index) {
	return "<p> <input type='checkbox' class = 'big-check' name='" + index + "'>" 
+ (int)(index+1) + " - " + a.title + "</p>";
}

String getTrailingHTML() {
	return "</form>\n" +
        "</div>\n" +
        "</body>\n" + 
	"</html>";
}
