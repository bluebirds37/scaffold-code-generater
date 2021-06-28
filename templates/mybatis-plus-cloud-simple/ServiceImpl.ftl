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

}
