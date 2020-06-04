package com.cen.sys.ItemAnswer.dao;

import com.cen.common.BaseDao;
import com.cen.sys.ItemAnswer.entity.ItemAnswer;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ItemAnswerMapper extends BaseDao<ItemAnswer> {

    List<ItemAnswer> selectByUid(@Param("uId") Integer uId);

    int insertList (List<ItemAnswer>list);
}