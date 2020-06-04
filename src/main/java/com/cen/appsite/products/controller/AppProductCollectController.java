package com.cen.appsite.products.controller;

import com.cen.ProductCollect.entity.ProductCollect;
import com.cen.ProductCollect.service.ProductCollectService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ResData;
import com.cen.common.util.ReturnInfoType;
import com.cen.product.entity.Product;
import com.cen.product.service.ProductService;
import com.cen.ucenter.entity.User;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/appsite/productCollect")
public class AppProductCollectController extends BaseController {

    @Autowired
    ProductCollectService<ProductCollect> productCollectService;
    @Autowired
    ProductService productService;


    /**
    * 分页查询列表
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/selectList",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String selectList(Integer pageNum,HttpServletRequest request,HttpServletResponse response){
        Map<String, Object> rMap = new HashMap<String, Object>();
        User user = getUser(request);
        if(user == null){
            rMap.put("msg","请先登录");
            rMap.put("status",ReturnInfoType.FAIL);
            return toJSONString(rMap);
        }

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("uId",user.getId());
        // 此处查询需要自行编写
        PageHelper.startPage(getPageNum2(pageNum),pageSize);
        List<ProductCollect> lists = productCollectService.selectList(paramMap);
        List<Product> rList = new ArrayList<>();

        for (ProductCollect p : lists){
            Product product = productService.selectByPrimaryKey(p.getPId());
            rList.add(product);
        }
        PageInfo<ProductCollect>  p2 = new PageInfo<ProductCollect>(lists);
        rMap.put("pageNum", p2.getPageNum()); //  当前页
        rMap.put("pages", p2.getPages()); //  总页数
        rMap.put("nextPage", p2.getNextPage()); // 下一页
        rMap.put("prePage", p2.getPrePage()); // 上一页
        rMap.put("data", rList); // 数据集合
        rMap.put("count", p2.getTotal()); // 总行数
        PageHelper.clearPage(); // 如果开启分页，必须调用清除
        return ResData.SUCCESS(rMap).toString();
    }

}