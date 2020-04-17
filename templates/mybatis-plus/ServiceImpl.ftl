package ${packageName!}.service.impl;

import ${packageName!}.config.response.PageBean;
import ${packageName!}.config.response.ResponseBean;
import ${packageName!}.config.response.ResponseBuilder;
import ${packageName!}.entity.po.${className!};
import ${packageName!}.entity.vo.req.${className!}InsertReq;
import ${packageName!}.entity.vo.req.${className!}PageQueryReq;
import ${packageName!}.entity.vo.req.${className!}QueryReq;
import ${packageName!}.entity.vo.req.${className!}UpdateReq;
import ${packageName!}.entity.vo.res.${className!}QueryRes;
import ${packageName!}.mapper.${className!}Mapper;
import ${packageName!}.service.${className!}Service;
import ${packageName!}.util.EntityUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;

@Service
@Transactional(rollbackFor = {Exception.class})
public class ${className!}ServiceImpl implements ${className!}Service {

    @Resource
    private  ${className!}Mapper ${humpTableName!}Mapper;


    /**
     * 增
     *
     * @param ${humpTableName!}InsertReq ${humpTableName!}InsertReq
     * @return ?
     */
    @Override
    public ResponseBean<?> insert(${className!}InsertReq ${humpTableName!}InsertReq) {
        return ResponseBuilder.ok(${humpTableName!}Mapper.insert(EntityUtils.copyProperties(${humpTableName!}InsertReq, ${className!}.class)));
    }

    /**
     * 分页查
     *
     * @param ${humpTableName!}PageQueryReq ${humpTableName!}PageQueryReq
     * @return ?
     */
    @Override
    public ResponseBean<PageBean<${className!}QueryRes>> pageQuery(${className!}PageQueryReq ${humpTableName!}PageQueryReq) {
        //1。分页查询所有供公司
        Integer page = ${humpTableName!}PageQueryReq.getPage();
        page = page == null ? 1 : page <= 0 ? 1 : page;
        Integer size = ${humpTableName!}PageQueryReq.getSize();
        size = size == null ? 10 : size <= 0 ? 10 : size;
        LambdaQueryWrapper<${className!}> queryWrapper = Wrappers.<${className!}>lambdaQuery();
        <#list columnInfoList as columnInfo>
            <#if columnInfo.javaType == "String" >
                if (StringUtils.isNotBlank(${humpTableName!}PageQueryReq.get${columnInfo.humpColumnName!?cap_first}())) {
                queryWrapper.like(${className!}::get${columnInfo.humpColumnName!?cap_first}, StringUtils.join(
                "%", ${humpTableName!}PageQueryReq.get${columnInfo.humpColumnName!?cap_first}(), "%"
                ));
                }
            </#if>
            <#if columnInfo.javaType != "String" >
                if (${humpTableName!}PageQueryReq.get${columnInfo.humpColumnName!?cap_first}()!=null) {
                queryWrapper.eq(${className!}::get${columnInfo.humpColumnName!?cap_first},
                ${humpTableName!}PageQueryReq.get${columnInfo.humpColumnName!?cap_first}()
                );
                }
            </#if>
        </#list>
        queryWrapper.orderByDesc(${className!}::getCreateTime);
        Page<${className!}> all = ${humpTableName!}Mapper.selectPage(new Page<>(page, size), queryWrapper);
        return ResponseBuilder.ok(
                all,
                element -> {
                    ${className!}QueryRes ${humpTableName!}QueryRes = ${className!}QueryRes
                            .builder()
                            <#list columnInfoList as columnInfo>
                            .${columnInfo.humpColumnName!}(element.get${columnInfo.humpColumnName!?cap_first}())
                            </#list>
                            .build();
                    return ${humpTableName!}QueryRes;
                }
        );
    }

    /**
    * 删
    *
    * @param id id
    * @return ?
    */
    @Override
    public ResponseBean<?> deleteById(Long id) {
        ${humpTableName!}Mapper.deleteById(id);
        return ResponseBuilder.ok();
    }

    /**
    * 批量删
    *
    * @param ids ids
    * @return ?
    */
    @Override
    public ResponseBean<?> deleteBatch(List<Long> ids) {
            ${humpTableName!}Mapper.deleteBatchIds(ids);
            return ResponseBuilder.ok();
    }
    /**
     * 改
     *
     * @param ${humpTableName!}UpdateReq ${humpTableName!}UpdateReq
     * @return ?
     */
    @Override
    public ResponseBean<?> update(${className!}UpdateReq ${humpTableName!}UpdateReq) {
            ${humpTableName!}Mapper.updateById(EntityUtils.copyProperties(${humpTableName!}UpdateReq, ${className!}.class));
        return ResponseBuilder.ok();
    }

    /**
     * 查
     *
     * @param ${humpTableName!}QueryReq ${humpTableName!}QueryReq
     * @return ?
     */
    @Override
    public ResponseBean<List<${className!}QueryRes>> query(${className!}QueryReq ${humpTableName!}QueryReq) {
        LambdaQueryWrapper<${className!}> queryWrapper = Wrappers.<${className!}>lambdaQuery();
        <#list columnInfoList as columnInfo>
            <#if columnInfo.javaType == "String" >
                if (StringUtils.isNotBlank(${humpTableName!}QueryReq.get${columnInfo.humpColumnName!?cap_first}())) {
                    queryWrapper.like(${className!}::get${columnInfo.humpColumnName!?cap_first}, StringUtils.join(
                    "%", ${humpTableName!}QueryReq.get${columnInfo.humpColumnName!?cap_first}(), "%"
                    ));
                }
            </#if>
            <#if columnInfo.javaType != "String" >
                if (${humpTableName!}QueryReq.get${columnInfo.humpColumnName!?cap_first}()!=null) {
                    queryWrapper.eq(${className!}::get${columnInfo.humpColumnName!?cap_first},
                    ${humpTableName!}QueryReq.get${columnInfo.humpColumnName!?cap_first}()
                    );
                }
            </#if>
        </#list>
        queryWrapper.orderByDesc(${className!}::getCreateTime);
        List<${className!}> all = ${humpTableName!}Mapper.selectList(queryWrapper);
        return ResponseBuilder.ok(
                all.stream().map(
                        element -> {
                        ${className!}QueryRes ${humpTableName!}QueryRes = ${className!}QueryRes
                        .builder()
                        <#list columnInfoList as columnInfo>
                            .${columnInfo.humpColumnName!}(element.get${columnInfo.humpColumnName!?cap_first}())
                        </#list>
                        .build();
                        return ${humpTableName!}QueryRes;
                        }
                ).collect(Collectors.toList())
        );
    }
}
