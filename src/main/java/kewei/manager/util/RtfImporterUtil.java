package kewei.manager.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.util.Calendar;

import com.mysql.cj.mysqla.io.TracingPacketReader;

public class RtfImporterUtil {
	public static void main(String[] args) throws IOException {
		/*LocalDateTime today = LocalDateTime.now();
		LocalDateTime yesterday = today.minusDays(0);
		System.out.println(yesterday);*/
		Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1);
        System.out.println(cal.getTime());
		String encoding = "UTF-8";
	    File file = new File("C:/Users/Thinkpad/Desktop/factiva历史数据样例.rtf");
	    InputStreamReader read = new InputStreamReader(
	            new FileInputStream(file), encoding);//考虑到编码格式
	    BufferedReader bufferedReader = new BufferedReader(read);
	   while(bufferedReader.readLine()!=null){
		   System.out.println(bufferedReader.readLine());
	   }
	    String convertRTFToHTML = new RTF2HTML().convertRTFToHTML(new File("C:/Users/Thinkpad/Desktop/factiva历史数据样例.rtf"));
	    System.out.println(convertRTFToHTML);
	}
}
