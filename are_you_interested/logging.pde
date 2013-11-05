BufferedWriter logger;

void setupLog() {
  
  try {
    // set up html file for reviewing
    File file = new File("log.csv");
    file.createNewFile();
    
    //wipe file contents
    PrintWriter wiper = new PrintWriter(file);
    wiper.print("");
    wiper.close();

    // set up a buffered writer for it
    FileWriter fileWritter = new FileWriter(file,true);
    logger = new BufferedWriter(fileWritter);
  }
  
  catch (Exception e) {
    e.printStackTrace();
  }
}

void updateLog() {
  String[] logline = { getTimestamp(), Float.toString(neurosky.attn), Float.toString(neurosky.med) };
  try {
    logger.write(get_csv_line(logline));
    } catch (Exception e) {
      e.printStackTrace();
    }
}

String get_csv_line(String[] values) {

  String ll = "";

  for (int i = 0; i < values.length; i++) {
    if (i < values.length-1) 
      ll += values[i] + ",";
    else 
      ll += values[i] + "\n";

  } return ll;
}


String getTimestamp() {
  int s = second(); 
  int m = minute(); 
  int h = hour(); 
  return(h + ":" + m + ":" + s);
}