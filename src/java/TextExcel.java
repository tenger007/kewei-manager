 import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.formula.functions.T;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.junit.Test;

import kewei.manager.bean.Menu;

 public class TextExcel {
	 public static void main(String[] args) {
		//记录类的输出信息­
	       Log log = LogFactory.getLog(TextExcel.class); 
	      //获取Excel文档的路径­
	       //public static String filePath = "D://excel.xlsx";
	    	  try {
	    		  List<Menu> menus = new ArrayList<Menu>();
	    		 String filePath = "D://excel.xlsx";
	              // 创建对Excel工作簿文件的引用­
	             XSSFWorkbook wookbook = new XSSFWorkbook(new FileInputStream(filePath)); 
	              // 在Excel文档中，第一张工作表的缺省索引是0
	             // 其语句为：HSSFSheet sheet = workbook.getSheetAt(0);­
	             XSSFSheet sheet = wookbook.getSheet("Sheet1");
	              //获取到Excel文件中的所有行数­
	             int rows = sheet.getPhysicalNumberOfRows();
	              //遍历行
	              for (int i = 1; i < rows; i++) {
	                   // 读取左上端单元格­
	                    XSSFRow row = sheet.getRow(i);
	                   // 行不为空­
	                  if (row != null) {
	                          //获取到Excel文件中的所有的列­
	                         int cells = row.getPhysicalNumberOfCells();
	                         String value = "";     
	                         //遍历列­
	                        
	                         for (int j = 0; j < cells; j++) {
	                                //获取到列的值­
	                               XSSFCell cell = row.getCell(j);
	                                if (cell != null) {
	                                      switch (cell.getCellType()) {
	                                           case XSSFCell.CELL_TYPE_FORMULA:
	                                            break;
	                                           case XSSFCell.CELL_TYPE_NUMERIC:
	                                                  value += cell.getNumericCellValue() + ",";       
	                                            break;  
	                                           case XSSFCell.CELL_TYPE_STRING:
	                                                  value += cell.getStringCellValue() + ",";
	                                           break;
	                                            default:
	                                                  value += "0";
	                                           break;
	                                }
	                          }      
	                    }
	                   // 将数据插入到mysql数据库
	                   String[] val = value.split(",");
	                    Menu menu = new Menu();
	                    menu.setFid(val[0].indexOf(val[0].length())); 
	                    menu.setJsdid(val[1].indexOf(val[1].length())); 
	                    menu.setName(val[2]); 
	                    menu.setLevel(val[3].indexOf(val[3].length())); 
	                    menu.setIsend(val[4].indexOf(val[4].length())); 
	                    menu.setHasson(val[5].indexOf(val[5].length())); 
	                   
	                    menus.add(menu);
	             }
	                  wookbook.close();
	         }
	              System.out.println(menus.toString());
	              System.out.println(Class.class.getClass().getResource("/").getPath()+"..//"+"..//");
	} catch (FileNotFoundException e) {
	       e.printStackTrace();
	  } catch (IOException e) {
	        e.printStackTrace();
	}
	}
	 
	}
      
