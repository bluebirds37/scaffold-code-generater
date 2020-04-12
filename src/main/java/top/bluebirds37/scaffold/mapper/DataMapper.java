package top.bluebirds37.scaffold.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import top.bluebirds37.scaffold.entity.TableInfo;

import java.util.List;

/**
 * @version 1.0
 * @Author mwh
 * @Date 2020/4/10 11:00
 */
@Mapper
public interface DataMapper {
    List<TableInfo> listTables();
}
