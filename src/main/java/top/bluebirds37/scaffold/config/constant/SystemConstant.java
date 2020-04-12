package top.bluebirds37.scaffold.config.constant;


public interface SystemConstant {

    /**
     * 静态资源映射前缀
     */
    String WEB_MVC_STATIC_RESOURCE_MAPPING_PREFIX = "file:";

    /**
     * LOG异常
     */
    String EXCEPTION_LOG_PREFIX = "发生异常信息:{}";
    /**
     * 文件前后缀分隔符
     */
    String FILE_NAME_SPLIT_SYMBOL = "\\.";

    /**
     * 文件前后缀粘粘
     */
    String FILE_NAME_CONCAT_SYMBOL = ".";

    /**
     * URI分隔符
     */
    String URI_CONCAT_SYMBOL = "/";

    /**
     * URI单层匹配
     */
    String URI_SINGLE_PATTERN_SYMBOL = "*";

    /**
     * URI全匹配
     */
    String URI_FULL_PATTERN_SYMBOL = "**";

    /**
     * IO
     */
    int READ_SIZE = 8 * 1024;
}
