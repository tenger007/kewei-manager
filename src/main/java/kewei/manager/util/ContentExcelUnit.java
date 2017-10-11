package kewei.manager.util;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.formula.ptg.ValueOperatorPtg;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import kewei.manager.bean.ContentDto;
import kewei.manager.bean.Menu;

 public class ContentExcelUnit {
	public   List<ContentDto> importExcel(String filePath) {
		//记录类的输出信息­
	       Log log = LogFactory.getLog(ContentExcelUnit.class); 
	      //获取Excel文档的路径­
	       //public static String filePath = "D://excel.xlsx";
	       List<ContentDto> contentDtos = new ArrayList<ContentDto>();
	    	  try {
	    		 
	              // 创建对Excel工作簿文件的引用
	             XSSFWorkbook wookbook = new XSSFWorkbook(new FileInputStream(filePath)); 
	              // 在Excel文档中，第一张工作表的缺省索引是0
	             // 其语句为：HSSFSheet sheet = workbook.getSheetAt(0);
	             XSSFSheet sheet = wookbook.getSheet("Sheet1");
	              //获取到Excel文件中的所有行数
	             int rows = sheet.getPhysicalNumberOfRows();
	              //遍历行
	              for (int i = 1; i < rows; i++) {
	                   // 读取左上端单元格
	                    XSSFRow row = sheet.getRow(i);
	                   // 行不为空
	                  if (row != null) {
	                          //获取到Excel文件中的所有的列
	                         int cells = row.getPhysicalNumberOfCells();
	                         String value = "";     
	                         //遍历列
	                        
	                         for (int j = 0; j < cells; j++) {
	                                //获取到列的值
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
	                    ContentDto contentDto = new ContentDto();
	                    contentDto.setContents(val[0]);
	                    contentDto.setJsdName(val[1]);
	                    contentDto.setMenuName(val[2]);
	                    contentDtos.add(contentDto);
	             }
	                  wookbook.close();
	         }
	} catch (FileNotFoundException e) {
	       e.printStackTrace();
	  } catch (IOException e) {
	        e.printStackTrace();
	}
			return contentDtos;
	}
	 
	}
      
