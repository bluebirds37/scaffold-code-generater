package ${packageName!}.entity.vo.res.system;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import io.swagger.annotations.ApiModelProperty;
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
public class ${humpTableName!?cap_first}QueryRes {

<#list columnInfoList as columnInfo>
    @ApiModelProperty(value = "${columnInfo.columnComment!}")
    private ${columnInfo.javaType!} ${columnInfo.humpColumnName!};
</#list>

}
