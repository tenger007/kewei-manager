package kewei.manager.util;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import kewei.manager.bean.Article_Factiva;

public class TxtImporterUtil {
	
	  public static void readTxtFile(String filePath) {
	       try {
	           String encoding = "UTF-8";
	           File file = new File(filePath);
	           if (file.isFile() && file.exists()){ //判断文件是否存在
	               InputStreamReader read = new InputStreamReader(
	                       new FileInputStream(file), encoding);//考虑到编码格式
	               BufferedReader bufferedReader = new BufferedReader(read);
	               String lineTxt = "";
	               String discribe ="";
	               String last="";
	               String intro = "";
	             List<Article_Factiva> article_Factivas =  new ArrayList<Article_Factiva>();
	             Article_Factiva article_Factiva = new Article_Factiva();
	             String readLine = bufferedReader.readLine();   
	               while ((lineTxt = bufferedReader.readLine()) != null) {
	            	   if(lineTxt.length()>=3&&!lineTxt.substring(0).equals("                  ")){
	            		   if(lineTxt.split(" ")[0].equals("HD")||lineTxt.split(" ")[0].equals("BY")
	            			||lineTxt.split(" ")[0].equals("LP")||lineTxt.split(" ")[0].equals("TD")
	            			||lineTxt.split(" ")[0].equals("NS")||lineTxt.split(" ")[0].equals("RE")
	            			||lineTxt.split(" ")[0].equals("SN")||lineTxt.split(" ")[0].equals("PD")
	            			||lineTxt.split(" ")[0].equals("PUB")||lineTxt.split(" ")[0].equals("LA")
	            			||lineTxt.split(" ")[0].equals("提示名称")){
	            	 switch (lineTxt.split(" ")[0])
	                    {
	                        case "HD": //标题
	                           article_Factiva.setTitle(lineTxt.substring(3, lineTxt.length()));
	                            break;

	                        case "BY": //作者
	                        	article_Factiva.setAuthor(lineTxt.split(" ")[1]);
	                            break;

	                        case "LP": //摘要
	                        	break;

	                        case "TD": //全文
	                        	break;

	                        case "NS": //关键词
	                        	 article_Factiva.setKeyword(lineTxt.split(" ")[1]);
	                            break;

	                        case "RE": //所在地
	                        	 article_Factiva.setCountry(lineTxt.split(" ")[1]);
	                            break;

	                        case "SN": //出版物名称
	                        	article_Factiva.setSource(lineTxt.split(" ")[1]);
	                            break;

	                        case "PD": //发布日期
	                        	 article_Factiva.setPublicDay(lineTxt.split(" ")[1]);
	                            break;

	                        case "PUB": //出版商
	                        	article_Factiva.setAgency(lineTxt.split(" ")[1]);
	                            break;

	                        case "LA": //语言
	                        	 article_Factiva.setLanguage(lineTxt.split(" ")[1]);
	                            break;
	                        case "提示名称": //结束
	                        	article_Factiva.setDiscribe(discribe);
	                        	article_Factiva.setIntro(intro);
	                        	intro="";
	                        	discribe="";
	                        	article_Factivas.add(article_Factiva);
	                        	System.out.println(article_Factiva.toString());
	                        	break;

	                    }
	            	 last=lineTxt.split(" ")[0];
	            		}
	            		   else{
	            			   if("LP".equals(last)){
	            				   discribe+=lineTxt+"\n";
	            			   }
	            			   if("TD".equals(last)){
	            				   intro+=lineTxt+"\n";
	            			   }
	            		   }
	            	   }
	               }
	               read.close();
	           } else {
	               System.out.println("找不到指定的文件");
	           }
	       } catch (Exception e) {
	           System.out.println("读取文件内容出错");
	           e.printStackTrace();
	       }
	    }
}
