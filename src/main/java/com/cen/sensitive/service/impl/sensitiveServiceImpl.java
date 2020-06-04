package com.cen.sensitive.service.impl;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cen.sensitive.dao.sensitiveDao;
import com.cen.sensitive.entity.sensitive;
import com.cen.sensitive.service.sensitiveService;
@Service
@Transactional
public class sensitiveServiceImpl implements sensitiveService{

	@Autowired
	sensitiveDao sensitiveDao;
	/**
     * 敏感词匹配规则
     */
    public static final int MinMatchTYpe = 1;      //最小匹配规则，如：敏感词库["中国","中国人"]，语句："我是中国人"，匹配结果：我是[中国]人
    public static final int MaxMatchType = 2;      //最大匹配规则，如：敏感词库["中国","中国人"]，语句："我是中国人"，匹配结果：我是[中国人]
    /**
     * 敏感词集合
     */
    public static HashMap sensitiveWordMap;
	

	public int deleteByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return sensitiveDao.deleteByPrimaryKey(id);
	}


	public int insert(sensitive record) {
		// TODO Auto-generated method stub
		return sensitiveDao.insert(record);
	}


	public int insertSelective(sensitive record) {
		// TODO Auto-generated method stub
		return sensitiveDao.insertSelective(record);
	}


	public sensitive selectByPrimaryKey(Integer id) {
		// TODO Auto-generated method stub
		return sensitiveDao.selectByPrimaryKey(id);
	}


	public int updateByPrimaryKeySelective(sensitive record) {
		// TODO Auto-generated method stub
		return sensitiveDao.updateByPrimaryKeySelective(record);
	}


	public int updateByPrimaryKey(sensitive record) {
		// TODO Auto-generated method stub
		return sensitiveDao.updateByPrimaryKey(record);
	}


	public List<String> selectAll() {
		// TODO Auto-generated method stub
		return sensitiveDao.selectAll();
	}

	public void initSensitiveWordMap(Set<String> sensitiveWordSet) {
		// TODO Auto-generated method stub
		//初始化敏感词容器，减少扩容操作
        sensitiveWordMap = new HashMap(sensitiveWordSet.size());
        String key;
        Map nowMap;
        Map<String, String> newWorMap;
        //迭代sensitiveWordSet
        Iterator<String> iterator = sensitiveWordSet.iterator();
        while (iterator.hasNext()) {
            //关键字
            key = iterator.next();
            nowMap = sensitiveWordMap;
            for (int i = 0; i < key.length(); i++) {
                //转换成char型
                char keyChar = key.charAt(i);
                //库中获取关键字
                Object wordMap = nowMap.get(keyChar);
                //如果存在该key，直接赋值，用于下一个循环获取
                if (wordMap != null) {
                    nowMap = (Map) wordMap;
                } else {
                    //不存在则，则构建一个map，同时将isEnd设置为0，因为他不是最后一个
                    newWorMap = new HashMap<String, String>();
                    //不是最后一个
                    newWorMap.put("isEnd", "0");
                    nowMap.put(keyChar, newWorMap);
                    nowMap = newWorMap;
                }

                if (i == key.length() - 1) {
                    //最后一个
                    nowMap.put("isEnd", "1");
                }
            }
        }
	}


	public boolean contains(String txt, int matchType) {
		// TODO Auto-generated method stub
		boolean flag = false;
        for (int i = 0; i < txt.length(); i++) {
            int matchFlag = checkSensitiveWord(txt, i, matchType); //判断是否包含敏感字符
            if (matchFlag > 0) {    //大于0存在，返回true
                flag = true;
            }
        }
        return flag;
	}


	public Set<String> getSensitiveWord(String txt, int matchType) {
		// TODO Auto-generated method stub
		Set<String> sensitiveWordList = new HashSet<String>();

        for (int i = 0; i < txt.length(); i++) {
            //判断是否包含敏感字符
            int length = checkSensitiveWord(txt, i, matchType);
            if (length > 0) {//存在,加入list中
                sensitiveWordList.add(txt.substring(i, i + length));
                i = i + length - 1;//减1的原因，是因为for会自增
            }
        }
        return sensitiveWordList;
	}


	public int checkSensitiveWord(String txt, int beginIndex, int matchType) {
		// TODO Auto-generated method stub
		//敏感词结束标识位：用于敏感词只有1位的情况
        boolean flag = false;
        //匹配标识数默认为0
        int matchFlag = 0;
        char word;
        Map nowMap = sensitiveWordMap;
        for (int i = beginIndex; i < txt.length(); i++) {
            word = txt.charAt(i);
            //获取指定key
            nowMap = (Map) nowMap.get(word);
            if (nowMap != null) {//存在，则判断是否为最后一个
                //找到相应key，匹配标识+1
                matchFlag++;
                //如果为最后一个匹配规则,结束循环，返回匹配标识数
                if ("1".equals(nowMap.get("isEnd"))) {
                    //结束标志位为true
                    flag = true;
                    //最小规则，直接返回,最大规则还需继续查找
                    if (MinMatchTYpe == matchType) {
                        break;
                    }
                }
            } else {//不存在，直接返回
                break;
            }
        }
        if (matchFlag < 2 || !flag) {//长度必须大于等于1，为词
            matchFlag = 0;
        }
        return matchFlag;
	}


	public int selectByWords(String words) {
		// TODO Auto-generated method stub
		return sensitiveDao.selectByWords(words);
	}

	@Override
	public List<sensitive> selectList(Map<String, Object> pmap) {
		// TODO Auto-generated method stub
		return sensitiveDao.selectList(pmap);
	}

	@Override
	public int selectListCount(Map<String, Object> pmap) {
		// TODO Auto-generated method stub
		return sensitiveDao.selectListCount(pmap);
	}


}
