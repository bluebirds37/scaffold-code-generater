package top.bluebirds37.scaffold.entity;

import java.util.Arrays;
import java.util.concurrent.atomic.AtomicReference;

/**
 * @version 1.0
 * @Author mwh
 * @Date 2020/4/10 11:04
 */
public enum DataTypeEnum {

    BIGINT("BIGINT", "Long"),
    TIMESTAMP("TIMESTAMP", "LocalDateTime"),
    TINYINT("TINYINT", "Integer"),
    VARCHAR("VARCHAR", "String"),
    INT("INT", "Integer");

    DataTypeEnum(String jdbcType, String javaType) {
        this.jdbcType = jdbcType;
        this.javaType = javaType;
    }

    private String jdbcType;
    private String javaType;

    public String getJavaType() {
        return javaType;
    }

    public String getJdbcType() {
        return jdbcType;
    }

   public static class DataTypeEnumTool{
        public static String getJavaTypeByJdbcType(String jdbcType) {
            AtomicReference<String> javaType = new AtomicReference<>("String");
            Arrays.stream(DataTypeEnum.values()).filter(
                    i -> i.getJdbcType().equals(jdbcType)
            ).findAny().ifPresent(i -> javaType.set(i.getJavaType()));
            return javaType.get();
        }
    }
}
