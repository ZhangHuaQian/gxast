package com.cen.news.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.activiti.engine.impl.util.json.JSONObject;

public class TextAudit {
	// public static void main(String[] args)
	// {
	// Text m = new Text();
	// //System.out.println(m.gettoken());
	// // String access_token=m.gettoken();
	// // System.out.println(access_token);
	// String access_token =
	// "24.a33bf8a26581d36166590eedc031db2d.2592000.1536135175.282335-11638517";
	// try {
	// m.get_text("傻逼", "https://aip.baidubce.com/rest/2.0/antispam/v2/spam",
	// access_token);
	// } catch (Exception e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// }
	// }
	// 文本审核
	public static String Text_Audit(String content) {
		/*TextAudit t = new TextAudit();

		String access_token = t.gettoken();
		System.out.println(access_token);
		String text = t.get_text(content, "https://aip.baidubce.com/rest/2.0/antispam/v2/spam", access_token);*/
		String string= "{'result': {'spam': 0,'reject': [],'review': [],'pass': [{'label':1,'score':0.3,'hit':[]},{'label':2,'score':0.33,'hit':[]},{'label':3,'score':0.2,'hit':[]}, {'label':4,'score':0.31,'hit':[]}, {'label':5,'score':0.19,'hit':[]}, ]},'log_id': 5284009342430354247}";
		return string;
	}

	public String gettoken() {

		// 官网获取的 API Key 更新为你注册的
		String clientId = "AfotanPYZhqNG69271iyuYwq";
		// 官网获取的 Secret Key 更新为你注册的
		String clientSecret = "zKsjC00okxB8uVIFVcDdvueZKcUzXRu6";
		return getAuth(clientId, clientSecret);
	}

	public static String getAuth(String ak, String sk) {
		//
		String authHost = "https://aip.baidubce.com/oauth/2.0/token?";
		String getAccessTokenUrl = authHost
				// 1. grant_type为固定参数
				+ "grant_type=client_credentials"
				// 2. 官网获取的 API Key
				+ "&client_id=" + ak
				// 3. 官网获取的 Secret Key
				+ "&client_secret=" + sk;
		try {
			URL realUrl = new URL(getAccessTokenUrl);
			// 打开和URL之间的连接
			HttpURLConnection connection = (HttpURLConnection) realUrl.openConnection();
			connection.setRequestMethod("GET");
			connection.connect();
			// 获取所有响应头字段
			// Map<String, List<String>> map = connection.getHeaderFields();
			// 定义 BufferedReader输入流来读取URL的响应
			BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String result = "";
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
			/**
			 * 返回结果示例
			 */
			JSONObject jsonObject = new JSONObject(result);
			String access_token = jsonObject.getString("access_token");
			return access_token;
		} catch (Exception e) {
			System.err.printf("获取token失败！");
			e.printStackTrace(System.err);
		}
		return null;
	}

	public String get_text(String content, String url, String accessToken) {
		String param;
		String data = null;
		try {
			// 设置请求的编码
			param = "content=" + URLEncoder.encode(content, "UTF-8");
			// 发送并取得结果
			data = HttpUtil.post(url, accessToken, param);
			// System.out.println(data);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return data;
	}
}
