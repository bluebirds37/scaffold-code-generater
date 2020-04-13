<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${packageName!}.mapper.${className!}Mapper">
    <resultMap id="Base${className!}ResultMap" type="${packageName!}.entity.po.mybatis.MB${className!}">
            <#list columnInfoList as columnInfo>
                <#if columnInfo.primary == true >
                    <id column="${columnInfo.columnName!}" property="${columnInfo.humpColumnName!}"/>
                </#if>
                <#if columnInfo.primary != true >
                    <result column="${columnInfo.columnName!}" property="${columnInfo.humpColumnName!}"/>
                </#if>
            </#list>
    </resultMap>
</mapper>
