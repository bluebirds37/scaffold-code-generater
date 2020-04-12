package cn.jiheng.ypd.service;

import cn.jiheng.ypd.config.response.PageBean;
import cn.jiheng.ypd.config.response.ResponseBean;
import cn.jiheng.ypd.entity.vo.req.system.PermissionInsertReq;
import cn.jiheng.ypd.entity.vo.req.system.PermissionPageQueryReq;
import cn.jiheng.ypd.entity.vo.req.system.PermissionQueryReq;
import cn.jiheng.ypd.entity.vo.req.system.PermissionUpdateReq;
import cn.jiheng.ypd.entity.vo.res.system.PermissionQueryRes;

import java.util.List;

public interface PermissionService {

    /**
     * 增
     *
     * @param permissionInsertReq permissionInsertReq
     * @return ?
     */
    ResponseBean<?> insert(PermissionInsertReq permissionInsertReq);

    /**
     * 分页查
     *
     * @param permissionPageQueryReq permissionPageQueryReq
     * @return permissionQueryRes
     */
    ResponseBean<PageBean<PermissionQueryRes>> pageQuery(PermissionPageQueryReq permissionPageQueryReq);

    /**
     * 删
     *
     * @param id id
     * @return ?
     */
    ResponseBean<?> deleteById(Long id);

    /**
     * 批量删
     *
     * @param ids ids
     * @return ?
     */
    ResponseBean<?> deleteBatch(List<Long> ids);

    /**
     * 改
     *
     * @param permissionUpdateReq permissionUpdateReq
     * @return ?
     */
    ResponseBean<?> update(PermissionUpdateReq permissionUpdateReq);

    /**
     * 查
     *
     * @param permissionQueryReq
     * @return ?
     */
    ResponseBean<List<PermissionQueryRes>> query(PermissionQueryReq permissionQueryReq);
}
