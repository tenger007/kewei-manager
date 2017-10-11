package kewei.manager.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.List;

import org.junit.Test;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import kewei.manager.bean.Article_Downloader;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import net.sf.json.util.JavaIdentifierTransformer;

public class DownloaderUtil {

	public static void main(String[] args) throws UnsupportedEncodingException {
		/*d;*/
		Calendar c = Calendar.getInstance();//可以对每个时间域单独修改
		int year = c.get(Calendar.YEAR)-10; 
		int month = c.get(Calendar.MONTH)+1; 
		int date = c.get(Calendar.DATE); 
		int hour = c.get(Calendar.HOUR_OF_DAY); 
		int minute = c.get(Calendar.MINUTE); 
		int second = c.get(Calendar.SECOND); 
		//System.out.println(year + "/" + month + "/" + date + " " +hour + ":" +minute + ":" + second);
		String time = year + "/" + month + "/" + date + " " +hour + ":" +minute + ":" + second;
		String string = URLEncoder.encode(time,"utf-8");
		String jsonSize = loadJsonSize("http://zhxinfo.yuncis.com/articles/count?channelids=1070,1180,1242&datefrom="+string);
		System.out.println(jsonSize);
		String loadJson = loadJson("http://zhxinfo.yuncis.com/articles/list?channelids=874,1070,1180,1242&datefrom=2017/3/17%209:21:58&page=1&size="+jsonSize);
		//System.out.println(loadJson);
		// String tString = "[{'Id':463783,'Title':'Hanson','Author':null,'PublishedDate':'1504942980000','PublishedDateStr':'2017-09-09','Abstract':'','Keywords':'tr','Content':'要走','Url':'https://www.leiphone.com/news/201709/5iR9LjQqxYMtr4jr.html','SiteName':'雷锋网','Source':'re','ChannelId':1180,'Attachments':[],'Extras':[]}]";
	        JSONArray fromObject = JSONArray.fromObject(loadJson);
	       // JSONObject jsonObj1 = JSONObject.fromObject(tString);
	        JsonConfig config = new JsonConfig();
	        config.setJavaIdentifierTransformer(new JavaIdentifierTransformer() {

	            @Override
	            public String transformToJavaIdentifier(String str) {
	                char[] chars = str.toCharArray();
	                chars[0] = Character.toLowerCase(chars[0]);
	                return new String(chars);
	            }

	        });
	        config.setRootClass(Article_Downloader.class);
	        List list = JSONArray.toList(fromObject, config);
	        List<Article_Downloader> collection = (List<Article_Downloader>) JSONArray.toCollection(fromObject, config);
	        //ICPostJsonBeanVO p2 = (ICPostJsonBeanVO) JSONObject.toBean(jsonObj1, config);
	       System.out.println(list.get(1).toString());
	       // System.out.println("json转化为对象：方法名：" + p2.getFuncName() + ";数量:" + p2.getParamNum() + "值：" + p2.getParamValue());
	}

	@Test
	public void test1(){
		String loadJson = loadJsonSize("http://zhxinfo.yuncis.com/articles/count?channelids=871&datefrom=2010/9/27%209:45:17");
		int i = 0;
		if(!loadJson.equals("[]"))
		{
			 i = Integer.parseInt(loadJson);
		}
		System.out.println(loadJson);
		System.out.println(i);
	}
	
	public static String loadJsonSize(String url){
		 StringBuilder json = new StringBuilder();  
	        try {  
	            URL urlObject = new URL(url);  
	            URLConnection uc = urlObject.openConnection();  
	            BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream(),"UTF-8"));  
	            String inputLine = null;  
	            while ( (inputLine = in.readLine()) != null) {  
	                json.append(inputLine);  
	            }  
	            in.close();  
	        } catch (MalformedURLException e) {  
	            e.printStackTrace();  
	        } catch (IOException e) {  
	            e.printStackTrace();  
	        }  
	        return json.toString(); 
	}
	
	 public static String loadJson (String url) {  
	        StringBuilder json = new StringBuilder();  
	        try {  
	            URL urlObject = new URL(url);  
	            URLConnection uc = urlObject.openConnection();  
	            BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream(),"UTF-8"));  
	            String inputLine = null;  
	            while ( (inputLine = in.readLine()) != null) {  
	                json.append(inputLine);  
	            }  
	            in.close();  
	        } catch (MalformedURLException e) {  
	            e.printStackTrace();  
	        } catch (IOException e) {  
	            e.printStackTrace();  
	        }  
	        return json.toString();  
	    }
	
	/**
	 * 字符串转集合
	 * 
	 * @param json
	 */
	public static <T> List<T> json_to_list(String json, Class<T> t) {

		try {
			json = URLDecoder.decode(json, "utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		JSONArray fromObject4 = JSONArray.fromObject(json);

		List<T> collection = (List<T>) JSONArray.toCollection(fromObject4, t);

		return collection;

	}

	/**
	 * 字符串转集合
	 * 
	 * @param json
	 */
	public static List<Article_Downloader> json_to_list_car(String json) {

		try {
			json = URLDecoder.decode(json, "utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Gson gson = new Gson();

		// 用TypeToken做一个类型定义的工具
		TypeToken<List<Article_Downloader>> typeToken = new TypeToken<List<Article_Downloader>>() {
		};

		List<Article_Downloader> fromJson = (List<Article_Downloader>) gson.fromJson(json, typeToken.getType());

		return fromJson;

	}

	/**
	 * 集合转字符串
	 * 
	 * @param list_car
	 * @return
	 */
	public static <T> String list_to_json(List<T> list_car) {
		// 将list_car换为json字符串
		Gson g = new Gson();
		String json = g.toJson(list_car);
		try {
			json = URLEncoder.encode(json, "utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return json;
	}

}
