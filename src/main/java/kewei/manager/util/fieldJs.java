package kewei.manager.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.google.gson.Gson;

import kewei.manager.bean.Field;
import kewei.manager.mapper.TestMapper;


public class fieldJs {

	public static void main(String[] args) throws UnsupportedEncodingException, IOException {
		SqlSessionFactory myFactory = MySqlSessionFactory.getMyFactory();

		SqlSession openSession = myFactory.openSession();

		TestMapper mapper = openSession.getMapper(TestMapper.class);

		List<Field> fields = mapper.select_field();

		// 集合转化为json集合
		Gson gson = new Gson();

		String json = gson.toJson(fields);

		// 将json集合输出成文件

		FileOutputStream fos = new FileOutputStream(new File("d:/field.js"));

		fos.write(json.getBytes("utf-8"));

	}

}
