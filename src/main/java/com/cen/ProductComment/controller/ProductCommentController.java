package com.cen.ProductComment.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cen.order.entity.order;
import com.cen.order.service.orderService;
import com.cen.product.entity.Product;
import com.cen.product.service.ProductService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cen.common.controller.BaseController;
import com.cen.common.util.*;
import com.cen.ucenter.entity.User;
import com.cen.ProductComment.service.ProductCommentService;
import com.cen.ProductComment.entity.ProductComment;

@Controller
@RequestMapping("/sys/productComment")
public class ProductCommentController extends BaseController {

    @Autowired
    ProductCommentService<ProductComment> productCommentService;

    @Autowired
    private orderService orderService;

    @Autowired
    private ProductService productService;

    /**
    * 添加
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/insert",produces = "application/json;charset=utf-8",method = RequestMethod.POST)
    @ResponseBody
    @Transactional
    public String insert(ProductComment productComment,HttpServletRequest request,HttpServletResponse response){
        Map<String,Object> rMap = new HashMap<>();
        rMap.put("msg","评价失败");
        rMap.put("status",ReturnInfoType.FAIL);
        User user = getUser(request);
        if(user == null){
            rMap.put("msg","请先登录");
            rMap.put("status",ReturnInfoType.FAIL);
            return toJSONString(rMap);
        }

        order order = orderService.selectByPrimaryKey(productComment.getOrderId());
        if(order == null || order.getStatus().equals(4)){
            //订单号不存在或已经评论过
            return toJSONString(rMap);
        }
        productComment.setPId(order.getProductId());
        productComment.setUId(user.getId());
        productComment.setUName(user.getName());
        productComment.setCreateTime(new Date());
        int res = productCommentService.insertSelective(productComment);

        order.setStatus(4);//设置订单为已评论状态
        int res2 = orderService.updateByPrimaryKeySelective(order);

        if(res >0 && res2 > 0){
            rMap.put("msg","评价成功");
            rMap.put("status",ReturnInfoType.SUCEEESS);
        }
        return toJSONString(rMap);
    }

    /**
    * 删除
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/delete",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String delete(Integer id,HttpServletRequest request,HttpServletResponse response){
        int res = productCommentService.deleteByPrimaryKey(id);
        return res>=1?ResData.SUCCESS().toString():ResData.FAIL().toString();
    }

    /**
    * 更新
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/update",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String update(ProductComment productComment,HttpServletRequest request,HttpServletResponse response){
        int res = productCommentService.updateByPrimaryKeySelective(productComment);
        return res>=1?ResData.SUCCESS().toString():ResData.FAIL().toString();
    }

    /**
    * 查询
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/select",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String select(Integer id,HttpServletRequest request,HttpServletResponse response){
        ProductComment res = productCommentService.selectByPrimaryKey(id);
        return ResData.SUCCESS(res).toString();
    }

    /**
     * 通过订单id查询
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value="/selectByOrderIdAndUid",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String selectByOrderId(ProductComment productComment,HttpServletRequest request,HttpServletResponse response){
        Map<String,Object> rMap = new HashMap<>();
        User user = getUser(request);
        if(user == null){
            rMap.put("msg","请先登录");
            rMap.put("status",ReturnInfoType.FAIL);
        }
        productComment.setUId(user.getId());
        ProductComment result = productCommentService.selectByOrderIdAndUid(productComment);
        return ResData.SUCCESS(result).toString();
    }

    /**
    * 分页查询列表
    * @param request
    * @param response
    * @return
    */
    @RequestMapping(value="/selectList",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String selectList(ProductComment productComment,Integer pageNum,String startTime,String endTime,HttpServletRequest request,HttpServletResponse response){
        Map<String, Object> rMap = new HashMap<String, Object>();
        Map<String, Object> paramMap = MapUtils.beanToMap(productComment);
        if(!startTime.equals("")){
            startTime = startTime + " 00:00:00";
            paramMap.put("startTime",startTime);
        }
        if(!endTime.equals("")){
            endTime = endTime + " 23:59:59";
            paramMap.put("endTime",endTime);
        }
        // 此处查询需要自行编写
        PageHelper.startPage(getPageNum2(pageNum),pageSize);
        List<ProductComment> lists = productCommentService.selectList(paramMap);

        for(ProductComment p : lists){
            Product product = productService.selectByPrimaryKey(p.getPId());
            p.setpName(product.getName());
        }
        PageInfo<ProductComment>  p2 = new PageInfo<ProductComment>(lists);
        rMap.put("pageNum", p2.getPageNum()); //  当前页
        rMap.put("pages", p2.getPages()); //  总页数
        rMap.put("nextPage", p2.getNextPage()); // 下一页
        rMap.put("prePage", p2.getPrePage()); // 上一页
        rMap.put("data", p2.getList()); // 数据集合
        rMap.put("count", p2.getTotal()); // 总行数
        PageHelper.clearPage(); // 如果开启分页，必须调用清除
        return ResData.SUCCESS(rMap).toString();
    }

    /**
     * 审核
     * @param productComment
     * @return
     */
    @RequestMapping(value = "/verify",method = RequestMethod.POST)
    @ResponseBody
    public String verify(ProductComment productComment){
        Map<String,Object> rMap = new HashMap<>();
        int res = productCommentService.updateByPrimaryKeySelective(productComment);
        if(res > 0){
            rMap.put("msg","操作成功");
            rMap.put("status",ReturnInfoType.SUCEEESS);
        }else {
            rMap.put("msg","操作失败");
            rMap.put("status",ReturnInfoType.FAIL);
        }
        return toJSONString(rMap);
    }

}