/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ultilities;

import obj.Product;
import java.util.ArrayList;
import java.util.Objects;
import javax.servlet.http.HttpSession;

/**
 *
 * @author junnguyen
 */
public class SessionService
{

    private final HttpSession httpSession;

    public SessionService(HttpSession httpSession)
    {
        this.httpSession = httpSession;
    }

    public void setAtt(String name, Object obj)
    {
        httpSession.setAttribute(name, obj);
    }

    public Object getAtt(String name)
    {
        return httpSession.getAttribute(name);
    }

    public void removeAtt(String name)
    {
        httpSession.removeAttribute(name);
    }

    public Object getUIDUser()
    {
        return httpSession.getAttribute("user");
    }

    public Object getUIDAdmin()
    {
        return httpSession.getAttribute("admin");
    }

    public double getCartTotal()
    {
        ArrayList<Product> cartList = (ArrayList<Product>) httpSession.getAttribute("cart");
        double total = 0.0;
        if (cartList == null)
        {
            cartList = new ArrayList<Product>();
        }
        else
        {
            for (Product p : cartList)
            {
                total += p.getpStockNum() * p.getpPrice();
            }
        }
        return total;
    }

    public ArrayList<Product> getCart()
    {
        ArrayList<Product> cartList = (ArrayList<Product>) httpSession.getAttribute("cart");

        if (cartList == null)
        {
            cartList = new ArrayList<Product>();
        }
        return cartList;
    }

    public void addCart(Product p)
    {
        ArrayList<Product> cartList = (ArrayList<Product>) httpSession.getAttribute("cart");
        if (cartList == null)
        {
            cartList = new ArrayList<>();
            cartList.add(p);
        }
        else
        {
            for (Product tmpP : cartList)
            {
                if (tmpP.getpID() == p.getpID())
                {
                    removeItemFromCart(tmpP.getpID(), cartList);
                    Integer newQuantitty = tmpP.getpStockNum() + p.getpStockNum();
                    p.setpStockNum(newQuantitty);
                    break;
                }
            }
            cartList.add(p);
        }
        httpSession.setAttribute("cart", cartList);
    }

    public void removeItemFromCart(Integer pid, ArrayList<Product> cart)
    {
        ArrayList<Product> itemBin = new ArrayList<Product>();
        for (Product p : cart)
        {
            if (p.getpID() == pid)
            {
                itemBin.add(p);
            }
        }
        cart.removeAll(itemBin);
        httpSession.setAttribute("cart", cart);
    }
//    public void addMember(String memberName)
//    {
//
//        ArrayList<String> memberList = (ArrayList) httpSession.getAttribute("memberList");
//
//        if (memberList == null)
//        {
//            memberList = new ArrayList<String>();
//            memberList.add(memberName);
//            httpSession.setAttribute("memberList", memberList);
//
//        }
//        else
//        {
//            memberList.add(memberName);
//        }
//
//    }
//
//    public ArrayList<String> getMemberList()
//    {
//        ArrayList<String> memberList = (ArrayList) httpSession.getAttribute("memberList");
//
//        if (memberList == null)
//        {
//            memberList = new ArrayList<String>();
//        }
//        return memberList;
//    }

}
