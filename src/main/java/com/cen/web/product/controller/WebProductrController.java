package com.cen.web.product.controller;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.cen.ProductCollect.entity.ProductCollect;
import com.cen.ProductCollect.service.ProductCollectService;
import com.cen.common.util.ResData;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.activiti.engine.impl.event.logger.handler.Fields;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.cen.common.controller.BaseController;
import com.cen.common.util.MapUtils;
import com.cen.common.util.ReturnInfoType;
import com.cen.dictionary.service.DictionaryService;
import com.cen.news.entity.News;
import com.cen.product.entity.Product;
import com.cen.product.entity.specifications;
import com.cen.product.service.ProductService;
import com.cen.ucenter.entity.User;
import com.cen.ucenter.service.UserService;
import com.cen.upms.service.DepartmentService;

@Controller
@RequestMapping(value="/web/product")
public class WebProductrController extends BaseController{
	
	@Autowired
	private ProductService productService;
	@Autowired
	private DictionaryService DictionaryService;
	@Autowired
	private UserService UserService;
	@Autowired
	ProductCollectService<ProductCollect> productCollectService;
	/**
	 * 分页查询
	 * @param product
	 * @param pageNum
	 * @param request
	 * @param response
	 * @param map
	 * @return  
	 * @throws ParseException
	 */
	@RequestMapping(value="/SelectList",method=RequestMethod.GET)
	public String SelectList(Product product,Integer pageNum,Integer pageSize,HttpServletRequest request,
			HttpServletResponse response,ModelMap map) throws ParseException{	
		Map<String, Object> pmap = new HashMap<String, Object>();
		pmap.put("name", product.getName());
		pmap.put("up", 1);
		pmap.put("pageNum", (pageNum-1)*pageSize);
		pmap.put("pageSize", pageSize);
		pmap.put("switch", 1);     
		
		List<Product> list = productService.selectList(pmap);  //列表
		int count = productService.selectListCount(pmap);  //列表数
		
		List<BigDecimal> prList =new ArrayList<BigDecimal>();
		for (int i = 0; i < list.size(); i++) {
				List<specifications> List = JSON.parseArray(list.get(i).getSpecifications(), specifications.class);
				prList.add(List.get(0).getPrice());
		}
		
		pmap.put("name", null);                        
		pmap.put("pageNum", 0);
		pmap.put("pageSize", 10);
		pmap.put("browse", 1);           
		List<Product> list2 = productService.selectList(pmap);  //列表
		
		if(!isEmpty(list)) {
			map.put("list", list);
			map.put("prList", prList);    
		}
		map.put("recommend", list2);
		map.put("count", count);
		map.put("pagenum", count/pageSize);       
		return "web/product/list";
	}   
	
