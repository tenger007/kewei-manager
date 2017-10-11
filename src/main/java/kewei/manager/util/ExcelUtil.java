package kewei.manager.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.xmlbeans.impl.validator.ValidatingInfoXMLStreamReader;
import org.springframework.objenesis.instantiator.basic.NewInstanceInstantiator;

import kewei.manager.bean.ArticleDto;
import kewei.manager.bean.Article_Jsd;
import kewei.manager.bean.Company;
import kewei.manager.bean.ContentDto;
import kewei.manager.bean.JiShuDian;
import kewei.manager.bean.JsdDto;
import kewei.manager.bean.Jsd_expert;
import kewei.manager.bean.MenuDto;
import kewei.manager.bean.Us_article;

 public class ExcelUtil {
	   public static List<String[]> excleImport(XSSFSheet sheet){
		   int rows = sheet.getPhysicalNumberOfRows();
           //遍历行
          int cells = sheet.getRow(0).getPhysicalNumberOfCells();
            List<String[]> list_val = new ArrayList<String[]>();
           for (int i = 1; i < rows; i++) {
                // 读取左上端单元格
                 XSSFRow row = sheet.getRow(i);
                // 行不为空
               if (row != null) {
                       //获取到Excel文件中的所有的列
            	  String value="";
                      //遍历列
                     
                      for (int j = 0; j < cells; j++) {
                             //获取到列的值
                            XSSFCell cell = row.getCell(j);
                            if (cell==null){
                         	   value+=" "+"≃";
                            }
                            if(cell!=null) {
                                   switch (cell.getCellType()) {
                                        case XSSFCell.CELL_TYPE_FORMULA:
                                         break;
                                        case XSSFCell.CELL_TYPE_NUMERIC:
                                        	if (HSSFDateUtil.isCellDateFormatted(cell)) {// 处理日期格式、时间格式  
                                                SimpleDateFormat sdf = null;  
                                                if (cell.getCellStyle().getDataFormat() == HSSFDataFormat  
                                                        .getBuiltinFormat("h:mm")) {  
                                                    sdf = new SimpleDateFormat("HH:mm");  
                                                } else {// 日期  
                                                    sdf = new SimpleDateFormat("yyyy/MM/dd");  
                                                }  
                                               java.util.Date date = cell.getDateCellValue();  
                                                value += sdf.format(date)+ "≃";  
                                            }  else {
                                     	   value += cell.getNumericCellValue() + "≃"; 
                                            }
                                         break;  
                                        case XSSFCell.CELL_TYPE_STRING:
                                               value += cell.getStringCellValue() + "≃";
                                        break;
                                        case XSSFCell.CELL_TYPE_BLANK:  
                                            value += " "+"≃";  
                                            break;
                                         default:
                                               value += "";
                                        break;
                             }
                       }
                      }
                          String[]  val = value.split("\\≃");
                          list_val.add(val);
               }}
                      
		   return list_val;
	   }
	   public static List<String[]> excleImport2(XSSFSheet sheet){
		   int i2 =0;
		   int rows = sheet.getPhysicalNumberOfRows();
		   //遍历行
		   int cells = sheet.getRow(0).getPhysicalNumberOfCells();
		   List<String[]> list_val = new ArrayList<String[]>();
		   for (int i = 1; i < rows; i++) {
			   // 读取左上端单元格
			   XSSFRow row = sheet.getRow(i);
			   // 行不为空
			   if (row != null) {
				   //获取到Excel文件中的所有的列
				   String value="";
				   //遍历列
				   
				   for (int j = 0; j < cells; j++) {
					   //获取到列的值
					   XSSFCell cell = row.getCell(j);
					   if (cell==null){
						   value+=" "+"≃";
					   }
					   if(cell!=null) {
						   switch (cell.getCellType()) {
						   case XSSFCell.CELL_TYPE_FORMULA:
							   break;
						   case XSSFCell.CELL_TYPE_NUMERIC:
							   if (HSSFDateUtil.isCellDateFormatted(cell)) {// 处理日期格式、时间格式  
								   SimpleDateFormat sdf = null;  
								   if (cell.getCellStyle().getDataFormat() == HSSFDataFormat  
										   .getBuiltinFormat("h:mm")) {  
									   sdf = new SimpleDateFormat("HH:mm");  
								   } else {// 日期  
									   sdf = new SimpleDateFormat("yyyy/MM/dd");  
								   }  
								   java.util.Date date = cell.getDateCellValue();  
								   value += sdf.format(date)+ "≃";  
							   }  else {
								   double value2 = cell.getNumericCellValue();  
					                CellStyle style = cell.getCellStyle();  
					                DecimalFormat format = new DecimalFormat();  
					                String temp = style.getDataFormatString();  
					                // 单元格设置成常规  
					                if ("General".equals(temp)) {  
					                    format.applyPattern("#");  
					                }  
					              value+= format.format(value2)+ "≃";  
							   }
							   break;  
						   case XSSFCell.CELL_TYPE_STRING:
							   value += cell.getStringCellValue() + "≃";
							   break;
						   case XSSFCell.CELL_TYPE_BLANK:  
							   value += " "+"≃";  
							   break;
						   default:
							   value += "";
							   break;
						   }
					   }
				   }
				   String[]  val = value.split("\\≃");
				   System.out.println("........."+(i2++)+"...........");
				   list_val.add(val);
			   }}
		   
		   return list_val;
	   }
	 
	   //导入技术点专家信息
	   public static List<Jsd_expert> importJsd_expert(String filePath){
		      //获取Excel文档的路径­
		       //public static String filePath = "D://excel.xlsx";
		       List<Jsd_expert> jsd_experts = new ArrayList<Jsd_expert>();
		    	  try {
		              // 创建对Excel工作簿文件的引用
		             XSSFWorkbook wookbook = new XSSFWorkbook(new FileInputStream(filePath)); 
		              // 在Excel文档中，第一张工作表的缺省索引是0
		             // 其语句为：HSSFSheet sheet = workbook.getSheetAt(0);
		             XSSFSheet sheet = wookbook.getSheetAt(0);
		            List<String[]> list_val = excleImport2(sheet);
		           for(String[] val:list_val){
		        	   Jsd_expert jsd_expert = new Jsd_expert();
		        	   jsd_expert.setExpert_name(val[0].trim());
		        	   jsd_expert.setExpert_img(val[1].trim());
		        	   jsd_expert.setExpert_summary(val[2].trim());
		        	   jsd_expert.setExpert_email(val[3].trim());
		        	   jsd_expert.setExpert_unit(val[4].trim());
		        	   jsd_expert.setH_index(new Integer(Integer.parseInt(val[5].trim().isEmpty()?"0":val[5])));
		        	   jsd_expert.setScreening_basis(val[6].trim());
		                   jsd_experts.add(jsd_expert);
		           }     
		                  wookbook.close();
		} catch (FileNotFoundException e) {
		       e.printStackTrace();
		  } catch (IOException e) {
		        e.printStackTrace();
		}
				return jsd_experts;
		   }
	   
	   
	   //导入技术点相关公司信息
	   public static List<Company> importCompany(String filePath){
	      //获取Excel文档的路径­
	       //public static String filePath = "D://excel.xlsx";
	       List<Company> coms = new ArrayList<Company>();
	    	  try {
	              // 创建对Excel工作簿文件的引用
	             XSSFWorkbook wookbook = new XSSFWorkbook(new FileInputStream(filePath)); 
	              // 在Excel文档中，第一张工作表的缺省索引是0
	             // 其语句为：HSSFSheet sheet = workbook.getSheetAt(0);
	             XSSFSheet sheet = wookbook.getSheetAt(0);
	            List<String[]> list_val = excleImport(sheet);
	           for(String[] val:list_val){
	        	   Company com = new Company();
	                   com.setName(val[0].trim());
	                   com.setLat(new Double(Double.parseDouble(val[1].trim().isEmpty()?"0":val[1])));
	                   com.setLon(new Double(Double.parseDouble(val[2].trim().isEmpty()?"0":val[2])));
	                   com.setAddr(val[3].trim());
	                   com.setIntro(val[4].trim());
	                   coms.add(com);
	           }     
	          
	                  wookbook.close();
	         
	} catch (FileNotFoundException e) {
	       e.printStackTrace();
	  } catch (IOException e) {
	        e.printStackTrace();
	}
			return coms;
	   }
	   
	   
	   //导入美国政府项目
	   public static List<Us_article> importUs_article(String filePath) throws ParseException{
		   //获取Excel文档的路径­
		   //public static String filePath = "D://excel.xlsx";
		   int i2 =0;
		   List<Us_article> us_articles = new ArrayList<Us_article>();
		   try {
			   // 创建对Excel工作簿文件的引用
			   XSSFWorkbook wookbook = new XSSFWorkbook(new FileInputStream(filePath)); 
			   // 在Excel文档中，第一张工作表的缺省索引是0
			   // 其语句为：HSSFSheet sheet = workbook.getSheetAt(0);
			   XSSFSheet sheet = wookbook.getSheetAt(0);
			   List<String[]> list_val = excleImport2(sheet);
			   for(String[] val:list_val){
				   Us_article us_article = new Us_article();				  
				   us_article.setAbst(val[0].trim());
				   us_article.setAccess_num(val[1].trim());
				   //us_article.setAna_desc(val[2]);
				   us_article.setArticle_type(val[3].trim());
				   us_article.setAuthor(val[4].trim());
				   us_article.setClassification(val[5].trim());
				   us_article.setCont_num(val[6].trim());
				   us_article.setData_base(val[7].trim());
				   us_article.setDuc_type(val[8].trim());
				   us_article.setDuc_url(val[9].trim());
				   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");//小写的mm表示的是分钟
				   us_article.setPbdate(new java.sql.Date(sdf.parse(val[11].trim().isEmpty()?"0":val[11]).getTime()));
				   us_article.setLanguage(val[12].trim());
				   us_article.setPage_count(val[15].trim());
				   us_article.setPb_title(val[17].trim());
				   us_article.setYear(val[18].trim());
				   us_article.setPb_location(val[19].trim());
				   us_article.setRep_num(val[20].trim());
				   us_article.setSource_disc(val[21].trim());
				   us_article.setSubject(val[23].trim());
				   us_article.setTitle(val[24].trim());
				   us_articles.add(us_article);
			   }     
			   
			   wookbook.close();
			   
		   } catch (FileNotFoundException e) {
			   e.printStackTrace();
		   } catch (IOException e) {
			   e.printStackTrace();
		   }
		   return us_articles;
	   }
	   
	   //导入技术点相关信息
		public static  List<JiShuDian> importJsdDistributeExcel(String filePath) throws ParseException {
		      //获取Excel文档的路径­
		       //public static String filePath = "D://excel.xlsx";
		       List<JiShuDian> jsds = new ArrayList<JiShuDian>();
		    	  try {
		              // 创建对Excel工作簿文件的引用
		             XSSFWorkbook wookbook = new XSSFWorkbook(new FileInputStream(filePath)); 
		              // 在Excel文档中，第一张工作表的缺省索引是0
		             // 其语句为：HSSFSheet sheet = workbook.getSheetAt(0);
		             XSSFSheet sheet0 = wookbook.getSheetAt(0);
		             XSSFSheet sheet1 = wookbook.getSheetAt(1);
		             XSSFSheet sheet2 = wookbook.getSheetAt(2);
		             XSSFSheet sheet3 = wookbook.getSheetAt(3);
		            // List<String[]> list_val = excleImport(sheet);
		             List<String[]> list_val0 = excleImport(sheet0);
		             List<String[]> list_val1 = excleImport(sheet1);
		             List<String[]> list_val2 = excleImport(sheet2);
		            List<String[]> list_val3 = excleImport(sheet3);
		            	String civil = "";
			            String international="";
			            String num = "";
		            	for (int i = 0; i < list_val0.size(); i++) {
		            		 JiShuDian jsDian = new JiShuDian();
		            		/* for (int j = 0; j < list_val.get(i).length; j++) {
								
							}*/
		            		  for (int j = 0; j < list_val1.get(i).length-2; j=j+2) {
									international+=list_val2.get(i)[j]+":"+list_val2.get(i)[j+1]+"%，";
									civil+=list_val1.get(i)[j]+":"
											+new Float(Float.parseFloat(list_val1.get(i)[j+1].trim().isEmpty()?"0":list_val1.get(i)[j+1])).intValue()+"，";
								}
		            		  for (int j =0; j < list_val3.get(i).length-2; j=j+2) {
								num+=new Float(Float.parseFloat(list_val3.get(i)[j].trim().isEmpty()?"0":list_val1.get(i)[j])).intValue()+"，"
										+new Float(Float.parseFloat(list_val3.get(i)[j+1].trim().isEmpty()?"0":list_val1.get(i)[j+1])).intValue()+"，";
							}
		            			  SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd");//小写的mm表示的是分钟  
		            			  jsDian.setFieldid(new Float(Float.parseFloat(list_val0.get(i)[1].trim().isEmpty()?"0":list_val1.get(i)[1])).intValue());
		            			  jsDian.setName(list_val0.get(i)[0].trim());
		            			  jsDian.setUpdatetime(new java.sql.Date(sdf.parse(list_val0.get(i)[2].trim().isEmpty()?"0":list_val1.get(i)[2]).getTime()));
		            			  jsDian.setIsgenzongjishudian(new Float(Float.parseFloat(list_val0.get(i)[4].trim().isEmpty()?"0":list_val1.get(i)[4])).intValue());
		            			  jsDian.setIsqianyanjishudian(new Float(Float.parseFloat(list_val0.get(i)[3].trim().isEmpty()?"0":list_val1.get(i)[3])).intValue());
		            			  jsDian.setIsmainfield(new Float(Float.parseFloat(list_val0.get(i)[5].trim().isEmpty()?"0":list_val1.get(i)[5])).intValue());
		            			  jsDian.setImg(list_val0.get(i)[6].trim());
		            			  jsDian.setDefinition(list_val0.get(i)[7].trim());
		            			  jsDian.setEn_name(list_val0.get(i)[8].trim());
		            			  jsDian.setfName(list_val0.get(i)[9].trim());
				                   international+=list_val2.get(i)[list_val2.get(i).length-2].trim()+":"+list_val2.get(i)[list_val2.get(i).length-1].trim()+"%";
				                   civil+=list_val1.get(i)[list_val1.get(i).length-2].trim()+":"
				                		   +new Float(Float.parseFloat(list_val1.get(i)[list_val1.get(i).length-1].trim().isEmpty()?"0":list_val1.get(i)[list_val1.get(i).length-1])).intValue();
				                   num+=new Float(Float.parseFloat(list_val3.get(i)[list_val3.get(i).length-2].trim().isEmpty()?"0":list_val1.get(i)[list_val1.get(i).length-2])).intValue()+"，"
				                		   +new Float(Float.parseFloat(list_val3.get(i)[list_val3.get(i).length-1].trim().isEmpty()?"0":list_val1.get(i)[list_val1.get(i).length-1])).intValue();
				                   jsDian.setCivil(civil);
				                   jsDian.setInternational(international);
				                   jsDian.setNum(num);
				                   civil="";
			            			  international="";
			            			  num="";
				                   jsds.add(jsDian);
						}
		                  wookbook.close();
		         
		} catch (FileNotFoundException e) {
		       e.printStackTrace();
		  } catch (IOException e) {
		        e.printStackTrace();
		}
				return jsds;
		}
		
		
		//导入文章信息
	public static  List<ArticleDto> importArticleExcel(String filePath) throws ParseException {
	      //获取Excel文档的路径­
	       //public static String filePath = "D://excel.xlsx";
	       List<ArticleDto> articleDtos = new ArrayList<ArticleDto>();
	    	  try {
	              // 创建对Excel工作簿文件的引用
	             XSSFWorkbook wookbook = new XSSFWorkbook(new FileInputStream(filePath)); 
	              // 在Excel文档中，第一张工作表的缺省索引是0
	             // 其语句为：HSSFSheet sheet = workbook.getSheetAt(0);
	             XSSFSheet sheet = wookbook.getSheetAt(0);
	             List<String[]> list_val = excleImport(sheet);
	                         for(String[] val:list_val){
	                   // 将数据插入到mysql数据库
	                   ArticleDto articleDto = new ArticleDto();
	                   SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd");//小写的mm表示的是分钟  
	                   if(val[7].equals(" ")){
                	   articleDto.setPbdate(new java.sql.Date(sdf.parse("0/0/0").getTime()));
	                   }else{
	                   articleDto.setTitle(val[0].trim());
	                   articleDto.setPdf("http://172.18.20.218:8081/kewei-manager/upload/前沿预判文章附件/"+val[1].trim());
	                   articleDto.setImg("http://172.18.20.218:8081/kewei-manager/upload/前沿预判文章附件/"+val[2].trim());
	                   articleDto.setAuthor(val[3].trim());
	                   articleDto.setAuthorAffiliation(val[4].trim());
	                   articleDto.setSummary(val[5].trim());
	                   articleDto.setSourceName(val[6].trim());
	                   articleDto.setPbdate(new java.sql.Date(sdf.parse(val[7].trim().isEmpty()?"0":val[7]).getTime()));
	                   articleDto.setType(new Float(Float.parseFloat(val[8].trim().isEmpty()?"0":val[8])).intValue());
	                   articleDto.setIssn(val[9].trim());
	                   articleDto.setIssue(new Float(Float.parseFloat(val[10].trim().isEmpty()?"0":val[10])).intValue());
	                   articleDto.setLanguage(val[11].trim());
	                   articleDto.setVolume(new Float(Float.parseFloat(val[12].trim().isEmpty()?"0":val[12])).intValue());
	                   articleDto.setSubjects(val[13].trim());
	                   articleDto.setAuthorrp(val[14].trim());
	                   //articleDto.setId(new Float(Float.parseFloat(val[15])).intValue());
	                    articleDtos.add(articleDto);
	             }
	                  }
	                  wookbook.close();
	} catch (FileNotFoundException e) {
	       e.printStackTrace();
	  } catch (IOException e) {
	        e.printStackTrace();
	}
			return articleDtos;
	}
	 
	//导入文章-技术点关系
	public  static List<Article_Jsd> importJsdArticleExcel(String filePath)  {
		//获取Excel文档的路径­
		//public static String filePath = "D://excel.xlsx";
		List<Article_Jsd> article_Jsds = new ArrayList<Article_Jsd>();
		try {
			// 创建对Excel工作簿文件的引用
			XSSFWorkbook wookbook = new XSSFWorkbook(new FileInputStream(filePath)); 
			// 在Excel文档中，第一张工作表的缺省索引是0
			// 其语句为：HSSFSheet sheet = workbook.getSheetAt(0);
			XSSFSheet sheet = wookbook.getSheetAt(0);
			//获取到Excel文件中的所有行数
			List<String[]> list_val = excleImport(sheet);
			for(String[] val:list_val){
					Article_Jsd article_Jsd = new Article_Jsd();
					/*article_Jsd.setJsdId(new Float(Float.parseFloat(val[0])).intValue());
                    article_Jsd.setArticleId(new Float(Float.parseFloat(val[1])).intValue());*/
					article_Jsd.setJsdName(val[0].trim());
					article_Jsd.setArticleName(val[1].trim());
                    article_Jsd.setRealizetime(val[2].trim());
                    article_Jsd.setIsforecast(new Float(Float.parseFloat(val[3].trim().isEmpty()?"0":val[3])).intValue());
                    article_Jsds.add(article_Jsd);
				}
				wookbook.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return article_Jsds;
	}
	}
      
