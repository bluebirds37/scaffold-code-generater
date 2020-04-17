package ${packageName!}.entity.vo.req.system;

import ${packageName!}.config.request.BasePageRequest;
import lombok.*;
import io.swagger.annotations.ApiModelProperty;
import java.time.LocalDateTime;

/**
 * @version 1.0
 * @Author mwh
 * @Date 2020/4/10 14:20
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
public class ${className!}PageQueryReq extends BasePageRequest {

<#list columnInfoList as columnInfo>
    @ApiModelProperty(value = "${columnInfo.columnComment!}")
    private ${columnInfo.javaType!} ${columnInfo.humpColumnName!};
</#list>

}
