/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package obj;

/**
 *
 * @author Cpt_Snag
 */
public class OrderTemp
{

    private String uid;
    private String date;
    private String deliverDate;

    private String name;
    private String address;
    private String phone;
    private String desc;

    private Integer total;

    public OrderTemp()
    {
    }

    public OrderTemp(String uid, String date, String name, String address, String phone, String desc, Integer total)
    {
        this.uid = uid;
        this.date = date;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.desc = desc;
        this.total = total;
    }

    public OrderTemp(String uid, String date, String deliverDate, String name, String address, String phone, String desc, Integer total)
    {
        this.uid = uid;
        this.date = date;
        this.deliverDate = deliverDate;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.desc = desc;
        this.total = total;
    }

    public String getDeliverDate()
    {
        return deliverDate;
    }

    public String getDesc()
    {
        return desc;
    }

    public String getName()
    {
        return name;
    }

    public String getAddress()
    {
        return address;
    }

    public String getPhone()
    {
        return phone;
    }

    public Integer getTotal()
    {
        return total;
    }

    public String getUid()
    {
        return uid;
    }

    public String getDate()
    {
        return date;
    }

    public void setUid(String uid)
    {
        this.uid = uid;
    }

    public void setDate(String date)
    {
        this.date = date;
    }

    public void setName(String name)
    {
        this.name = name;
    }

    public void setAddress(String address)
    {
        this.address = address;
    }

    public void setPhone(String phone)
    {
        this.phone = phone;
    }

    public void setTotal(Integer total)
    {
        this.total = total;
    }

    public void setDesc(String desc)
    {
        this.desc = desc;
    }

    public void setDeliverDate(String deliverDate)
    {
        this.deliverDate = deliverDate;
    }

}
