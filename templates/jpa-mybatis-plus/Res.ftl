package cn.jiheng.ypd.entity.vo.res.system;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * @version 1.0
 * @Author mwh
 * @Date 2020/4/10 14:20
 */
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class PermissionQueryRes {

    private Long id;

    private String name;

    private String url;

    private Long typeId;

    private String description;

    private Long parentId;

    private LocalDateTime updateTime;

    private LocalDateTime deleteTime;

    private LocalDateTime createTime;

    private Integer deleted;

}
