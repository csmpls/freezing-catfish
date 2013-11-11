public class HTML {
    
  String getLeadingHTML() {
  	return "<!doctype HTML>\n" +
          "<head><script src='http://code.jquery.com/jquery-1.9.1.js'></script></head>\n" + 
  	"<body>\n" +
          "<h1>check the articles you were interested in.</h1>" + 
          "<div class = 'squaredOne'>\n" +
  	"<form name='reviewform' action='' method='POST'>\n";
  }
  
  String articleToHTML(Article a, int index) {
  	return "<p> <input type='checkbox' class = 'big-check' id = '" + index + "' name='" + a.title + "'>" 
  + (int)(index) + " - " + a.title + "</p>";
  }
  
  String getTrailingHTML() {
  	return "</form><input type='submit'></form>\n" +
          "</div>\n" +
          "<script> $('input[type=submit]').click(function () {var csv = 'data:text/csv;charset=utf-8,'; $('input:checked').each(function () {var id = $(this).attr('id'); var title = $(this).attr('name'); csv += id + ',' + title + '\\n'; }); var encodedUri = encodeURI(csv); window.open(encodedUri); }); </script>\n" + 
          "</body>\n" + 
  	"</html>";
  }  

}
