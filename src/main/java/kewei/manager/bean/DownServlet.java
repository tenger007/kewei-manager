package kewei.manager.bean;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

/**
 * Servlet implementation class DownServlet
 */
public class DownServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public DownServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String filename = request.getParameter("path");
		 String filepath = this.getServletContext().getRealPath("/WEB-INF/export/" + filename);
		 File file = new File(filepath);
		 if(!file.exists()) {
		 response.getWriter().print("您要下载的文件不存在！");
		 return;
		 }
		 IOUtils.copy(new FileInputStream(file), response.getOutputStream());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
