package com.cen.ucenter.util;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.cen.common.util.DateUtil;

/** 还要更更安全,比如用户的设备deviceid。
 如果我们在调用接口时，还附带一个当前时间戳参数timestamp，
 同时，用deviceid和这个时间戳再生成一个参数sign，比如 md5(deviceid timestamp token)这样的形式。
 而服务端首先验证一下参数中的时间戳与当前服务器时间是否一致（误差保持在合理范围内即可，比如5分钟），
 然后根据用户保存在服务器中的deviceid来对参数中的时间戳进行相同的变形，验证是否匹配，那便自然“更安全”了。
 */
public class JwtUtil {

    private String loginName ; // 登录名

    private String secret = "cfw&!sce8*"; // 秘钥

    public String getLoginName() {
        return loginName;
    }


    /**
     * 创建 token
     * @param loginName 登录名
     * @param expires 有效时间（秒）
     * @return
     */
    public String createToken(String loginName,int expires) {

        try {

            Algorithm algorithm = Algorithm.HMAC256(this.secret);
            //头部信息
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("alg", "HS256");
            map.put("typ", "JWT");

            Date nowDate = new Date();
            Date expireDate = DateUtil.getAfterDate(nowDate, 0, 0, 0, 0, 0, expires);

            String token = JWT.create()
                    /*设置头部信息 Header*/
                    .withHeader(map)
                    /*设置 载荷 Payload*/
                    .withClaim("loginName", loginName)
                    .withIssuer("CFramework")//签名是有谁生成 例如 服务器
                    .withSubject("this is auto token")//签名的主题
                    //.withNotBefore(new Date())//定义在什么时间之前，该jwt都是不可用的.
                    .withAudience("APP")//签名的观众 也可以理解谁接受签名的
                    .withIssuedAt(nowDate) //生成签名的时间
                    .withExpiresAt(expireDate)//签名过期的时间
                    /*签名 Signature */
                    .sign(algorithm);
            return token;
        } catch (JWTCreationException exception) {
            exception.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        return null;

    }

    /**
     * 校验 token
     * @return  true 过期， false 未过期
     */
    public boolean verify(String token) {

        try {
            Algorithm algorithm = Algorithm.HMAC256(this.secret);
            JWTVerifier verifier = JWT.require(algorithm)
                    .withIssuer("CFramework")
                    .build(); //Reusable verifier instance
            DecodedJWT jwt = verifier.verify(token);

            // 获取信息
            String subject = jwt.getSubject();
            this.loginName = jwt.getClaim("loginName").asString(); // 登录名
            //this.isExpires = jwt.getExpiresAt().before(new Date());  // 判断是否过期

            return false;
        }  catch (Exception e) {
            //e.printStackTrace();
            return true;
        }

    }
    /**
     * 根据token获取用户名
     * @param token
     * @return
     */
    public String getLoginName(String token) {
        try {
            Algorithm algorithm = Algorithm.HMAC256(this.secret);
            JWTVerifier verifier = JWT.require(algorithm)
                    .withIssuer("CFramework")
                    .build(); //Reusable verifier instance
            DecodedJWT jwt = verifier.verify(token);
            return jwt.getClaim("loginName").asString();
        }  catch (Exception e) {
            //e.printStackTrace();
            return null;
        }
    }


    public static void main(String[] args) {
        String createToken = new JwtUtil().createToken("cfw",5);
        System.out.println("token:"+createToken);

        JwtUtil jwt = new JwtUtil();
        System.out.println("是否过期:"+jwt.verify(createToken));
        System.out.println("登录名:"+jwt.getLoginName());

    }


}

