package com.cen.t_html.dao;


import com.cen.t_html.entity.ZXJJ;

import java.util.List;
import java.util.Map;

public interface ZxjjDao {
    ZXJJ  selectByPrimaryKey(Integer id);
    int updateByPrimaryKeySelective(ZXJJ record);
    List<ZXJJ> selectreturn(Map<String,Object> sMap);
}
