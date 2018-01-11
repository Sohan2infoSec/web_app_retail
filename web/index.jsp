<%-- 
    Document   : index
    Created on : Dec 19, 2017, 10:47:28 AM
    Author     : Cpt_Snag
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="obj.Product"%>
<%@page import="database.DatabaseService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">       
        <link rel="stylesheet" type="text/css" href="css/style1.css">
        <link rel="stylesheet" type="text/css" href="css/style2.css">
        <link rel="stylesheet" type="text/css" href="css/mystyle.css">
        
        <link href='https://fonts.googleapis.com/css?family=Oxygen:400,300,700' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Lora' rel='stylesheet' type='text/css'>
        <style>
            .product-tile
            {
                position: relative;
                width: 90%;
                height: 90%;
                border: 2px solid #3F0C1F;
                margin: 0 auto 15px;
            }
            .product-tile span
            {
                position: absolute;
                bottom: 0;
                right: 0;
                width: 100%;
                background-color: #000;
                color: #fff;
                opacity: .5;
                text-align: center;
                height: 15%;
                font-size: 1.2em;
                text-transform: uppercase;
            }
            .product-tile span:nth-child(2)
            {
                position: absolute;
                bottom: 30px;
                right: 0;
                width: 100%;
                background-color: #000;
                color: #fff;
                opacity: .5;
                text-align: center;
                height: 15%;
                font-size: 1.2em;
                text-transform: uppercase;
            }
            .cate
            {
                margin-bottom: 20px;
                margin-left: 0px;
                clear: both;
            }
            .cat
            {
                border: 3px;
                border-style: outset;
                padding: 5px;
                background-color: green;
                color: white;
                text-align: center;
            }

            .search-container button {
                float: left;
                padding: 6px 10px;
                margin-top: 8px;
                margin-right: 16px;
                background: #ddd;
                font-size: 17px;
                border: none;
                cursor: pointer;
            }
            .search-container button:hover {
                background: #ccc;
            }
            input[type=text] {
                float: left;
                padding: 6px;
                margin-top: 8px;
                font-size: 17px;
                border: none;
                width: 50%;
            }      
        </style>

        <script>
            setTimeout(function ()
            {
                $('#head').load('index.jsp');
            }, 1000);

//            setTimeout(function ()
//            {
//                window.location.reload(1);
//            }, 0000);

        </script>
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
                                    <li><a href="manage_order.jsp"> ORDERs </a></li>
                                    <li><a href="manage.jsp"> PRODUCTs </a></li>
                                    <li><a href="manage_user.jsp"> MEMBERs </a></li>
                                    <li><button type="submit" value="Logout" name="logout">LOG OUT</button></li>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                    <li><a href="#"> Welcome <%= session.getAttribute("mail")%></a></li>      
                                    <li><button class="log-out" type="submit" value="Logout" name="logout">LOG OUT</button></li>                      
                                    <li><a href="cart.jsp"> CHECKOUT</a></li>
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
        <form action="mainpage" method="post">
            <div class="container">
                <div class="row cate">
                    <div class="col-md-12 search-container">

                        <input type="text" placeholder="Search for a product ..." name="item_search">
                        <button type="submit" name="search"><i class="fa fa-search"></i></button>

                    </div>
                    <div class="col-md-2"><a href="/ABC/index.jsp"><div class="cat">All</div></a></div>
                    <div class="col-md-2"><a href="/ABC/index.jsp?cat=short"><div class="cat">Short</div></a></div>
                    <div class="col-md-2"><a href="/ABC/index.jsp?cat=shirt"><div class="cat">Shirt</div></a></div>
                    <div class="col-md-2"><a href="/ABC/index.jsp?cat=tshirt"><div class="cat">T-Shirt</div></a></div>
                    <div class="col-md-2"><a href="/ABC/index.jsp?cat=pants"><div class="cat">Pants</div></a></div>
                    <div class="col-md-2"><a href="/ABC/index.jsp?cat=sock"><div class="cat">Socks</div></a></div>
                </div>
            </div>

            <div class="container">
                <section class="row">
                    <%
                        database.DatabaseService dbs = new DatabaseService();
                        String cate = request.getParameter("cat");
                        String key = request.getParameter("key");
                        ArrayList<Product> pList = dbs.getAllProductList();

                        if (key != null && cate != null)
                        {
                            pList = dbs.getProductListByKeyword(key, cate);
                        }
                        else if (cate != null)
                        {
                            pList = dbs.getProductList(cate, 0);
                    %>
                    <input type="hidden" name="cat" value="<%= cate%>">
                    <%
                        }
                        else if (key != null)
                        {
                            pList = dbs.getProductListByKeyword(key);
                        }

                        for (Product p : pList)
                        {
                    %>
                    <div class="col-md-3">
                        <a href="/ABC/product.jsp?p=<%= p.getpID()%>">
                            <div class="product-tile">
                                <img src="<%= p.getpImage()%>" width="100%" height="200">
                                <span><%= p.getpName()%></span>
                                <span><%= NumberFormat.getIntegerInstance().format(p.getpPrice())%> VND</span>
                            </div>
                        </a>                     
                    </div>
                    <%
                        }

                    %>
                </section>
            </div>
        </form>
        <footer class="panel-footer">
            <div class="container">
                <div class="row">
                    <section id="hours" class="col-sm-4">
                        <span>Hours:</span><br>
                        Mon-Fri: 8:00am - 8:00pm<br>
                        Sat: 8am - 5pm<br>
                        Sunday Closed
                        <hr class="visible-xs">
                    </section>
                    <section id="address" class="col-sm-4">
                        <span>Address:</span><br>
                        123/45, CMT8 Street, Ward 5, Tan Binh<br>
                        Ho Chi Minh city
                        <p>* Delivery area within the city, free shipping.</p>
                        <hr class="visible-xs">
                    </section>
                    <section id="testimonials" class="col-sm-4">
                        <p>"Great shirt with a reasonable price!"</p>
                        <p>"Fast shipping! Great service! Couldn't ask for more! I'll be back again and again!"</p>
                    </section>
                </div>
                <div class="text-center">&copy; Copyright Sohan store 2018</div>
            </div>
        </footer>
        <!-- jQuery (Bootstrap JS plugins depend on it) -->
        <script src="js/jquery-2.1.4.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/script.js"></script>
    </body>
</html>
