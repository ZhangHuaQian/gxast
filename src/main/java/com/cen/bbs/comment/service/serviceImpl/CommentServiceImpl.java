package com.cen.bbs.comment.service.serviceImpl;

import com.cen.bbs.comment.dao.CommentDao;
import com.cen.bbs.comment.entity.Comment;
import com.cen.bbs.comment.service.CommentService;
import com.cen.bbs.favorite.entity.Favorite;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * Created by pc on 2019/1/21.
 */
@Transactional
@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    CommentDao commentDao;

    @Override
    public int deleteByPrimaryKey(Integer cid) {
        return commentDao.deleteByPrimaryKey(cid);
    }

    @Override
    public int insert(Comment record) {
        return commentDao.insert(record);
    }

    @Override
    public int insertSelective(Comment record) {
        return commentDao.insertSelective(record);
    }

    @Override
    public Comment selectByPrimaryKey(Integer cid) {
        return commentDao.selectByPrimaryKey(cid);
    }

    @Override
    public int updateByPrimaryKeySelective(Comment record) {
        return commentDao.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKeyWithBLOBs(Comment record) {
        return commentDao.updateByPrimaryKeyWithBLOBs(record);
    }

    @Override
    public int updateByPrimaryKey(Comment record) {
        return commentDao.updateByPrimaryKey(record);
    }

    @Override
    public int deleteAllMcomment(int id) {
        return commentDao.deleteAllMcomment(id);
    }

    @Override
    public int selectAllcommentCount(Map<String, Object> pmap) {
        return commentDao.selectAllcommentCount(pmap);
    }

    @Override
    public List<Objects> selectAllcomment(Map<String, Object> pmap) {
        return commentDao.selectAllcomment(pmap);
    }

    @Override
    public List<Comment> selectBytid(Map<String, Object> pmap) {
        return commentDao.selectBytid(pmap);
    }

    @Override
    public int selectBytidCount(Map<String, Object> pmap) {
        return commentDao.selectBytidCount(pmap);
    }

    @Override
    public List<Objects> rubackUser() {
        return commentDao.rubackUser();
    }

    @Override
    public Comment selectByTid(Integer tid) {
        return commentDao.selectByTid(tid);
    }

    @Override
    public List<Comment> selectByCid( int tid, int cid) {
        return commentDao.selectByCid(tid,cid);
    }

    @Override
    public List<Comment> selectList(Map<String, Object> param) {
        return commentDao.selectList(param);
    }
}
