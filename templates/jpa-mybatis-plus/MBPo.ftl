package ${packageName!}.entity.po.mybatis;

import ${packageName!}.entity.po.system.Dictionary;
import ${packageName!}.entity.po.system.Permission;
import ${packageName!}.entity.po.system.Role;
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
@TableName("${tableName!}")
public class MB${className!} {

<#list columnInfoList as columnInfo>
    /**
    * ${columnInfo.columnComment!}
    */
    <#if columnInfo.primary == true >
        @TableId
    </#if>
    private ${columnInfo.javaType!} ${columnInfo.olumnName!};
</#list>

}
