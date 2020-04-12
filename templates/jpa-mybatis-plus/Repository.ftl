package cn.jiheng.ypd.repository;

import cn.jiheng.ypd.entity.po.system.Permission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ${humpTableName!?cap_first}Repository extends JpaRepository<${humpTableName!?cap_first}, ${primaryJavaType!}>, JpaSpecificationExecutor<${humpTableName!?cap_first}> {

}
