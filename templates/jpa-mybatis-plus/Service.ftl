package cn.jiheng.ypd.service;

import cn.jiheng.ypd.config.response.PageBean;
import cn.jiheng.ypd.config.response.ResponseBean;
import cn.jiheng.ypd.entity.vo.req.system.PermissionInsertReq;
import cn.jiheng.ypd.entity.vo.req.system.PermissionPageQueryReq;
import cn.jiheng.ypd.entity.vo.req.system.PermissionQueryReq;
import cn.jiheng.ypd.entity.vo.req.system.PermissionUpdateReq;
import cn.jiheng.ypd.entity.vo.res.system.PermissionQueryRes;

import java.util.List;

public interface ${humpTableName!?cap_first}Service {

    /**
     * 增
     *
     * @param ${humpTableName!}InsertReq ${humpTableName!}InsertReq
     * @return ?
     */
    ResponseBean<?> insert(${humpTableName!?cap_first}InsertReq ${humpTableName!}InsertReq);

    /**
     * 分页查
     *
     * @param permissionPageQueryReq permissionPageQueryReq
     * @return permissionQueryRes
     */
    ResponseBean<PageBean<${humpTableName!?cap_first}QueryRes>> pageQuery(${humpTableName!?cap_first}PageQueryReq ${humpTableName!}PageQueryReq);

    /**
     * 删
     *
     * @param id id
     * @return ?
     */
    ResponseBean<?> deleteById(${primaryJavaType!} id);

    /**
     * 批量删
     *
     * @param ids ids
     * @return ?
     */
    ResponseBean<?> deleteBatch(List<${primaryJavaType!}> ids);

    /**
     * 改
     *
     * @param ${humpTableName!}UpdateReq ${humpTableName!}UpdateReq
     * @return ?
     */
    ResponseBean<?> update(${humpTableName!?cap_first}UpdateReq ${humpTableName!}UpdateReq);

    /**
     * 查
     *
     * @param permissionQueryReq
     * @return ?
     */
    ResponseBean<List<${humpTableName!?cap_first}QueryRes>> query(${humpTableName!?cap_first}QueryReq ${humpTableName!}QueryReq);
}
