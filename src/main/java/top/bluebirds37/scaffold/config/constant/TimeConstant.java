package top.bluebirds37.scaffold.config.constant;

import java.time.format.DateTimeFormatter;

public interface TimeConstant {

    String DAY = "天";

    String FULL_TIME_PATTERN = "yyyy-MM-dd HH:mm:ss";

    String YEAR_MONTH_DAY_PATTERN = "yyyy-MM-dd";

    String YEAR_MONTH_PATTERN = "yyyy-MM";

    DateTimeFormatter FULL_TIME_FORMATTER = DateTimeFormatter.ofPattern(TimeConstant.FULL_TIME_PATTERN);
    DateTimeFormatter YEAR_MONTH_DAY_FORMATTER = DateTimeFormatter.ofPattern(TimeConstant.YEAR_MONTH_DAY_PATTERN);
    DateTimeFormatter YEAR_MONTH_FORMATTER = DateTimeFormatter.ofPattern(TimeConstant.YEAR_MONTH_PATTERN);
}
