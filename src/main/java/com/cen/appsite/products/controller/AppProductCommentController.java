package com.cen.appsite.products.controller;

import com.cen.ProductComment.entity.ProductComment;
import com.cen.ProductComment.service.ProductCommentService;
import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ResData;
import com.cen.common.util.ReturnInfoType;
import com.cen.order.entity.order;
import com.cen.order.service.orderService;
import com.cen.product.entity.Product;
import com.cen.product.service.ProductService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

@Controller
@RequestMapping("/appsite/productComment")
public class AppProductCommentController extends BaseController {

    @Autowired
    ProductCommentService<ProductComment> productCommentService;
    @Autowired
    private UserService userService;
    @Autowired
    private ProductService productService;

    /**
    * 分页查询列表-- 商品评论列表
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/selectByPid",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String selectList(ProductComment productComment,Integer pageNum,HttpServletRequest request,HttpServletResponse response){
        Map<String, Object> rMap = new HashMap<String, Object>();

        productComment.setVerify(1); // 1-审核通过
        // 此处查询需要自行编写
        PageHelper.startPage(getPageNum2(pageNum),pageSize);
        List<ProductComment> lists = productCommentService.selectBypId(productComment);
        int total = productCommentService.selectCountBypId(productComment);
        for(ProductComment p : lists){
            User user = userService.selectByPrimaryKey(p.getUId());
            Map<String,Object> map = new HashMap<>();
            String uId = user.getId();
            if(uId.length()>20){
                map.put("id",uId.substring(0,5)+"******"+uId.substring(20));
            }else{
                map.put("id",uId);
            }
            map.put("photo",user.getPhoto());
            p.setUser(map);
            p.setOrderId(null);
            p.setUId(null);
            p.setUName(null);
        }
        PageInfo<ProductComment>  p2 = new PageInfo<ProductComment>(lists);
        rMap.put("pageNum", p2.getPageNum()); //  当前页
        rMap.put("pages", p2.getPages()); //  总页数
        rMap.put("nextPage", p2.getNextPage()); // 下一页
        rMap.put("prePage", p2.getPrePage()); // 上一页
        rMap.put("data", p2.getList()); // 数据集合
        rMap.put("count", p2.getTotal()); // 总行数： 好 || 中 ||差
        rMap.put("total",total);// 总评论数：好+中+差
        PageHelper.clearPage(); // 如果开启分页，必须调用清除
        return ResData.SUCCESS(rMap).toString();
    }

    /**
     * 分页查询列表 -- 用户评论列表
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value="/selectUid",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String selectUid(Integer pageNum,HttpServletRequest request,HttpServletResponse response){
        Map<String, Object> rMap = new HashMap<String, Object>();

        User user = getUser(request);
        if(user == null){
            rMap.put("msg","请先登录");
            rMap.put("status",ReturnInfoType.FAIL);
            return toJSONString(rMap);
        }
        Map<String,Object> param = new HashMap<>();
//        param.put("verify",1);// 1-审核通过
        param.put("uId",user.getId());
        // 此处查询需要自行编写
        PageHelper.startPage(getPageNum2(pageNum),pageSize);
        List<ProductComment> lists = productCommentService.selectList(param);
        List<Product> pList = new ArrayList<>();
        for(ProductComment p : lists){
            Product product = productService.selectByPrimaryKey(p.getPId());
            pList.add(product);
        }

        PageInfo<ProductComment>  p2 = new PageInfo<ProductComment>(lists);
        rMap.put("pageNum", p2.getPageNum()); //  当前页
        rMap.put("pages", p2.getPages()); //  总页数
        rMap.put("nextPage", p2.getNextPage()); // 下一页
        rMap.put("prePage", p2.getPrePage()); // 上一页
        rMap.put("data", p2.getList()); // 数据集合
        rMap.put("pList",pList);    //商品信息列表
        rMap.put("count", p2.getTotal()); // 总行数： 好 || 中 ||差
        PageHelper.clearPage(); // 如果开启分页，必须调用清除
        return ResData.SUCCESS(rMap).toString();
    }

}