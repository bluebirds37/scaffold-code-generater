package ${packageName!}.service.impl;

import ${packageName!}.config.response.PageBean;
import ${packageName!}.config.response.ResponseBean;
import ${packageName!}.config.response.ResponseBuilder;
import ${packageName!}.entity.po.system.${className!};
import ${packageName!}.entity.vo.req.system.${className!}InsertReq;
import ${packageName!}.entity.vo.req.system.${className!}PageQueryReq;
import ${packageName!}.entity.vo.req.system.${className!}QueryReq;
import ${packageName!}.entity.vo.req.system.${className!}UpdateReq;
import ${packageName!}.entity.vo.res.system.${className!}QueryRes;
import ${packageName!}.mapper.${className!}Mapper;
import ${packageName!}.repository.${className!}Repository;
import ${packageName!}.service.${className!}Service;
import ${packageName!}.util.EntityUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import javax.annotation.Resource;
import javax.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional(rollbackFor = {Exception.class})
public class ${className!}ServiceImpl implements ${className!}Service {

    @Resource
    private ${className!}Repository ${humpTableName!}Repository;

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
        return ResponseBuilder.ok(${humpTableName!}Repository.save(EntityUtils.copyProperties(${humpTableName!}InsertReq, ${className!}.class)));
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
        PageRequest pageRequest = PageRequest.of(page - 1, size);
        Specification<${className!}> ${humpTableName!}Specification = (root, criteriaQuery, criteriaBuilder) -> {
            List<Predicate> predicateList = new ArrayList<>();
            <#list columnInfoList as columnInfo>
                <#if columnInfo.javaType == "String" >
                    if (StringUtils.isNotBlank(${humpTableName!}PageQueryReq.get${columnInfo.humpColumnName!?cap_first}())) {
                        Predicate like = criteriaBuilder.like(root.get("${columnInfo.humpColumnName!}").as(${columnInfo.javaType!}.class),
                        StringUtils.join(
                        "%", ${humpTableName!}PageQueryReq.get${columnInfo.humpColumnName!?cap_first}(), "%"
                        ));
                        predicateList.add(like);
                    }
                </#if>
                <#if columnInfo.javaType != "String" >
                    if (${humpTableName!}PageQueryReq.get${columnInfo.humpColumnName!?cap_first}()!=null) {
                    Predicate equal = criteriaBuilder.equal(root.get("${columnInfo.humpColumnName!}").as(${columnInfo.javaType!}.class),
                    ${humpTableName!}PageQueryReq.get${columnInfo.humpColumnName!?cap_first}()
                    );
                    predicateList.add(equal);
                    }
                </#if>
            </#list>
            criteriaBuilder.equal(root.get("deleted").as(Integer.class),0);
            Predicate[] predicateArray = new Predicate[predicateList.size()];
            criteriaQuery.where(criteriaBuilder.and(predicateList.toArray(predicateArray)));
            return criteriaQuery.getRestriction();
        };
        Page<${className!}> all = ${humpTableName!}Repository.findAll(${humpTableName!}Specification, pageRequest);
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
        ${humpTableName!}Repository.findById(id).ifPresent(
            i -> {
                i.setDeleted(1);
        ${humpTableName!}Repository.save(i);
            }
        );
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
            ${humpTableName!}Repository.findAllById(ids).forEach(
            i -> {
                i.setDeleted(1);
            ${humpTableName!}Repository.save(i);
            }
        );
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
            ${humpTableName!}Repository.save(EntityUtils.copyProperties(${humpTableName!}UpdateReq, ${className!}.class));
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
        //1。分页查询所有供公司
        Specification<${className!}> ${humpTableName!}Specification = (root, criteriaQuery, criteriaBuilder) -> {
        List<Predicate> predicateList = new ArrayList<>();
            <#list columnInfoList as columnInfo>
                <#if columnInfo.javaType == "String" >
                    if (StringUtils.isNotBlank(${humpTableName!}QueryReq.get${columnInfo.humpColumnName!?cap_first}())) {
                    Predicate like = criteriaBuilder.like(root.get("${columnInfo.humpColumnName!}").as(${columnInfo.javaType!}.class),
                    StringUtils.join(
                    "%", ${humpTableName!}QueryReq.get${columnInfo.humpColumnName!?cap_first}(), "%"
                    ));
                    predicateList.add(like);
                    }
                </#if>
                <#if columnInfo.javaType != "String" >
                    if (${humpTableName!}QueryReq.get${columnInfo.humpColumnName!?cap_first}()!=null) {
                    Predicate equal = criteriaBuilder.equal(root.get("${columnInfo.humpColumnName!}").as(${columnInfo.javaType!}.class),
                    ${humpTableName!}QueryReq.get${columnInfo.humpColumnName!?cap_first}()
                    );
                    predicateList.add(equal);
                    }
                </#if>
            </#list>
            criteriaBuilder.equal(root.get("deleted").as(Integer.class),0);
            Predicate[] predicateArray = new Predicate[predicateList.size()];
            criteriaQuery.where(criteriaBuilder.and(predicateList.toArray(predicateArray)));
            return criteriaQuery.getRestriction();
        };
        List<${className!}> all = ${humpTableName!}Repository.findAll(${humpTableName!}Specification);
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
