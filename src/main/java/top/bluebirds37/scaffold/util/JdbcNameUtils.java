package top.bluebirds37.scaffold.util;

import org.apache.commons.lang3.StringUtils;

/**
 * @version 1.0
 * @Author mwh
 * @Date 2020/4/10 15:31
 */
public class JdbcNameUtils {

    /**
     * 数据库 _ 转驼峰
     *
     * @param jdbcString jdbcString
     * @return string
     */
    public static String getHumpString(String jdbcString, String tablePrefix) {
        String humpString = "";
        if (StringUtils.isNotBlank(tablePrefix)) {
            jdbcString = jdbcString.replaceAll(tablePrefix, "");
        }
        String[] split = jdbcString.split("_");
        for (int i = 0; i < split.length; i++) {
            String word = split[i];
            if (word.length() < 1) {
                continue;
            }
            //转小写
            word = word.toLowerCase();
            if (i != 0) {
                //大写首位
                if (word.length() > 0) {
                    String first = word.substring(0, 1).toLowerCase();
                    String other = word.substring(1);
                    word = StringUtils.join(first, other);
                }
            }
            humpString = StringUtils.join(humpString, word);
        }
        return humpString;
    }
}
