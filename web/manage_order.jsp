<%-- 
    Document   : manage_order
    Created on : Jan 8, 2018, 11:23:26 PM
    Author     : Cpt_Snag
--%>

<%@page import="obj.Product"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="obj.OrderTemp"%>
<%@page import="obj.Order"%>
<%@page import="java.util.ArrayList"%>
<%@page import="database.DatabaseService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="css/style1.css" rel="stylesheet" type="text/css"/>
        <link href="css/style2.css" rel="stylesheet" type="text/css"/>
        <title>Order Manager</title>

        <style>
            body
            {
                background-color: #E4D4C1;
            }

            h2
            {
                text-align: center;
                text-decoration: underline;
                color: #81BAF4;
            }
            .order-head
            {
                font-size: 23px;
                width: 80%;
            }
            .order-head span
            {
                font-weight: 800;
            }
            .deliver, .price
            {
                float: right;
            }

            .order-row-head div
            {
                border-left: thick solid #ff0000;
            }
            .order-row
            {
                font-size: 17px;
            }
            .order-row div
            {
                border-left: thick solid #F9B131;
            }

            .order-addtion
            {
                font-size: 20px;
            }
        </style>
    </head>
    <body>
        <%
            if (session.getAttribute("admin") == null)
            {
                //response.sendRedirect("login.jsp");
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
                                    <li><a href="?show=1" style="text-decoration: underline;"> <i>DELIVERED ORDERs</i> </a></li>
                                    <li><a href="?show=0"> ORDERs </a></li>
                                    <li><a href="manage.jsp"> PRODUCTs </a></li>
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
        <h2> The Order List of user: </h2>
        <%            DatabaseService dbs = new DatabaseService();
            ArrayList<OrderTemp> tmpList = dbs.getOrderGroup(0);
            String show = request.getParameter("show");
            System.out.println("[+] SHOW is " + show);
            System.out.println(tmpList);
            if (show != null && show.equals("1"))
            {
                tmpList = dbs.getOrderGroup(1);
            }

            ArrayList<Order> oList = null;
            for (OrderTemp valueTmp : tmpList)
            {
        %>
        <form method="post" action="order">
            <div class="order">
                <div class="order-detail">
                    <p class="order-head">
                        Order of <i><%= valueTmp.getName()%></i>  
                        <span>(<%= valueTmp.getUid()%>)</span> 
                        <span class="price">Total price: <%= NumberFormat.getIntegerInstance().format(valueTmp.getTotal())%> VND</span>
                        <input type="hidden" value="<%= valueTmp.getUid()%>" name="email">
                        <input type="hidden" value="<%= valueTmp.getDate()%>" name="date">

                        <%
                            if (show == null || show.equals("0"))
                            {
                        %>
                        <button class="deliver" type="text" name="deliver" value="" formmethod="post">Check</button>
                        <%
                        }
                        else if (show.equals("1"))
                        {
                        %>
                        is delivered at <span class=""> <%= valueTmp.getDeliverDate()%> </span>  
                        <%
                            }
                        %>
                    </p>
                    <div class="order-row-head">
                        <div class="col-md-1"></div>
                        <div class="col-md-1">#pid</div>
                        <div class="col-md-4">NAME</div>
                        <div class="col-md-2">PRICE OF ONE</div>
                        <div class="col-md-1">QUANTITY</div>
                        <div class="col-md-3">#<%= valueTmp.getDate()%> </div>
                    </div>
                    <hr>
                    <%
                        oList = dbs.getOrderByDetail(valueTmp.getUid(), valueTmp.getDate());
                        if (oList != null)
                        {
                            for (Order o : oList)
                            {
                    %>
                    <div class="order-row">
                        <div class="col-md-1"></div>
                        <div class="col-md-1">#<%= o.getPid()%></div>
                        <div class="col-md-4"><%= dbs.getProductById(o.getPid()).getpName()%></div>
                        <div class="col-md-2"><%= dbs.getProductById(o.getPid()).getpPrice()%></div>
                        <div class="col-md-1"><%= o.getQuantity()%></div>
                        <div class="col-md-3">#</div>
                    </div>


                    <%
                            }
                        }
                    %>
                    <p class="order-addtion">Phone number: <b><%= valueTmp.getPhone()%></b> 
                        <%
                            if (valueTmp.getDesc() == null)
                            {
                        %>
                        with Description: <b>None</b></p>
                        <%
                        }
                        else
                        {
                        %>
                    with Description: <b><%= valueTmp.getDesc()%></b></p>    
                    <%
                        }
                    %>
                    <p class="order-addtion">Delivery address: <b><%= valueTmp.getAddress()%></b></p>
                </div>
            </div>

            <div class="col-md-12" style="background-color: black; height: 10px;"></div>
            <hr>
        </form>
        <%
            }

        %>

        <!--        <form method="post" action="#">
                    <div class="order">
                        <div class="order-detail">
                            <p class="order-head">Order of Sang <span>(sang@123.com)</span>: <span class="price">Total price: 300,000 VND</span>
                                <button class="deliver" type="text" name="deliver" value="oid" formmethod="post">Check</button>
                            </p>
        
                            <div class="order-row">
                                <div class="col-md-1"></div>
                                <div class="col-md-1">#pid</div>
                                <div class="col-md-4">NAME</div>
                                <div class="col-md-2">PRICE OF ONE</div>
                                <div class="col-md-1">QUANTITY</div>
                                <div class="col-md-3">#</div>
                            </div>
                            <hr>
                            <div class="order-row">
                                <div class="col-md-1"></div>
                                <div class="col-md-1">#30</div>
                                <div class="col-md-4">The name of this item.</div>
                                <div class="col-md-2">300000</div>
                                <div class="col-md-1">3</div>
                                <div class="col-md-3">#</div>
                            </div>
        
                            <div class="order-row">
                                <div class="col-md-1"></div>
                                <div class="col-md-1">#30</div>
                                <div class="col-md-4">The name of this item.</div>
                                <div class="col-md-2">300000</div>
                                <div class="col-md-1">3</div>
                                <div class="col-md-3">#</div>
                            </div>
        
                            <div class="order-row">
                                <div class="col-md-1"></div>
                                <div class="col-md-1">#30</div>
                                <div class="col-md-4">The name of this item.</div>
                                <div class="col-md-2">300000</div>
                                <div class="col-md-1">3</div>
                                <div class="col-md-3">#</div>
                            </div>
                            <p class="order-addtion">Phone number: <b>123123123</b> with Description: <b>Don't be late</b></p>
                            <p class="order-addtion">Delivery address: <b>Sang home home home ahihi</b></p>
                        </div>
                    </div>
                    <hr>
        
                    <div class="order">
                        <div class="order-detail">
                            <p class="order-head">Order of Sang <span>(sang@123.com)</span>: <span class="price">Total price: 300,000 VND</span>
                                <button class="deliver" type="text" name="deliver" value="oid" formmethod="post">Check</button>
                            </p>
        
                            <div class="order-row">
                                <div class="col-md-1"></div>
                                <div class="col-md-1">#pid</div>
                                <div class="col-md-4">NAME</div>
                                <div class="col-md-2">PRICE OF ONE</div>
                                <div class="col-md-1">QUANTITY</div>
                                <div class="col-md-3">#</div>
                            </div>
                            <hr>
                            <div class="order-row">
                                <div class="col-md-1"></div>
                                <div class="col-md-1">#30</div>
                                <div class="col-md-4">The name of this item.</div>
                                <div class="col-md-2">300000</div>
                                <div class="col-md-1">3</div>
                                <div class="col-md-3">#</div>
                            </div>
        
                            <div class="order-row">
                                <div class="col-md-1"></div>
                                <div class="col-md-1">#30</div>
                                <div class="col-md-4">The name of this item.</div>
                                <div class="col-md-2">300000</div>
                                <div class="col-md-1">3</div>
                                <div class="col-md-3">#</div>
                            </div>
        
                            <div class="order-row">
                                <div class="col-md-1"></div>
                                <div class="col-md-1">#30</div>
                                <div class="col-md-4">The name of this item.</div>
                                <div class="col-md-2">300000</div>
                                <div class="col-md-1">3</div>
                                <div class="col-md-3">#</div>
                            </div>
                            <p class="order-addtion">Phone number: <b>123123123</b> with Description: <b>Don't be late</b></p>
                            <p class="order-addtion">Delivery address: <b>Sang home home home ahihi</b></p>
                        </div>
                    </div>
                    <hr>
                </form>-->


    </body>
</html>
