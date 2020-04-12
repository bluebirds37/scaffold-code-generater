package top.bluebirds37.scaffold.util;

import org.springframework.beans.BeanUtils;

public class EntityUtils {

    public static <T, E> E copyProperties(T source, Class<E> targetClass) {
        E targetEntity = null;
        try {
            targetEntity = targetClass.newInstance();
            BeanUtils.copyProperties(source, targetEntity);
        } catch (InstantiationException | IllegalAccessException e) {
            e.printStackTrace();
        }
        return targetEntity;
    }


}
