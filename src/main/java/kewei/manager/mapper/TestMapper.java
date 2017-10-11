package kewei.manager.mapper;

import java.util.List;

import kewei.manager.bean.Field;
import kewei.manager.bean.JiShuDian;
import kewei.manager.bean.Source;

public interface TestMapper {

	List<Field> select_field();

	List<JiShuDian> select_jsd_by_field(int id);
	
	List<Source> select_source();
}
