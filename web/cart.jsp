<%-- 
    Document   : showCart
    Created on : Dec 18, 2017, 9:05:39 PM
    Author     : Cpt_Snag
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="obj.Product"%>
<%@page import="ultilities.SessionService"%>
<%@page import="java.util.ArrayList"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/bootstrap.min.css"> 
        <link rel="stylesheet" type="text/css" href="css/style1.css">
        <link rel="stylesheet" type="text/css" href="css/style2.css">
        <link rel="stylesheet" type="text/css" href="css/mystyle.css">

        <title>JSP Page</title>
        <script type="text/javascript" src="js/core.js"></script>
        <style>
            .panel-footer 
            {
                margin-top: 30px;
                padding-top: 35px;
                padding-bottom: 30px;
                background-color: #222;
                border-top: 0;
            }
            .panel-footer div.row {
                margin-bottom: 35px;
            }
            #hours, #address {
                line-height: 2;
            }
            #hours > span, #address > span {
                font-size: 1.3em;
            }
            #address p {
                color: #557c3e;
                font-size: .8em;
                line-height: 1.8;
            }
            #testimonials {
                font-style: italic;
            }
            #testimonials p:nth-child(2) {
                margin-top: 25px;
            }
        </style>
        <script type="text/javascript">
            function checkForm(form)
            {
                if (form.cname.value.trim() === "")
                {
                    alert("Error: Receiver cannot be blank!");
                    form.cname.focus();
                    return false;
                }

                if (form.address.value.trim() === "")
                {
                    alert("Error: Address cannot be blank!");
                    form.address.focus();
                    return false;
                }

                if (form.phone.value.trim() === "")
                {
                    alert("Error: Phone number cannot be blank!");
                    form.phone.focus();
                    return false;
                }
                return true;
            }
        </script>
    </head>
    <body>
        <%
            if (session.getAttribute("user") == null && session.getAttribute("admin") == null)
            {
                response.sendRedirect("index.jsp");
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
                                    <li><a href="manage_user.jsp"> MEMBERs </a></li>
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
        <h1 class="text-center" id="title">Cart</h1>
        <%
            SessionService ss = new SessionService(request.getSession());
            ArrayList<Product> pList = ss.getCart();

            if (pList != null)
            {
                double total = 0.0;
        %>
        <table width="80%" border="1">
            <tr>
                <th>Image</th>
                <th>Name</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Subtotal (Vietnam Dong)</th>
            </tr>
            <%
                for (Product p : pList)
                {
                    total += p.getpPrice() * p.getpStockNum();
            %>
            <tr align="center">
                <td><img src="<%= p.getpImage()%>" alt="Smiley face" height="42" width="42"></td>
                <td><%= p.getpName()%></td>
                <td><%= p.getpStockNum()%></td>
                <td><%= NumberFormat.getIntegerInstance().format(p.getpPrice())%></td>
                <td><b><%= NumberFormat.getIntegerInstance().format(p.getpStockNum() * p.getpPrice())%> </b></td>
            </tr>
            <%
                }
            %>
            <tr align="center">
                <td></td>
                <td></td>
                <td></td>
                <td><b>Total</b></td>
                <td><b><%= NumberFormat.getIntegerInstance().format(total)%> </b></td
            </tr>
        </table>

        <%
            }
        %>
        <hr>
        <div style="text-align: center; font-size: 20px; color: red;"><a href="index.jsp">Back to shop :D.</a></div>


        <div class="container-fluid">
            <div class="container">
                <hr>
                <div class="row">
                    <!--return checkForm(this);-->
                    <form role="form" action="order" method="post" onsubmit="">
                        <fieldset>							
                            <p class="text-uppercase"> Login using your account: </p>	


                            <div class="form-group col-md-4 col-sm-12">
                                <input type="text" name="cname" id="cname" class="form-control input-lg" placeholder="Your name">
                            </div>
                            <div class="form-group col-md-8 col-sm-12">
                                <input type="text" name="address" id="address" class="form-control input-lg" placeholder="We will send to you at..">
                            </div>

                            <div class="form-group col-md-3 col-sm-12">
                                <input type="text" name="phone" id="phone" class="form-control input-lg" placeholder="Your phone">
                            </div>
                            <div class="form-group col-md-9 col-sm-12">
                                <input type="text" name="desc" class="form-control input-lg" placeholder="Note for this product" >                                  
                            </div>
                            <div>
                                <input type="submit" name="order" class="btn btn-md btn-primary" value="Make an order">
                            </div>
                        </fieldset>
                </div>          
            </div>
        </div> 

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
    </body>
</html>
