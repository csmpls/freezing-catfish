import java.io.File;
import java.io.PrintWriter;
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;

class Logger {
	Neurosky eeg;
	FileWriter log;

	Logger(Neurosky eeg) {
  
		this.eeg = eeg;


	 	 set_session_id();
		
	  	try {
	            //create a log file in the user's hoem directory
	            String dir = System.getProperty("user.home") + "/interestminer/"; 
				File log_dir = new File(dir);
				//make log directory if it doesn't exist
				if (!log_dir.exists()) {
				  log_dir.mkdirs();
				}

				File file = new File(log_dir + "/" + session_id + "-eeg.csv");
				file.createNewFile();
				log = new FileWriter(file);
			}
			catch (Exception except) {
				println("File not found.");
			}
			
			println("opened new log file!");
	}

	void updateLog(int stimulusIndex, String stimulusName){
  	String[] logline = { getTimestamp(), Float.toString(eeg.attn), Float.toString(eeg.med), Integer.toString(stimulusIndex), stimulusName  };
  	try {
    	log.write(get_csv_line(logline));
			println(get_csv_line(logline));
			log.flush();
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
		} 
		
		return ll;
	}


	void closeLog() {
		try {
			log.flush();
			log.close();
		} catch (Exception e) {
			println("ERROR: Problem flushing or closing log data.");
		}
	}

	String getTimestamp() {
  	int s = second(); 
  	int m = minute(); 
  	int h = hour(); 
  	return(h + ":" + m + ":" + s);
	}
} 
