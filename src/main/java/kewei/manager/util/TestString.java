package kewei.manager.util;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class TestString {
  public static void main(String[] args) throws ParseException, UnsupportedEncodingException {
	  String time = "2017-09-14 11:03:17";
	  String time2="";
		try {
			time2 = URLEncoder.encode(time,"utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	  System.out.println(time2);
}
}
