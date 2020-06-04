package com.cen.gen;

import org.mybatis.generator.api.ShellRunner;

/**
 * 代码生成  
 * @author cenguocheng
 *	2018-6-1
 */
public class GenRun {
	public static void main(String[] args) {
		String config ="E:/workspace/gxast/generator.xml";
		//System.out.println(GenRun.class.getResource("generator.xml").getFile());
        String[] arg = { "-configfile", config, "-overwrite" };  
        ShellRunner.main(arg);
	}
}
