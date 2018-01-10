<%-- 
    Document   : manage_detail
    Created on : Jan 8, 2018, 9:56:37 AM
    Author     : Cpt_Snag
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="obj.Product"%>
<%@page import="database.DatabaseService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Single Product Manager</title>
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="css/style1.css" rel="stylesheet" type="text/css"/>
        <link href="css/style2.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>

        <%
            if (session.getAttribute("admin") == null)
            {

                //response.addHeader("referer", "manage_order.jsp");
//                RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
//                dispatcher.forward(request, response);
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
        <h1 class="text-uppercase" style="text-align: center;">Edit single product:</h1>
        <%            DatabaseService dbs = new DatabaseService();
            if (request.getParameter("p") == null)
            {
                if (!response.isCommitted())
                response.sendRedirect("manage.jsp");
            }
            if (request.getParameter("p") != null)
            {
                Integer pid = Integer.parseInt(request.getParameter("p"));
                Product p = dbs.getProductById(pid);

        %>
        <div class="container-fluid">
            <div class="container">    
                <hr>
                <div class="row">
                    <form role="form" action="ManageProduct" method="post" onsubmit="return checkForm(this);">
                        <fieldset>							
                            <div class="col-md-3">
                                <img src="<%= p.getpImage()%>" style="width: 200px; height: 200px;">
                            </div>

                            <div class="col-md-9">
                                <div class="col-md-12"></div>
                                <div class="form-group col-md-6 col-sm-12">
                                    <input type="text" name="name" id="name" class="form-control input-lg" value="<%= p.getpName()%>">
                                </div>
                                <div class="form-group col-md-2 col-sm-12">
                                    <input type="number" name="quantity" id="quantity" class="form-control input-lg" value="<%= p.getpStockNum()%>">
                                </div>
                                <div class="form-group col-md-4 col-sm-12">
                                    <input type="number" name="price" id="price" class="form-control input-lg" value="<%= p.getpPrice()%>">
                                </div>
                                <div class="form-group col-md-12 col-sm-12">
                                    <input type="text" name="desc" class="form-control input-lg" value="<%= p.getpDescription()%>" style="margin-bottom: 40px;">                                
                                </div>
                                <div class="col-md-12"><input type="file" name="img" multiple value="<%= p.getpImage()%>"></div>
                            </div>
                        </fieldset>
                        <div class="col-md-3"></div>
                        <div class="col-md-6">
                            <!--                                <input type="submit" name="update_product" class="btn btn-md btn-primary" value="Update">-->
                            <button type="submit" name="update_product" class="btn btn-md btn-primary" value="<%= p.getpID()%>" formmethod="post" style="width: 100%;">Update</button>
                        </div>
                    </form>
                    <button class="btn btn-md btn-danger" onclick="location.href = 'manage.jsp';">Go back</button>
                </div>          
            </div>
        </div>

        <%
            }
        %>
        <script>
            function goBack()
            {
                window.history.back();
            }
        </script>
    </body>
</html>
