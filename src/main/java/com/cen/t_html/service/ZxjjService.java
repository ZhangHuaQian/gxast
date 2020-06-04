package com.cen.t_html.service;


import com.cen.t_html.entity.ZXJJ;

import java.util.List;
import java.util.Map;

public interface ZxjjService {
    ZXJJ selectByPrimaryKey(Integer id);
    int updateByPrimaryKeySelective(ZXJJ record);
    List<ZXJJ> selectreturn(Map<String,Object> sMap);
}
