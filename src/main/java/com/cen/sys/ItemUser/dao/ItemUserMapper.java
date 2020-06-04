package com.cen.sys.ItemUser.dao;

import com.cen.common.BaseDao;
import com.cen.sys.ItemUser.entity.ItemUser;
import org.apache.ibatis.annotations.Param;

import java.util.Map;

public interface ItemUserMapper extends BaseDao<ItemUser> {

    /**
     * 通过学生姓名，指导老师姓名及电话查询学生信息
     * @param param
     * @return
     */
    ItemUser selectByUnameAndTnameAndTtel(Map<String, Object> param);

}