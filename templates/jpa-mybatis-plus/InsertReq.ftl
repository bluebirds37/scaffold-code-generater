package ${packageName!}.entity.vo.req.system;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import javax.validation.constraints.NotEmpty;
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
public class ${humpTableName!?cap_first}InsertReq {

    <#list columnInfoList as columnInfo>
        @ApiModelProperty(value = "${columnInfo.columnComment!}")
        <#if columnInfo.javaType =="String">
            @NotEmpty(message = "${columnInfo.columnComment!}不能为空")
        </#if>
        <#if columnInfo.javaType !="String">
            @NotNull(message = "${columnInfo.columnComment!}不能为空")
        </#if>
        private ${columnInfo.javaType!} ${columnInfo.olumnName!};
    </#list>

}
