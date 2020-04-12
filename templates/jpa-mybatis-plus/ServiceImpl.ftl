package cn.jiheng.ypd.service.impl;

import cn.jiheng.ypd.config.response.PageBean;
import cn.jiheng.ypd.config.response.ResponseBean;
import cn.jiheng.ypd.config.response.ResponseBuilder;
import cn.jiheng.ypd.entity.po.system.Permission;
import cn.jiheng.ypd.entity.vo.req.system.PermissionInsertReq;
import cn.jiheng.ypd.entity.vo.req.system.PermissionPageQueryReq;
import cn.jiheng.ypd.entity.vo.req.system.PermissionQueryReq;
import cn.jiheng.ypd.entity.vo.req.system.PermissionUpdateReq;
import cn.jiheng.ypd.entity.vo.res.system.PermissionQueryRes;
import cn.jiheng.ypd.mapper.PermissionMapper;
import cn.jiheng.ypd.repository.PermissionRepository;
import cn.jiheng.ypd.service.PermissionService;
import cn.jiheng.ypd.util.EntityUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Transactional(rollbackFor = {Exception.class})
public class PermissionServiceImpl implements PermissionService {

    @Resource
    private PermissionRepository permissionRepository;

    @Resource
    private PermissionMapper permissionMapper;


    /**
     * 增
     *
     * @param permissionInsertReq permissionInsertReq
     * @return ?
     */
    @Override
    public ResponseBean<?> insert(PermissionInsertReq permissionInsertReq) {
        return ResponseBuilder.ok(permissionRepository.save(EntityUtils.copyProperties(permissionInsertReq, Permission.class)));
    }

    /**
     * 分页查
     *
     * @param permissionPageQueryReq permissionPageQueryReq
     * @return ?
     */
    @Override
    public ResponseBean<PageBean<PermissionQueryRes>> pageQuery(PermissionPageQueryReq permissionPageQueryReq) {
        //1。分页查询所有供公司
        Integer page = permissionPageQueryReq.getPage();
        page = page == null ? 1 : page <= 0 ? 1 : page;
        Integer size = permissionPageQueryReq.getSize();
        size = size == null ? 10 : size <= 0 ? 10 : size;
        PageRequest pageRequest = PageRequest.of(page - 1, size);
        Specification<Permission> permissionSpecification = (root, criteriaQuery, criteriaBuilder) -> {
            List<Predicate> predicateList = new ArrayList<>();
            if (StringUtils.isNotBlank(permissionPageQueryReq.getName())) {
                Predicate like = criteriaBuilder.like(root.get("name").as(String.class), StringUtils.join(
                        "%", permissionPageQueryReq.getName(), "%"
                ));
                predicateList.add(like);
            }
            Predicate[] predicateArray = new Predicate[predicateList.size()];
            criteriaQuery.where(criteriaBuilder.and(predicateList.toArray(predicateArray)));
            return criteriaQuery.getRestriction();
        };
        Page<Permission> all = permissionRepository.findAll(permissionSpecification, pageRequest);
        return ResponseBuilder.ok(
                all,
                element -> {
                    PermissionQueryRes permissionQueryRes = PermissionQueryRes
                            .builder()
                            .id(element.getId())
                            .name(element.getName())
                            .createTime(element.getCreateTime())
                            .deleted(element.getDeleted())
                            .deleteTime(element.getDeleteTime())
                            .description(element.getDescription())
                            .updateTime(element.getUpdateTime())
                            .url(element.getUrl())
                            .build();
                    return permissionQueryRes;
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
        permissionRepository.deleteById(id);
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
        ids.forEach(
                i -> permissionRepository.deleteById(i)
        );
        return ResponseBuilder.ok();
    }

    /**
     * 改
     *
     * @param permissionUpdateReq permissionUpdateReq
     * @return ?
     */
    @Override
    public ResponseBean<?> update(PermissionUpdateReq permissionUpdateReq) {
        permissionRepository.save(EntityUtils.copyProperties(permissionUpdateReq, Permission.class));
        return ResponseBuilder.ok();
    }

    /**
     * 查
     *
     * @param permissionQueryReq permissionQueryReq
     * @return ?
     */
    @Override
    public ResponseBean<List<PermissionQueryRes>> query(PermissionQueryReq permissionQueryReq) {
        //1。分页查询所有供公司
        Specification<Permission> permissionSpecification = (root, criteriaQuery, criteriaBuilder) -> {
            List<Predicate> predicateList = new ArrayList<>();
            if (StringUtils.isNotBlank(permissionQueryReq.getName())) {
                Predicate like = criteriaBuilder.like(root.get("name").as(String.class), StringUtils.join(
                        "%", permissionQueryReq.getName(), "%"
                ));
                predicateList.add(like);
            }
            Predicate[] predicateArray = new Predicate[predicateList.size()];
            criteriaQuery.where(criteriaBuilder.and(predicateList.toArray(predicateArray)));
            return criteriaQuery.getRestriction();
        };
        List<Permission> all = permissionRepository.findAll(permissionSpecification);
        return ResponseBuilder.ok(
                all.stream().map(
                        element -> {
                            //完善数据组装
                            PermissionQueryRes permissionQueryRes = PermissionQueryRes
                                    .builder()
                                    .id(element.getId())
                                    .name(element.getName())
                                    .createTime(element.getCreateTime())
                                    .deleted(element.getDeleted())
                                    .deleteTime(element.getDeleteTime())
                                    .description(element.getDescription())
                                    .updateTime(element.getUpdateTime())
                                    .url(element.getUrl())
                                    .build();
                            return permissionQueryRes;
                        }
                ).collect(Collectors.toList())
        );
    }
}
