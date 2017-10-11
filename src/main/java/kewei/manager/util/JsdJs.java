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
import kewei.manager.bean.JiShuDian;
import kewei.manager.mapper.TestMapper;


public class JsdJs {

	public static void main(String[] args) throws UnsupportedEncodingException, IOException {
		SqlSessionFactory myFactory = MySqlSessionFactory.getMyFactory();

		SqlSession openSession = myFactory.openSession();

		TestMapper mapper = openSession.getMapper(TestMapper.class);

		List<Field> fields = mapper.select_field();

		for (int i = 0; i < fields.size(); i++) {

			int id = (int) fields.get(i).getId();

			List<JiShuDian> jsds = mapper.select_jsd_by_field(id);

			// 集合转化为json集合
			Gson gson = new Gson();

			String json = gson.toJson(jsds);

			// 将json集合输出成文件

			FileOutputStream fos = new FileOutputStream(new File("d:/jsd" + id + ".js"));

			fos.write(json.getBytes("utf-8"));
           fos.close();
		}

	}

}
