package com.cen.bbs.comment.dao;

import com.cen.bbs.comment.entity.Comment;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;
import java.util.Objects;

public interface CommentDao {
    int deleteByPrimaryKey(Integer cid);

    int insert(Comment record);

    int insertSelective(Comment record);

    Comment selectByPrimaryKey(Integer cid);

    int updateByPrimaryKeySelective(Comment record);

    int updateByPrimaryKeyWithBLOBs(Comment record);

    int updateByPrimaryKey(Comment record);

    int deleteAllMcomment(int id);

    int selectAllcommentCount(Map<String, Object> pmap);

    List<Objects> selectAllcomment(Map<String, Object> pmap);

    List<Comment> selectBytid(Map<String, Object> pmap);
    int selectBytidCount(Map<String, Object> pmap);

    List<Objects> rubackUser();
    Comment selectByTid(Integer tid);

    List<Comment> selectByCid( @Param("tid") int tid, @Param("cid") int cid);

    List<Comment> selectList(Map<String,Object> param);
}