<%-- 
    Document   : manage
    Created on : Dec 18, 2017, 3:25:50 PM
    Author     : Cpt_Snag
--%>


<%@page import="java.text.NumberFormat"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.util.ArrayList"%>
<%@page import="obj.Product"%>
<%@page import="database.DatabaseService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/style1.css" rel="stylesheet" type="text/css"/>
        <link href="css/style2.css" rel="stylesheet" type="text/css"/>
        <title>Product Manager</title>

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
                                    <li><a href="#"> PRODUCTs </a></li>
                                    <li><a href="manage_user.jsp"> MEMBERs </a></li>
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
        <h1>Manage Page for Admin:</h1>
        <form method="POST" action="ManageProduct">
            Product Name: <input type="text" name="pName" size="50">
            Number of product: <input type="number" name="pStockNum" size="5">
            Price: <input type="number" name="pPrice" size="20">

            Category:
            <select name="pCategory">
                <option value="short">Short</option>
                <option value="shirt">Shirt</option>
                <option value="tshirt">T-Shirt</option>
                <option value="pants">Pants</option>
                <option value="sock">Sock</option>
            </select>
            <br>
            Image URL: <input type="file" name="pImage" multiple>
            Description:
            <textarea name="pDesc" rows="2" cols="50">
            At w3schools.com you will learn how to make a website. We offer free tutorials in all web development technologies. 
            </textarea>
            <input type="submit" name="add_product">
            <a href="manage.jsp?show=0" style="margin: 20px;">Show All</a>

            <a href="manage.jsp?show=1" style="margin: 20px;">Show Current</a>
        </form>
        <hr>
        <form method="post" action="ManageProduct">
            <%                DatabaseService dbs = new DatabaseService();
                ArrayList<Product> pList = dbs.getProductList();
                Integer show = 0;
                if (request.getParameter("show") != null)
                {
                    show = Integer.parseInt(request.getParameter("show"));
                    if (show == 0)
                    {
                        pList = dbs.getAllProductList();
                    }
                }

                if (pList != null)
                {
            %>

            <table border="1" width="80%">
                <tr>
                    <th>Image</th>
                    <th>PID</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th></th>
                    <th></th>
                </tr>
                <%
                    for (Product p : pList)
                    {
                %>
                <tr height="80" align="center">
                    <td><img src="<%= p.getpImage()%>" alt="Product Image" height="42" width="42"></td>
                    <td><%= p.getpID()%></td>
                    <td><%= p.getpName()%></td>
                    <td><%= p.getpCategory()%></td>
                    <td><%= p.getpStockNum()%></td>
                    <td><%= p.getpPrice()%></td>
                    <td><input type="button" onclick="location.href = 'manage_detail.jsp?p=<%= p.getpID()%>';" value="Edit" /></td>
                    <td><button type="submit" name="delete_product" value="<%= p.getpID()%>" formmethod="post">Delete</button></td>
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
