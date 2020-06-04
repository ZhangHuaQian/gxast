package com.cen.appsite.wxpay.controller;

import java.awt.image.BufferedImage;
import java.io.*;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cen.appsite.wxpay.util.*;
import com.cen.common.controller.BaseController;
import com.cen.common.util.ReturnInfoType;
import com.cen.order.entity.order;
import com.cen.order.service.orderService;
import com.cen.shopcar.entity.shopcar;
import com.cen.shopcar.service.ShopcarService;
import com.cen.ucenter.entity.User;
import com.google.zxing.EncodeHintType;
import org.apache.commons.lang.StringUtils;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/wx")
public class WxPayController extends BaseController {

    public static Logger logger = LoggerFactory.getLogger(WxPayController.class);

    @Autowired
    private orderService orderService;
    @Autowired
    ShopcarService ShopcarService;

    //微信支付接口
    @RequestMapping(value = "/wxPay")
    public void wxPay(String orderId, String[] orderIdList, String way, HttpServletResponse response) throws Exception {

        Map<String, Object> map = setWeChatParams(orderId, orderIdList, way);
        WeChatParams ps = (WeChatParams) map.get("ps");
        //设置支付二维码过期时间2分钟
        Calendar now=Calendar.getInstance();
        now.add(Calendar.MINUTE,2);
        SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmss");
        ps.setTime_expire(sdf.format(now.getTimeInMillis()));

        Map<String, String> urlCode = getCodeUrl(ps);
        try {
            int width = 300;
            int height = 300;
            //二维码的图片格式
            String format = "gif";
            Hashtable hints = new Hashtable();
            //内容所使用编码
            hints.put(EncodeHintType.CHARACTER_SET, "utf-8");
            BitMatrix bitMatrix;
            bitMatrix = new MultiFormatWriter().encode(urlCode.get("urlCode"), BarcodeFormat.QR_CODE, width, height, hints);
            QRUtil.writeToStream(bitMatrix, format, response.getOutputStream());

            if(way.equals("buynow")){
                //保存订单号
                order order = (order) map.get("order");
                order.setOutTradeNo(urlCode.get("out_trade_no"));
                orderService.updateByPrimaryKeySelective(order);

            }else if(way.equals("car")){
                //保存订单号
                List<order> orderList = (List<order>) map.get("orderList");
                for (order order : orderList) {
                    order.setOutTradeNo(urlCode.get("out_trade_no"));
                    orderService.updateByPrimaryKeySelective(order);
                }
            }

        } catch (WriterException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }


    private Map<String, Object> setWeChatParams(String orderId, String[] orderIdList, String way){
        Map<String, Object> rMap = new HashMap<>();
        WeChatParams ps = new WeChatParams();
        if(way.equals("buynow")){  //单件立即购买
            order order = orderService.selectByPrimaryKey(orderId);
            if(order == null){
                throw new  RuntimeException("订单不存在");
            }
            if(!order.getStatus().equals(0) && !order.getStatus().equals(5)){ //0-待付款，5-支付失败
                throw new  RuntimeException("订单已支付");
            }
            shopcar shopcar = ShopcarService.selectByPrimaryKey(order.getShopcarId());
            if(shopcar == null){
                throw new  RuntimeException("订单信息不存在");
            }
            ps.setBody(shopcar.getName());
            ps.setAttach("广西科普传播中心");
            ps.setOut_trade_no(orderId);
//        BigDecimal num = new BigDecimal((shopcar.getNumber() * 100));
//        BigDecimal multiply = num.multiply(shopcar.getPrice());
//        ps.setTotal_fee(multiply.stripTrailingZeros().toPlainString());  //订单金额，单位：分
            /** del  **********/
            ps.setTotal_fee("1");
            /** del  **********/
            rMap.put("ps", ps);
            rMap.put("order", order);
        }else if(way.equals("car")){
            int count = 0;
            StringBuffer sb = new StringBuffer();
            BigDecimal price = new BigDecimal(0);
            List<order> orderList = new ArrayList<>();
            for (String rId : orderIdList) {
                order order = orderService.selectByPrimaryKey(rId);
                if(order == null){
                    throw new  RuntimeException("订单不存在");
                }
                if(!order.getStatus().equals(0) && !order.getStatus().equals(5)){ //0-待付款，5-支付失败
                    throw new  RuntimeException("订单已支付");
                }
                shopcar shopcar = ShopcarService.selectByPrimaryKey(order.getShopcarId());
                if(shopcar == null){
                    throw new  RuntimeException("订单信息不存在");
                }

                BigDecimal num = new BigDecimal((shopcar.getNumber() * 100));
                BigDecimal multiply = num.multiply(shopcar.getPrice());
                price = price.add(multiply);

                if(count < 2){
                    sb.append(shopcar.getName());
                    sb.append("|");
                }else if(count == 3){
                    sb.append("...");
                }
                count++;
                orderList.add(order);
            }

            ps.setBody(sb.toString());
            ps.setAttach("广西科普传播中心");
            ps.setOut_trade_no(orderIdList[0]);

//            ps.setTotal_fee(price.stripTrailingZeros().toPlainString());  //订单金额，单位：分

            /** del ******************/
                ps.setTotal_fee("1");
            /** del ******************/
            rMap.put("ps", ps);
            rMap.put("orderList", orderList);
        }
        return rMap;
    }

    /**
     * 获取微信支付的二维码地址
     *
     * @return
     * @throws Exception
     * @author chenp
     */
    public static Map<String, String> getCodeUrl(WeChatParams ps) throws Exception {
        /**
         * 账号信息
         */
        String appid = WeChatConfig.APPID;//微信服务号的appid
        String mch_id = WeChatConfig.MCHID; //微信支付商户号
        String key = WeChatConfig.APIKEY; // 微信支付的API密钥
        String notify_url = WeChatConfig.WECHAT_NOTIFY_URL_PC;//回调地址【注意，这里必须要使用外网的地址】
        String ufdoder_url = WeChatConfig.UFDODER_URL;//微信下单API地址
        String trade_type = "NATIVE"; //类型【网页扫码支付】

        /**
         * 时间字符串
         */
        String currTime = PayForUtil.getCurrTime();
        String strTime = currTime.substring(8, currTime.length());
        String strRandom = PayForUtil.buildRandom(4) + "";
        String nonce_str = strTime + strRandom;

        /**
         * 参数封装
         */
        SortedMap<Object, Object> packageParams = new TreeMap<Object, Object>();
        packageParams.put("appid", appid);
        packageParams.put("mch_id", mch_id);
        packageParams.put("nonce_str", nonce_str);//随机字符串
        packageParams.put("body", ps.body);//支付的商品名称
//        packageParams.put("out_trade_no", ps.out_trade_no + nonce_str);//商户订单号【备注：每次发起请求都需要随机的字符串，否则失败。】
        packageParams.put("out_trade_no", ps.out_trade_no.substring(0,20) + nonce_str);//商户订单号【备注：每次发起请求都需要随机的字符串，否则失败。】
        packageParams.put("total_fee", ps.total_fee);//支付金额
        packageParams.put("attach", ps.attach);//订单额外描述
        packageParams.put("spbill_create_ip", PayForUtil.localIp());//客户端主机
        packageParams.put("notify_url", notify_url);
        packageParams.put("trade_type", trade_type);
        packageParams.put("time_expire", ps.getTime_expire());


        String sign = PayForUtil.createSign("UTF-8", packageParams, key);  //获取签名
        packageParams.put("sign", sign);

        String requestXML = PayForUtil.getRequestXml(packageParams);//将请求参数转换成String类型
//        logger.info("微信支付请求参数的报文" + requestXML);
        String resXml = WxHttpUtil.postData(ufdoder_url, requestXML);  //解析请求之后的xml参数并且转换成String类型
        Map map = XMLUtil.doXMLParse(resXml);
//        logger.info("微信支付响应参数的报文" + resXml);
        String urlCode = (String) map.get("code_url");

        Map<String, String> rMap = new HashMap<>();
        rMap.put("urlCode", urlCode);
        rMap.put("out_trade_no", ps.out_trade_no.substring(0,20) + nonce_str);
        return rMap;
    }


    /**
     * pc端微信支付之后的回调方法
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value="wechat_notify_url_pc",method=RequestMethod.POST)
    public void wechat_notify_url_pc(HttpServletRequest request, HttpServletResponse response) throws Exception{

        //读取参数
        InputStream inputStream ;
        StringBuffer sb = new StringBuffer();
        inputStream = request.getInputStream();
        String s ;
        BufferedReader in = new BufferedReader(new InputStreamReader(inputStream, "UTF-8"));
        while ((s = in.readLine()) != null){
            sb.append(s);
        }
        in.close();
        inputStream.close();

        //解析xml成map
        Map<String, String> m = new HashMap<String, String>();
        m = XMLUtil.doXMLParse(sb.toString());

        //过滤空 设置 TreeMap
        SortedMap<Object,Object> packageParams = new TreeMap<Object,Object>();
        Iterator<String> it = m.keySet().iterator();
        while (it.hasNext()) {
            String parameter = it.next();
            String parameterValue = m.get(parameter);

            String v = "";
            if(null != parameterValue) {
                v = parameterValue.trim();
            }
            packageParams.put(parameter, v);
        }
        // 微信支付的API密钥
        String key = WeChatConfig.APIKEY; // key

        logger.info("微信支付返回回来的参数："+packageParams);
        //判断签名是否正确
        if(PayForUtil.isTenpaySign("UTF-8", packageParams,key)) {
            //------------------------------
            //处理业务开始
            //------------------------------
            String resXml = "";
            if("SUCCESS".equals((String)packageParams.get("result_code"))){
                // 这里是支付成功
                //执行自己的业务逻辑开始
                String app_id = (String)packageParams.get("appid");
                String mch_id = (String)packageParams.get("mch_id");
                String openid = (String)packageParams.get("openid");
                String is_subscribe = (String)packageParams.get("is_subscribe");//是否关注公众号

                //附加参数【商标申请_0bda32824db44d6f9611f1047829fa3b_15460】--【业务类型_会员ID_订单号】
                String attach = (String)packageParams.get("attach");
                //商户订单号
                String out_trade_no = (String)packageParams.get("out_trade_no");
                //付款金额【以分为单位】
                String total_fee = (String)packageParams.get("total_fee");
                //微信生成的交易订单号
                String transaction_id = (String)packageParams.get("transaction_id");//微信支付订单号
                //支付完成时间
                String time_end=(String)packageParams.get("time_end");

//                logger.info("app_id:"+app_id);
//                logger.info("mch_id:"+mch_id);
//                logger.info("openid:"+openid);
//                logger.info("is_subscribe:"+is_subscribe);
//                logger.info("out_trade_no:"+out_trade_no);
//                logger.info("total_fee:"+total_fee);
//                logger.info("额外参数_attach:"+attach);
//                logger.info("time_end:"+time_end);

                //执行自己的业务逻辑结束
                logger.info("支付成功");
                //通知微信.异步确认成功.必写.不然会一直通知后台.八次之后就认为交易失败了.
                resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>"
                        + "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";

                //状态;0-待付款，1-待发货，2-发货中，3-已完成，4-已完成并评价,5-支付失败
                SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmmss");
                order order = orderService.selectByOutTradeNo(out_trade_no);
                order.setOpenid(openid);
                order.setStatus(1);
                order.setTotal_fee(Double.valueOf(total_fee) / 100);
                order.setTime_end(sf.parse(time_end));
                orderService.updateByPrimaryKey(order);

            } else {
                logger.info("支付失败,错误信息：" + packageParams.get("err_code"));
                resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>"
                        + "<return_msg><![CDATA[报文为空]]></return_msg>" + "</xml> ";
            }
            //------------------------------
            //处理业务完毕
            //------------------------------
            BufferedOutputStream out = new BufferedOutputStream(
                    response.getOutputStream());
            out.write(resXml.getBytes());
            out.flush();
            out.close();
        } else{
            logger.info("通知签名验证失败");
        }

    }


    /**
     * 检查订单是否成功
     * @return
     */
    @RequestMapping(value = "/checkOrder", method = RequestMethod.POST)
    @ResponseBody
    public String checkOrder(String orderId, HttpServletRequest request){
        Map<String, Object> rMap = new HashMap<>();
        User user = getUser(request);
        if(user == null){
            rMap.put("msg", "未登录");
            rMap.put("status", -1);
            return toJSONString(rMap);
        }

        order order = orderService.selectByPrimaryKey(orderId);
        if(order == null){
            rMap.put("msg", "获取订单信息异常");
            rMap.put("status", -1);
            return toJSONString(rMap);
        }

        rMap.put("msg", "获取订单信息成功");
        rMap.put("status", order.getStatus());

        return toJSONString(rMap);
    }

}

