package com.cen.sensitive.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.cen.sensitive.entity.sensitive;

public interface sensitiveService {
	int deleteByPrimaryKey(Integer id);

    int insert(sensitive record);

    int insertSelective(sensitive record);

    sensitive selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(sensitive record);

    int updateByPrimaryKey(sensitive record);
    
    public List<String> selectAll();
    /**
     * 分页查找敏感词
     * @param pmap
     * @return
     */
    List<sensitive> selectList(Map<String, Object> pmap);
    /**
     * 敏感词数量
     * @param pmap
     * @return
     */
	int selectListCount(Map<String, Object> pmap);
    
    int selectByWords(String words);
    /**
     * 初始化敏感词库，构建DFA算法模型
     *
     * @param sensitiveWordSet 敏感词库
     */
    public void initSensitiveWordMap(Set<String> sensitiveWordSet);
    /**
     * 判断文字是否包含敏感字符
     *
     * @param txt       文字
     * @param matchType 匹配规则 1：最小匹配规则，2：最大匹配规则
     * @return 若包含返回true，否则返回false
     */
    public boolean contains(String txt, int matchType) ;
    /**
     * 获取文字中的敏感词
     *
     * @param txt       文字
     * @param matchType 匹配规则 1：最小匹配规则，2：最大匹配规则
     * @return
     */
    public Set<String> getSensitiveWord(String txt, int matchType);
    /**
     * 检查文字中是否包含敏感字符，检查规则如下：<br>
     *
     * @param txt
     * @param beginIndex
     * @param matchType
     * @return 如果存在，则返回敏感词字符的长度，不存在返回0
     */
    public int checkSensitiveWord(String txt, int beginIndex, int matchType) ;
}
