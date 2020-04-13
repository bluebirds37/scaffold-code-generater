package top.bluebirds37.scaffold.config.listener;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.ContextRefreshedEvent;
import top.bluebirds37.scaffold.config.properties.SystemProperties;
import top.bluebirds37.scaffold.entity.ColumnInfo;
import top.bluebirds37.scaffold.entity.DataTypeEnum;
import top.bluebirds37.scaffold.entity.TableInfo;
import top.bluebirds37.scaffold.mapper.DataMapper;
import top.bluebirds37.scaffold.util.JdbcNameUtils;
import top.bluebirds37.scaffold.util.TemplateHandler;

import javax.annotation.Resource;
import java.io.File;
import java.util.List;
import java.util.stream.Collectors;


@Configuration
@Slf4j
public class CustomerListener implements ApplicationListener<ContextRefreshedEvent> {

    @Resource
    private SystemProperties systemProperties;
    @Resource
    private DataMapper dataMapper;

    @Override
    public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
        List<TableInfo> tableInfos = dataMapper.listTables();
        if (systemProperties.getTableNames().size() > 0) {
            tableInfos = tableInfos.stream().filter(
                    i -> systemProperties.getTableNames().indexOf(i.getTableName()) != -1
            ).collect(Collectors.toList());
        }
        tableInfos.forEach(
                table -> {
                    table.setHumpTableName(JdbcNameUtils.getHumpString(table.getTableName(), systemProperties.getTablePrefix()));
                    table.setClassName(JdbcNameUtils.getClassName(table.getTableName(), systemProperties.getTablePrefix()));
                    List<ColumnInfo> columnInfoList = table.getColumnInfoList();
                    columnInfoList.forEach(
                            column -> {
                                column.setHumpColumnName(JdbcNameUtils.getHumpString(column.getColumnName(), ""));
                                column.setJavaType(DataTypeEnum.DataTypeEnumTool.getJavaTypeByJdbcType(column.getDataType().toUpperCase()));
                            }
                    );
                    table.setPackageName(systemProperties.getPackageName());
                    table.getColumnInfoList().stream().filter(i -> i.getPrimary() != null && i.getPrimary()).findAny().ifPresent(
                            i -> table.setPrimaryJavaType(
                                    i.getJavaType()
                            )
                    );
                    log.info("系统配置:{}", JSONObject.toJSONString(table));
                }
        );
        //操作freemarker
        tableInfos.forEach(
                table -> {
                    systemProperties.getTemplateNames().forEach(
                            templateName -> {
                                String suffix = ".java";
                                String resultName = templateName;
                                if (templateName.contains("Xml")){
                                    suffix = ".xml";
                                    resultName  = resultName.replaceAll("Xml","");
                                }
                                TemplateHandler.getTemplate(
                                        systemProperties.getTemplateType(),
                                        templateName,
                                        StringUtils.join(
                                                systemProperties.getResultPath(),
                                                File.separator,
                                                //templateName,
                                                //File.separator,
                                                table.getClassName(),
                                                resultName,
                                                suffix
                                        ),
                                        JSONObject.parseObject(JSON.toJSONString(table))
                                );
                            }
                    );
                }
        );
    }
}
