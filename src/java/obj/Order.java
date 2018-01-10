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
public class Order
{

    private Integer oid;
    private Integer pid;
    private String uid;
    private Double total;

    private Date dateOrder;
    private Date dateDelivery;

    private String name;
    private String address;
    private String phone;
    private String description;

    private Integer quantity;
    private Integer isSent;

    public Order()
    {
    }

    public Order(Integer pid, String uid, Double total, Date dateOrder, Date dateDelivery, String name, String address, String phone, String description, Integer quantity, Integer isSent)
    {
        this.pid = pid;
        this.uid = uid;
        this.total = total;
        this.dateOrder = dateOrder;
        this.dateDelivery = dateDelivery;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.description = description;
        this.quantity = quantity;
        this.isSent = isSent;
    }

    public Order(Integer oid, Integer pid, String uid, Double total, Date dateOrder, Date dateDelivery, String name, String address, String phone, String description, Integer quantity, Integer isSent)
    {
        this.oid = oid;
        this.pid = pid;
        this.uid = uid;
        this.total = total;
        this.dateOrder = dateOrder;
        this.dateDelivery = dateDelivery;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.description = description;
        this.quantity = quantity;
        this.isSent = isSent;
    }

    public void setOid(Integer oid)
    {
        this.oid = oid;
    }

    public Integer getOid()
    {
        return oid;
    }

    public Integer getPid()
    {
        return pid;
    }

    public String getUid()
    {
        return uid;
    }

    public Double getTotal()
    {
        return total;
    }

    public Date getDateOrder()
    {
        return dateOrder;
    }

    public Date getDateDelivery()
    {
        return dateDelivery;
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

    public String getDescription()
    {
        return description;
    }

    public Integer getQuantity()
    {
        return quantity;
    }

    public Integer getIsSent()
    {
        return isSent;
    }

    public void setPid(Integer pid)
    {
        this.pid = pid;
    }

    public void setUid(String uid)
    {
        this.uid = uid;
    }

    public void setTotal(Double total)
    {
        this.total = total;
    }

    public void setDateOrder(Date dateOrder)
    {
        this.dateOrder = dateOrder;
    }

    public void setDateDelivery(Date dateDelivery)
    {
        this.dateDelivery = dateDelivery;
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

    public void setDescription(String description)
    {
        this.description = description;
    }

    public void setQuantity(Integer quantity)
    {
        this.quantity = quantity;
    }

    public void setIsSent(Integer isSent)
    {
        this.isSent = isSent;
    }

}
