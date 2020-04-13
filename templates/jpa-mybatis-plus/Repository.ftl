package ${packageName!}.repository;

import ${packageName!}.entity.po.system.${className!};
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ${humpTableName!?cap_first}Repository extends JpaRepository<${humpTableName!?cap_first}, ${primaryJavaType!}>, JpaSpecificationExecutor<${humpTableName!?cap_first}> {

}
