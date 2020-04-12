package top.bluebirds37.scaffold.util;


import freemarker.cache.FileTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.Version;
import org.apache.commons.lang3.StringUtils;
import org.springframework.util.ResourceUtils;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;


/**
 * @description:
 * @author: mwh
 * @createDate: 2019/2/11 14:30
 * @updateRemark:
 * @version: 1.0
 */

public class TemplateHandler {

    private static Configuration cfg = new Configuration(Configuration.VERSION_2_3_29);
    private static final String FTL_LOCATION = "classpath:/templates/";

    static {
        cfg.setDefaultEncoding("UTF-8");
    }

    public static void getTemplate(
            String templateType,
            String templateName,
            String filePath,
            Map<String, Object> dataModel
    ) {
        try {
            File file = new File("");
            File canonicalFile = file.getCanonicalFile();
            File ftlDir = ResourceUtils.getFile(StringUtils.join(
                    canonicalFile,
                    File.separator,
                    "templates",
                    File.separator,
                    templateType,
                    "/"
            ));
            cfg.setDirectoryForTemplateLoading(ftlDir);
            Template template = cfg.getTemplate(StringUtils.join(templateName, ".ftl"));
            File resultFile = new File(filePath);
            if (!resultFile.getParentFile().exists()) {
                resultFile.getParentFile().mkdirs();
            }
            Writer out = new BufferedWriter(new OutputStreamWriter(
                    new FileOutputStream(resultFile), StandardCharsets.UTF_8));
            template.process(dataModel, out);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
