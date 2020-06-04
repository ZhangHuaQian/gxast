package com.cen.bbs.topic.entity;

import com.cen.bbs.comment.entity.Comment;
import com.cen.bbs.toconmment.entity.Toconmment;
import com.cen.ucenter.entity.User;

import java.util.Date;
import java.util.List;

public class Topicfloor {
    private User user;
    private Comment comment;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Comment getComment() {
        return comment;
    }

    public void setComment(Comment comment) {
        this.comment = comment;
    }

    public List<Toconmment> getToconmmentList() {
        return toconmmentList;
    }

    public void setToconmmentList(List<Toconmment> toconmmentList) {
        this.toconmmentList = toconmmentList;
    }

    private List<Toconmment> toconmmentList;

}