import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class TestMethod {
	/** 
	 * excel导出到输出流 
	 * 谁调用谁负责关闭输出流 
	 * @param os 输出流 
	 * @param excelExtName excel文件的扩展名，支持xls和xlsx，不带点号 
	 * @param data  
	 * @throws IOException 
	 */  
	public static void writeExcel(OutputStream os, String excelExtName, Map<String, List<List<String>>> data) throws IOException{  
	    Workbook wb = null;  
	    try {  
	        if ("xls".equals(excelExtName)) {  
	            wb = new HSSFWorkbook();  
	        } else if ("xlsx".equals(excelExtName)) {  
	            wb = new XSSFWorkbook();  
	        } else {  
	            throw new Exception("当前文件不是excel文件");  
	        }  
	        for (String sheetName : data.keySet()) {  
	            Sheet sheet = wb.createSheet(sheetName);  
	            List<List<String>> rowList = data.get(sheetName);  
	            for (int i = 0; i < rowList.size(); i++) {  
	                List<String> cellList = rowList.get(i);  
	                Row row = sheet.createRow(i);  
	                for (int j = 0; j < cellList.size(); j++) {  
	                    Cell cell = row.createCell(j);  
	                    cell.setCellValue(cellList.get(j));  
	                }  
	            }  
	        }  
	        wb.write(os);  
	    } catch (Exception e) {  
	        e.printStackTrace();  
	    } finally {  
	        if (wb != null) {  
	            wb.close();  
	        }  
	    }  
	}  
	 
}
