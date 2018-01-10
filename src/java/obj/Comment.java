/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package obj;

import java.util.Date;

/**
 *
 * @author Cpt_Snag
 */
public class Comment
{
    private Integer cid;
    private Integer pid;
    
    private String email;
    private String comment;
    private String date;
    private Integer like;

    public Comment()
    {
    }

    public Comment(Integer pid, String email, String comment, String date, Integer like)
    {
        this.pid = pid;
        this.email = email;
        this.comment = comment;
        this.date = date;
        this.like = like;
    }

    public Comment(Integer pid, String email, String comment, String date, Integer like, Integer cid)
    {
        this.cid = cid;
        this.pid = pid;
        this.email = email;
        this.comment = comment;
        this.date = date;
        this.like = like;
    }

    public Integer getCid()
    {
        return cid;
    }

    public Integer getPid()
    {
        return pid;
    }

    public String getEmail()
    {
        return email;
    }

    public String getComment()
    {
        return comment;
    }

    public String getDate()
    {
        return date;
    }

    public Integer getLike()
    {
        return like;
    }

    public void setPid(Integer pid)
    {
        this.pid = pid;
    }

    public void setEmail(String email)
    {
        this.email = email;
    }

    public void setComment(String comment)
    {
        this.comment = comment;
    }

    public void setDate(String date)
    {
        this.date = date;
    }

    public void setLike(Integer like)
    {
        this.like = like;
    }

    public void setCid(Integer cid)
    {
        this.cid = cid;
    }

}
