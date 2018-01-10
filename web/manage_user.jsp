<%-- 
    Document   : manage_user
    Created on : Jan 9, 2018, 7:16:49 PM
    Author     : Cpt_Snag
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="obj.Product"%>
<%@page import="obj.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="database.DatabaseService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/style1.css" rel="stylesheet" type="text/css"/>
        <link href="css/style2.css" rel="stylesheet" type="text/css"/>
        <title>User Manager</title>
        <style>
            body
            {
                background-color: #A4F5C8;
            }
        </style>
    </head>
    <body>
        <%
            Integer valid = (Integer) session.getAttribute("admin");

            if (valid == null)
            {
                response.sendRedirect("login.jsp");
            }
        %>
        <div class="header">
            <div class="header-top">
                <div class="container">
                    <div class="header-top-in" >
                        <a href="index.jsp"><img src="img/a.jpg" width="100" height="50"></a>
                        <div class="header-in">
                            <ul class="icon1 sub-icon1">
                                <form action="mainpage" method="POST">
                                    <%
                                        if (session.getAttribute("user") == null && session.getAttribute("admin") == null)
                                        {
                                    %>
                                    <li><a href="login.jsp"> LOGIN </a></li>
                                    <li><a href="login.jsp"> REGISTER </a></li>
                                        <%
                                        }
                                        else if (session.getAttribute("admin") != null)
                                        {
                                        %>
                                    <li><a href="manage_order.jsp"> ORDERs </a></li>
                                    <li><a href="manage.jsp"> PRODUCTs </a></li>
                                    <li><a href="#"> MEMBERs </a></li>
                                    <li><button type="submit" value="Logout" name="logout">LOG OUT</button></li>
                                        <%
                                            }

                                            ArrayList<Product> cart = (ArrayList<Product>) session.getAttribute("cart");
                                            if (cart == null)
                                            {
                                        %>
                                    <div class="cart">
                                        <a href="#" class="cart-in"> </a>
                                        <span> 0</span>
                                    </div>
                                    <ul class="sub-icon1 list">
                                        <h3>No item yet!</h3>
                                        <div class="shopping_cart">
                                        </div>
                                    </ul>
                                    <%                                        }
                                    else
                                    {
                                        Double total = 0.0;
                                    %>
                                    <div class="cart">
                                        <a href="#" class="cart-in"> </a>
                                        <span> <%= cart.size()%></span>
                                    </div>
                                    <ul class="sub-icon1 list">
                                        <h3>Your shopping cart:</h3>
                                        <div class="shopping_cart">
                                            <%
                                                for (Product p : cart)
                                                {
                                                    total += p.getpPrice() * p.getpStockNum();
                                            %>

                                            <div class="cart_box">
                                                <div class="message">
                                                    <!--<div class="alert-close"></div>-->
                                                    <button class="alert-close" name="remove_cart" value="<%= p.getpID()%>"></button>
                                                    <div class="list_img"><img src="<%= p.getpImage()%>" class="img-responsive" alt=""></div>
                                                    <div class="list_desc">
                                                        <h4><a href="product.jsp?p=<%= p.getpID()%>"><%= p.getpName()%></a></h4><%= p.getpStockNum()%> x<span class="actual">
                                                            <%= NumberFormat.getIntegerInstance().format(p.getpPrice())%> VND


                                                        </span></div>
                                                    <div class="clearfix"></div>
                                                </div>
                                            </div>
                                            <div>----------------------------------------</div>
                                            <%
                                                }
                                            %>

                                        </div>
                                        <div class="total">
                                            <div class="total_left">Subtotal : </div>
                                            <div class="total_right">$<%= NumberFormat.getIntegerInstance().format(total)%> VND</div>
                                            <div class="clearfix"> </div>
                                        </div>
                                        <div class="login_buttons">
                                            <div class="check_button"><a href="cart.jsp">Check out</a></div>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="clearfix"></div>
                                    </ul>
                                    <%

                                        }
                                    %>
                                    </li>
                                    <%
                                        // }
                                    %>
                                </form>
                            </ul>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                </div>
            </div>
        </div>
        <h1>User:</h1>
        <form method="post" action="UserController">
            <%                DatabaseService dbs = new DatabaseService();
                ArrayList<User> pList = dbs.getAllUser();
                if (pList != null)
                {
            %>
            <table border="1" width="80%">
                <tr>
                    <th>#ID</th>
                    <th>NAME</th>
                    <th>ACTIVE</th>
                    <th>#BUTTON</th>
                </tr>
                <%
                    for (User p : pList)
                    {
                %>
                <tr height="80" align="center">
                    <th>#<%= p.getuID()%></th>
                    <th><%= p.getEmail()%></th>
                        <%
                            if (p.getActive() == 1)
                            {
                        %>
                    <th>Active</th>
                        <%
                        }
                        else
                        {
                        %>
                    <th>Inactive</th>
                        <%
                            }
                        %>
                    <td><button type="submit" name="active" value="<%= p.getuID()%>" formmethod="post">Activate/Deactivate</button></td>
                </tr>
                <%
                    }
                %>
            </table>
            <%
                }
            %>
        </form>
    </body>
</html>
