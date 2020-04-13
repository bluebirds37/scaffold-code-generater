package ${packageName!}.entity.vo.req.system;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import io.swagger.annotations.ApiModelProperty;

/**
 * @version 1.0
 * @Author mwh
 * @Date 2020/4/10 14:20
 */
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class ${humpTableName!?cap_first}UpdateReq {

<#list columnInfoList as columnInfo>
    @ApiModelProperty(value = "${columnInfo.columnComment!}")
    <#if columnInfo.javaType =="String">
        @NotEmpty(message = "${columnInfo.columnComment!}不能为空")
    </#if>
    <#if columnInfo.javaType !="String">
        @NotNull(message = "${columnInfo.columnComment!}不能为空")
    </#if>
    private ${columnInfo.javaType!} ${columnInfo.humpColumnName!};
</#list>

}