	/**
	 * 商城首页
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(value="/home",method=RequestMethod.GET)
	public String home(HttpServletRequest request,HttpServletResponse response,ModelMap map) throws ParseException{	
		Map<String, Object> pmap = new HashMap<String, Object>();
		pmap.put("up", 1);
		pmap.put("pageNum", 0); 
		pmap.put("pageSize", pageSize);
		pmap.put("switch", 1);     
		pmap.put("type", "22");   
		List<Product> list = productService.selectList(pmap);  //列表
		int count = productService.selectListCount(pmap);  //列表数
		map.put("xbsb", list);
		map.put("xbsb_count", count);
		
		pmap.put("type", "59");   //家庭医药
		List<Product> list2 = productService.selectList(pmap);  //列表
		count = productService.selectListCount(pmap);  //列表数
		map.put("jtyy", list2);
		map.put("jtyy_count", count);
		
		pmap.put("type", "60");   //南方科技
		List<Product> list3 = productService.selectList(pmap);  //列表
		count = productService.selectListCount(pmap);  //列表数
		map.put("nfkj", list3);
		map.put("nfkj_count", count);



		//热门推荐-小博士报
		pmap.put("pageNum", 0);
		pmap.put("pageSize", 5);
		pmap.put("sales", 1);//销量排序
		pmap.put("up", 1);
		pmap.put("type",22);//小博士报
		List<Product> list4 = productService.selectList(pmap);  //列表
//		List<BigDecimal> prList =new ArrayList<BigDecimal>();
//		for (int i = 0; i < list4.size(); i++) {
//			List<specifications> List = JSON.parseArray(list4.get(i).getSpecifications(), specifications.class);
//			prList.add(List.get(0).getPrice());
//		}
		map.put("recommend_xbsb", list4);

		//热门推荐-南方科技报
		pmap.put("type",60);//南方科技报
		List<Product> list5 = productService.selectList(pmap);  //列表
		map.put("recommend_nfkj", list5);

		//热门推荐-家庭医药
		pmap.put("type",59);//家庭医药
		List<Product> list6 = productService.selectList(pmap);  //列表
		map.put("recommend_jtyy", list6);

		return "web/product/list";
	}

	@RequestMapping(value = "/productSearch")
	@ResponseBody
	public String productSearch(String key,Integer pageNum,Integer type){

		Map<String,Object> rMap = new HashMap<>();

//		// 此处查询需要自行编写
		PageHelper.startPage(getPageNum2(pageNum),pageSize);
		Map<String ,Object> paramMap = new HashMap<>();
		paramMap.put("name",key);
		paramMap.put("type",type);
		List<Product> lists = productService.selectList(paramMap);
		PageInfo<Product> p2 = new PageInfo<Product>(lists);
		rMap.put("pageNum", p2.getPageNum()); //  当前页
		rMap.put("pages", p2.getPages()); //  总页数
		rMap.put("nextPage", p2.getNextPage()); // 下一页
		rMap.put("prePage", p2.getPrePage()); // 上一页
		rMap.put("count", p2.getTotal()); // 总行数
		rMap.put("data", p2.getList()); // 数据集合
		PageHelper.clearPage(); // 如果开启分页，必须调用清除
		return toJSONString(rMap);
	}
	
	/**
	 * 查看商品信息
	 * @param id
	 * @param request
	 * @param response
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/select", method = RequestMethod.GET)
	@ResponseBody
	public String selectById(String id, HttpServletRequest request, HttpServletResponse response,ModelMap map) {
		Map<String, Object> smap = new HashMap<String, Object>();
		Product product = productService.selectByPrimaryKey(id);
		
		if (!isEmpty(product)){  
			List<specifications> List = JSON.parseArray(product.getSpecifications(), specifications.class);  
			smap.put("type",DictionaryService.selectByPrimaryKey(Integer.parseInt(product.getType())).getName());
			smap.put("product", product);
			smap.put("specifications", List);   
			smap.put("slide", product.getSlide().split(","));      
		}
		return toJSONString(smap);
	}
	
	/**
     * 查询资讯详情
     * @param request
     * @param response
     * @param map
     * @return
     */
    @RequestMapping(value="details/{id}")
    public String details(@PathVariable String id, HttpServletRequest request,
                          HttpServletResponse response, ModelMap map) {
    	Map<String, Object> pmap = new HashMap<String, Object>();
    	Product product = productService.selectByPrimaryKey(id);
    	HttpSession session = request.getSession();
		User user = getUser(request);
		if (user != null) {
			if(session.getAttribute("product@"+user.getId()+"@"+id)==null){
				int count= product.getBrowse();
				product.setBrowse(count+1);
				productService.updateByPrimaryKeySelective(product);
				session.setMaxInactiveInterval(5*60);//设置5分钟
				session.setAttribute("product@"+user.getId()+"@"+id, "product@"+user.getId()+"@"+id);
			}

			//查询用户是否收藏该商品
			ProductCollect productCollect = productCollectService.selectByUidAndPid(user.getId(), id);
			if(productCollect != null){
				//已收藏
				map.put("star",1);
			}
		}
		
		
		pmap.put("pageNum", 0);
		pmap.put("pageSize", 3);
		pmap.put("sales", 1);//销量排序
		pmap.put("up", 1);
		
		List<Product> list2 = productService.selectList(pmap);  //列表
		List<BigDecimal> prList =new ArrayList<BigDecimal>();
		for (int i = 0; i < list2.size(); i++) {
				List<specifications> List = JSON.parseArray(list2.get(i).getSpecifications(), specifications.class);
				prList.add(List.get(0).getPrice());
		}
		map.put("recommend", list2);
		map.put("prList", prList);    
		
    	List<specifications> List = JSON.parseArray(product.getSpecifications(), specifications.class);


        map.put("product", product); 
        map.put("type",product.getName());
        map.put("specifications", List);  
        map.put("slide", product.getSlide().split(","));              
        return "/web/product/details";   
    }
	/**
	 * 日期转化器
	 * @param binder
	 */
	@InitBinder
	public void transferToDate(WebDataBinder binder){
	binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"),true));
	}
	
	
}
