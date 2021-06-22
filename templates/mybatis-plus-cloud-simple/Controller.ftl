package ${packageName!}.controller.admin;


import ${packageName!}.config.response.PageBean;
import ${packageName!}.config.response.ResponseBean;
import ${packageName!}.config.validation.Insert;
import ${packageName!}.config.validation.Update;
import ${packageName!}.entity.vo.req.system.*;
import ${packageName!}.entity.vo.res.system.${className!}QueryRes;
import ${packageName!}.service.${className!}Service;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import java.util.List;

@Api(tags = "001.用户")
@RestController
@RequestMapping("/${humpTableName!}")
public class ${humpTableName!?cap_first}Controller {

    @Resource
    private ${humpTableName!?cap_first}Service ${humpTableName!}Service;



}
