<%-- 
    Document   : success
    Created on : Jan 8, 2018, 12:36:53 AM
    Author     : Cpt_Snag
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="obj.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style1.css">
        <style>
            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
                width: 100%;
            }

            body {
                display: table;
                background-image: url(img/success1.jpg);
            }

            .my-block {
                height: 200px;
                width: 40%;
                position: fixed;
                color: #84CBD3;
                top: 50%;
                left: 50%;
                margin-top: -200px;
                margin-left: -200px;
                font-size: 65px; 
                line-height: 160px; 
                font-family: "Great Vibes", cursive;

                font-weight: normal; 
                text-shadow: 0 1px 1px #fff;
            }
        </style>
    </head>
    <body>
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
                                    <li><a href="manage.jsp"> PRODUCT </a></li>
                                    <li><a href="#"> MEMBER </a></li>
                                    <li><button type="submit" value="Logout" name="logout">LOG OUT</button></li>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                    <li><a href="#"> Welcome <%= session.getAttribute("mail")%></a></li>      
                                    <li><button class="log-out" type="submit" value="Logout" name="logout">LOG OUT</button></li>                      
                                    <li>

                                        <%
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
                                        }
                                    %>
                                </form>
                            </ul>
                        </div>
                        <div class="clearfix"> </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="my-block">
            Thank you for making a purchase.
        </div>

    </body>
</html>
