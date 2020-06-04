package com.cen.common.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.channels.FileChannel;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.imageio.stream.ImageOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;

/**
 * @author cenguocheng E-mail:137544496@qq.com
 * @version 创建时间：2018年5月12日
 * 
 */
public class ImageUtil {
	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	/**
	 * 图片上传 
	 * @param file 文件
	 * @param path 存放路径
	 * @return 图片名称
	 */
	public static String imgFileUpload(MultipartFile file,String path) {
		String mkdirs_data = DateUtil.getThisSysTimeYMD_FILE();
		// 判断路径是否存在/创建
		File baseFath_f = new File(path+mkdirs_data);
		if (!baseFath_f.exists()) {
			baseFath_f.mkdirs();
		}

		String trueFileName = "";
	        if (file!=null) {// 判断上传的文件是否为空
	            String type=null;// 文件类型
	            String fileName=file.getOriginalFilename();// 文件原名称
	            // 判断文件类型
	            type=fileName.indexOf(".")!=-1?fileName.substring(fileName.lastIndexOf(".")+1, fileName.length()):null;
	            if (type!=null) {// 判断文件类型是否为空
	                if ("GIF".equals(type.toUpperCase())||"PNG".equals(type.toUpperCase())||"JPG".equals(type.toUpperCase())) {
	                	// 自定义的文件名称
						trueFileName = mkdirs_data+"/"+UUID.randomUUID().toString() + "." +type; // 图片命名
	                    try {
	                	   	// 转存文件到指定的路径
							file.transferTo(new File(path+"/"+trueFileName));
							System.out.println(path+"/"+trueFileName);
							//图片尺寸不变，压缩图片文件大小outputQuality实现,参数1为最高质量  ,scale 等比例
							Thumbnails.of(new File(path, trueFileName)).scale(1f).outputQuality(0.25f).toFile(new File(path, trueFileName));
						} catch (IllegalStateException e) {
							e.printStackTrace();
						} catch (IOException e) {
							e.printStackTrace();
						}
	                }else {
	                    System.out.println("不是我们想要的文件类型,请按要求重新上传");
	                    return null;
	                }
	            }else {
	                System.out.println("文件类型为空");
	                return null;
	            }
	        }else {
	            System.out.println("没有找到相对应的文件");
	            return null;
	        }
		return trueFileName;
	}
	
