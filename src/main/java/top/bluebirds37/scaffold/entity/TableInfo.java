package top.bluebirds37.scaffold.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

/**
 * @version 1.0
 * @Author mwh
 * @Date 2020/4/10 11:04
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class TableInfo {

    /**
     * 表名
     */
    private String tableName;

    private String packageName;

    private String humpTableName;

    /**
     * 注释
     */
    private String tableComment;

    private List<ColumnInfo> columnInfoList = new ArrayList<>();


}
