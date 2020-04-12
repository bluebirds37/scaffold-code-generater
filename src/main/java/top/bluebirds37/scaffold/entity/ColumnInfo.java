package top.bluebirds37.scaffold.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @version 1.0
 * @Author mwh
 * @Date 2020/4/10 11:04
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class ColumnInfo {

    /**
     * 列名
     */
    private String columnName;

    private String humpColumnName;
    /**
     * 字段类型
     */
    private String dataType;

    private String javaType;

    /**
     * 列注释
     */
    private String columnComment;

    private Boolean primary;

}
