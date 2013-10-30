String getLeadingHTML() {
	return "<!doctype HTML>\n" +
	"<body>\n" +
	"<form name='reviewform' action='' method='POST'>\n";
}

String articleToHTML(Article a, int index) {
	return "<input type='checkbox' name='" + index + "' value='" + a.title + "'>" + a.title + "<br>";
}

String getTrailingHTML() {
	return "</body>\n" + 
	"</html>";
}
