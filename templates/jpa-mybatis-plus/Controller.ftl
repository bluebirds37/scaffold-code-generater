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
@RequestMapping("/permission")
public class ${humpTableName!?cap_first}Controller {

    @Resource
    private ${humpTableName!?cap_first}Service ${humpTableName!}Service;

    @ApiOperation("增")
    @PostMapping(value = "/insert")
    public ResponseBean<?> insert(
            @Validated(value = {Insert.class}) @RequestBody ${humpTableName!?cap_first}InsertReq ${humpTableName!}InsertReq
    ) {
        return${humpTableName!}Service.insert(${humpTableName!}InsertReq);
    }


    @ApiOperation("删")
    @PostMapping(value = "/deleteById")
    public ResponseBean<?> deleteById(
            @RequestParam Long id
    ) {
        return ${humpTableName!}Service.deleteById(id);
    }


    @ApiOperation("删")
    @PostMapping(value = "/deleteBatch")
    public ResponseBean<?> deleteBatch(
            @RequestBody List<Long> ids
    ) {
        return ${humpTableName!}Service.deleteBatch(ids);
    }


    @ApiOperation("改")
    @PostMapping(value = "/update")
    public ResponseBean<?> update(
            @Validated(value = {Update.class}) @RequestBody ${humpTableName!?cap_first}UpdateReq ${humpTableName!}UpdateReq
    ) {
        return ${humpTableName!}Service.update(${humpTableName!}UpdateReq);
    }


    @ApiOperation("分页查")
    @PostMapping(value = "/pageQuery")
    public ResponseBean<PageBean<${humpTableName!?cap_first}QueryRes>> pageQuery(
            @RequestBody ${humpTableName!?cap_first}PageQueryReq ${humpTableName!}PageQueryReq
    ) {
        return ${humpTableName!}Service.pageQuery(${humpTableName!}PageQueryReq);
    }

    @ApiOperation("查")
    @PostMapping(value = "/query")
    public ResponseBean<List<${humpTableName!?cap_first}QueryRes>> query(
            @RequestBody ${humpTableName!?cap_first}QueryReq ${humpTableName!}QueryReq
    ) {
        return ${humpTableName!}Service.query(${humpTableName!}QueryReq);
    }

    @ApiOperation("查")
    @PostMapping(value = "/selectById")
    public ResponseBean<${humpTableName!?cap_first}QueryRes> selectById(
    @RequestParam Long id
    ) {
        return ${humpTableName!}Service.selectById(id);
    }
}
