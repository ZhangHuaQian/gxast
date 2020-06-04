package com.cen.common.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.apache.log4j.Logger;


/**
* 
*/
public class DateUtil {

	// 日志
	private static final Logger logger = Logger.getLogger(DateUtil.class);

	/**
	 * 时间格式(yyyy-MM-dd)
	 */
	public final static String DATE_PATTERN = "yyyy-MM-dd";
	public final static String DATE_PATTERN_FILE = "/yyyy/MM/dd/";
	/**
	 * 无分隔符日期格式 "yyyyMMddHHmmss"
	 */
	public static String DATE_TIME_PATTERN_YYYY_MM_DD_HH_MM_SS = "yyyyMMddHHmmss";
	/**
	 * 时间格式(yyyy-MM-dd HH:mm:ss)
	 */
	public final static String DATE_TIME_PATTERN = "yyyy-MM-dd HH:mm:ss";



	/**
	 * 获取当前系统日期(年份)
	 * @return
	 */
	public static String getThisSysTimeY() {
		String ymd = new SimpleDateFormat("yyyy").format(new Date());
		return ymd;
	}


	/**
	 * 获取当前系统日期(年份月份)
	 * @return
	 */
	public static String getThisSysTimeYM() {
		String ymd = new SimpleDateFormat("yyyy-MM").format(new Date());
		return ymd;
	}

	/**
	 * 获取当前系统日期
	 * @return
	 */
	public static String getThisSysTimeYMD() {
		String ymd = new SimpleDateFormat(DATE_PATTERN).format(new Date());
		return ymd;
	}

	/**
	 * 获取当前系统(上传文件用)
	 * @return
	 */
	public static String getThisSysTimeYMD_FILE() {
		String ymd = new SimpleDateFormat(DATE_PATTERN_FILE).format(new Date());
		return ymd;
	}

	/**
	 * 获取当前系统日期+时分秒
	 * @return
	 */
	public static String getThisSysTimeYMDHMS() {
		String ymdhms = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
		return ymdhms;
	}



	public static String format(Date date) {
		return format(date, DATE_PATTERN);
	}

	public static String format(Date date, String pattern) {
		if (date != null) {
			SimpleDateFormat df = new SimpleDateFormat(pattern);
			return df.format(date);
		}
		return null;
	}

	public static Date format(String datetime) {
		DateFormat df = new SimpleDateFormat(DATE_TIME_PATTERN_YYYY_MM_DD_HH_MM_SS);
		try {
			return df.parse(datetime);
		} catch (ParseException e) {
			logger.error("日期格式化错误:"+datetime);
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 返回一定时间后的日期
	 *
	 * @param date   开始计时的时间
	 * @param year   增加的年
	 * @param month  增加的月
	 * @param day    增加的日
	 * @param hour   增加的小时
	 * @param minute 增加的分钟
	 * @param second 增加的秒
	 * @return
	 */
	public static Date getAfterDate(Date date, int year, int month, int day, int hour, int minute, int second) {
		if (date == null) {
			date = new Date();
		}

		Calendar cal = new GregorianCalendar();

		cal.setTime(date);
		if (year != 0) {
			cal.add(Calendar.YEAR, year);
		}
		if (month != 0) {
			cal.add(Calendar.MONTH, month);
		}
		if (day != 0) {
			cal.add(Calendar.DATE, day);
		}
		if (hour != 0) {
			cal.add(Calendar.HOUR_OF_DAY, hour);
		}
		if (minute != 0) {
			cal.add(Calendar.MINUTE, minute);
		}
		if (second != 0) {
			cal.add(Calendar.SECOND, second);
		}
		return cal.getTime();
	}

}
