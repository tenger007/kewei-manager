package kewei.manager.util;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.poi.ss.formula.functions.Now;

import kewei.manager.bean.User;

public class StringUtil {

	public static boolean isEmpty( String s ) {
		// java中trim方法不能去掉全角空格
		return s == null || s.trim().equals("");
	}
	
	public static boolean isNotEmpty( String s ) {
//		return s != null && !s.trim().equals("");
		return !isEmpty(s);
	}
	public static void main(String[] args) {
		String a =" ";
		System.out.println(a.trim());
	}
}
