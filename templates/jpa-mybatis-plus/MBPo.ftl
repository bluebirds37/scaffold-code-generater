package cn.jiheng.ypd.entity.po.mybatis;

import cn.jiheng.ypd.entity.po.system.Dictionary;
import cn.jiheng.ypd.entity.po.system.Permission;
import cn.jiheng.ypd.entity.po.system.Role;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.LinkedHashSet;
import java.util.Set;

/**
 * @version 1.0
 * @Author mwh
 * @Date 2020/4/10 14:20
 */
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
@TableName("t_permission")
public class MBPermission {

    @TableId
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