	/**
	 * base64 图片写入磁盘
	 * @param base64Data 数据
	 * @param path 写入路径
	 * @return UUID图片名称
	 */
	public static String base64ImgUpLoad(String base64Data,String path){
		String mkdirs_data = DateUtil.getThisSysTimeYMD_FILE();
		// 判断路径是否存在/创建
		File baseFath_f = new File(path+mkdirs_data);
		if (!baseFath_f.exists()) {
			baseFath_f.mkdirs();
		}

        try{                 
            String dataPrix = "";  
            String data = "";            
            if(base64Data == null || "".equals(base64Data)){  
                throw new Exception("上传失败，上传图片数据为空");  
            }else{  
                String [] d = base64Data.split("base64,");  
                if(d != null && d.length == 2){  
                    dataPrix = d[0];  
                    data = d[1];  
                }else{  
                    throw new Exception("上传失败，数据不合法");  
                }  
            }               
            String suffix = "";  
            if("data:image/jpeg;".equalsIgnoreCase(dataPrix)){//data:image/jpeg;base64,base64编码的jpeg图片数据  
                suffix = ".jpg";  
            } else if("data:image/x-icon;".equalsIgnoreCase(dataPrix)){//data:image/x-icon;base64,base64编码的icon图片数据  
                suffix = ".ico";  
            } else if("data:image/gif;".equalsIgnoreCase(dataPrix)){//data:image/gif;base64,base64编码的gif图片数据  
                suffix = ".gif";  
            } else if("data:image/png;".equalsIgnoreCase(dataPrix)){//data:image/png;base64,base64编码的png图片数据  
                suffix = ".png";  
            }else{  
                throw new Exception("上传图片格式不合法");  
            }  
            String tempFileName = mkdirs_data+"/"+UUID.randomUUID().toString() + suffix; // 图片命名
			//因为BASE64Decoder的jar问题，此处使用spring框架提供的工具包
            byte[] bs = Base64Utils.decodeFromString(data);  
            try{
                FileUtils.writeByteArrayToFile(new File(path, tempFileName), bs); // 写入磁盘
				//图片尺寸不变，压缩图片文件大小outputQuality实现,参数1为最高质量  ,scale 等比例
				Thumbnails.of(new File(path, tempFileName)).scale(1f).outputQuality(0.25f).toFile(new File(path, tempFileName));
			}catch(Exception ee){
                throw new Exception("上传失败，写入文件失败，"+ee.getMessage());
            }

            return tempFileName;                
        }catch (Exception e) {                  
        	e.printStackTrace();
        }          
        return null;
    }     
	
	
	
	
	/**
	 * 转换局部等比图片(参照width输出大小)
	 * @param imgPath 原图
	 * @param newImgPath 新图
	 * @param w 宽
	 * @param h 高
	 */
	public static void toMixImg(String imgPath,String newImgPath,int w,int h) {
		File file = new File(imgPath);
		BufferedImage bi = null;
		if (file.exists() && file.isFile()) {
			// 创建新路径文件夹
			File newFile = new File(newImgPath);  
		    if (!newFile.getParentFile().exists()) {
		        boolean result = newFile.getParentFile().mkdirs();  
		        if (!result) {  
		            System.out.println("创建目录失败");  
		        }  
		    } 
			try {
				bi = ImageIO.read(file);
				int width = bi.getWidth();
				int height = bi.getHeight();
				Thumbnails.of(new File(imgPath)).sourceRegion(Positions.CENTER, width, (int)(width*h/w)).size(w, h).keepAspectRatio(false)
				.toFile(newImgPath);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	} 
	
	
	/**
	 * 这里是示例方法(仅供参考)
	 * @param filePath
	 */
	public  void XXXX(String filePath) {
		try {
			
			File file = new File(filePath);
			/**
			 * 指定大小进行缩放 若图片横比200小，高比300小，不变 若图片横比200小，高比300大，高缩小到300，图片比例不变
			 * 若图片横比200大，高比300小，横缩小到200，图片比例不变
			 * 若图片横比200大，高比300大，图片按比例缩小，横为200或高为300
			 */
			Thumbnails.of(filePath).size(100, 130).toFile(file.getAbsolutePath() + "_100x130.jpg");

			/**
			 * 按照比例进行缩放 scale(比例)
			 */
			Thumbnails.of(filePath).scale(0.25f).toFile(file.getAbsolutePath() + "_25%.jpg");

			/**
			 * 不按照比例，指定大小进行缩放 keepAspectRatio(false) 默认是按照比例缩放的
			 */
			Thumbnails.of(filePath).size(200, 200).keepAspectRatio(false)
					.toFile(file.getAbsolutePath() + "_200x200.jpg");

			/**
			 * 输出图片到流对象
			 *
			 */
			OutputStream os = new FileOutputStream(file.getAbsolutePath() + "_OutputStream.png");
			Thumbnails.of(filePath).size(1280, 1024).toOutputStream(os);

			/**
			 * 输出图片到BufferedImage
			 **/
			BufferedImage thumbnail = Thumbnails.of(filePath).size(1280, 1024).asBufferedImage();
			ImageIO.write(thumbnail, "jpg", new File(file.getAbsolutePath() + "_BufferedImage.jpg"));
			
			
			/**
			 * watermark(位置，水印图，透明度)
			 */
			Thumbnails.of("images/test.jpg").size(1280, 1024)
					.watermark(Positions.BOTTOM_RIGHT, ImageIO.read(new File("images/watermark.png")), 0.5f)
					.outputQuality(0.8f).toFile("C:/image_watermark_bottom_right.jpg");
			Thumbnails.of("images/test.jpg").size(1280, 1024)
					.watermark(Positions.CENTER, ImageIO.read(new File("images/watermark.png")), 0.5f).outputQuality(0.8f)
					.toFile("C:/image_watermark_center.jpg");
			
			
			/**
			 * rotate(角度),正数：顺时针 负数：逆时针
			 */
			Thumbnails.of("images/test.jpg").size(1280, 1024).rotate(90).toFile("C:/image+90.jpg");
			Thumbnails.of("images/test.jpg").size(1280, 1024).rotate(-90).toFile("C:/iamge-90.jpg");
			
			/**
			 * outputFormat(图像格式)
			 */
			Thumbnails.of("images/test.jpg").size(1280, 1024).outputFormat("png").toFile("C:/image_1280x1024.png");
			Thumbnails.of("images/test.jpg").size(1280, 1024).outputFormat("gif").toFile("C:/image_1280x1024.gif");
			
			/**
			 * 图片中心400*400的区域(裁剪)
			 */
			Thumbnails.of("images/test.jpg").sourceRegion(Positions.CENTER, 400, 400).size(200, 200).keepAspectRatio(false)
					.toFile("C:/image_region_center.jpg");
			/**
			 * 图片右下400*400的区域(裁剪)
			 */
			Thumbnails.of("images/test.jpg").sourceRegion(Positions.BOTTOM_RIGHT, 400, 400).size(200, 200)
					.keepAspectRatio(false).toFile("C:/image_region_bootom_right.jpg");
			/**
			 * 指定坐标(裁剪)
			 */
			Thumbnails.of("images/test.jpg").sourceRegion(600, 500, 400, 400).size(200, 200).keepAspectRatio(false)
					.toFile("C:/image_region_coord.jpg");

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}