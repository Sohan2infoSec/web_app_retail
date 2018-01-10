<%-- 
    Document   : single_product
    Created on : Dec 20, 2017, 4:06:45 PM
    Author     : Cpt_Snag
--%>

<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="obj.Comment"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ultilities.SessionService"%>
<%@page import="database.DatabaseService"%>
<%@page import="obj.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">

        <link rel="stylesheet" href="css/flexslider.css" type="text/css" media="screen" />        
        <link rel="stylesheet" type="text/css" href="css/style1.css">
        <link rel="stylesheet" type="text/css" href="css/style2.css">
        <link rel="stylesheet" type="text/css" href="css/mystyle.css">

        <link href='https://fonts.googleapis.com/css?family=Oxygen:400,300,700' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Lora' rel='stylesheet' type='text/css'>
        <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
        <script src="js/imagezoom.js"></script>
        <script src="js/jquery.flexslider.js"></script>

        <title>JSP Page</title>
        <style>
            .body
            {
                box-sizing: border-box;
            }
            .log-out
            {
                background-color: transparent;
                color: white;
                font-size: 0.8em;
            }

            .myBtn
            {
                color: white;
                background-color: black;
                border: none;
                display: inline-block;
                vertical-align: middle;
                overflow: hidden;
                text-decoration: none;
                padding: 8px 16px;
                text-align: center;
                cursor: pointer;
                white-space: nowrap;
                margin-top: 15px;
            }
            .myBtn:hover
            {
                color: white;
                background-color: #ccc;
            }
            .myBtn span
            {
                color: black;
                background-color: white;
                display: inline-block;
                padding-left: 8px;
                padding-right: 8px;
                text-align: center;
            }

            .comment
            {
                display: block;
                width: 70%;
                border: 1px solid #ccc;
                padding: 16px 10px;
                margin-bottom: 15px;
                margin-top: 15px;
                float: left;
                overflow: visible;
            }
            .commentBtn
            {
                color: white;
                background-color: black;
                border-radius: 2px;

                width: 20%;
                border: 1px solid #ccc;
                padding: 16px 10px;
                margin: 15px;
                float: left;
            }

            .w3-show
            {
                display: block!important;
                text-align: justify;
            }

            .comment-row
            {
                position: relative;
                display: block;
                text-align: left;
                clear: left;
                width: 100%;
                margin-left: 15%;
                margin-bottom: 15px;
            }

            .comment-row:before, .comment-row:after
            {
                display: table;
            }

            .comment h4
            {
                font-family: "Oswald";
                font-size: 20px;
                font-weight: 400;
                margin: 10px 0;
            }

            .like
            {
                left: 10px;
                width: 5%;
                padding-top: 5px;
                padding-left: 0px;
                padding-right:  0px;
            }
            .content
            {
                margin-bottom: 25px;
            }
            .date
            {
                font-size: 15px;
                opacity: 0.60;
                font-family: "Oswald";
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
                                    <li><a href="cart.jsp"> SHOPPING-CART</a></li>
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


        <div class="single">
            <div class="container">
                <%
                    DatabaseService dbs = new DatabaseService();

                    if (request.getParameter("p") == null)
                    {
                        response.sendRedirect("index.jsp");
                    }
                    else
                    {
                        Integer p_id = Integer.parseInt(request.getParameter("p"));
                        //out.println("Hi world " + p_id);

                        System.out.println(dbs.getProductById(p_id));
                        if (dbs.getProductById(p_id) != null)
                        {
                            Product p = dbs.getProductById(p_id);

                %>
                <div class="col-md-6 single-right-left animated wow slideInUp animated" data-wow-delay=".5s" style="visibility: visible; animation-delay: 0.5s; animation-name: slideInUp;">
                    <div class="grid image_3_of_2">
                        <div class="flexslider">
                            <!-- FlexSlider -->
                            <script>
                                // Can also be used with $(document).ready()
                                $(window).load(function ()
                                {
                                    $('.flexslider').flexslider({
                                        animation: "slide",
                                        controlNav: "thumbnails"
                                    });
                                });
                            </script>
                            <!-- //FlexSlider-->

                            <ul class="slides">
                                <li data-thumb="<%= p.getpImage()%>">
                                    <div class="thumb-image"> <img src="<%= p.getpImage()%>" data-imagezoom="true" class="img-responsive"> </div>
                                </li>
                                <li data-thumb="<%= p.getpImage()%>">
                                    <div class="thumb-image"> <img src="<%= p.getpImage()%>" data-imagezoom="true" class="img-responsive"> </div>
                                </li>	
                                <li data-thumb="<%= p.getpImage()%>">
                                    <div class="thumb-image"> <img src="<%= p.getpImage()%>" data-imagezoom="true" class="img-responsive"> </div>
                                </li>	
                                <li data-thumb="<%= p.getpImage()%>">
                                    <div class="thumb-image"> <img src="<%= p.getpImage()%>" data-imagezoom="true" class="img-responsive"> </div>
                                </li>	
                            </ul>
                            <div class="clearfix"></div>
                        </div>	
                    </div>
                </div>
                <div class="col-md-6 single-right-left simpleCart_shelfItem animated wow slideInRight animated" data-wow-delay=".5s" style="visibility: visible; animation-delay: 0.5s; animation-name: slideInRight;">
                    <h3><%= p.getpName()%></h3>
                    <p><span class="item_price"><%= NumberFormat.getIntegerInstance().format(p.getpPrice())%> VND</span></p>
                    <div class="color-quality">
                        <h3>Description</h3>
                        <p><%= p.getpDescription()%></p>
                    </div>
                    <%
                        if (session.getAttribute("user") != null || session.getAttribute("admin") != null)
                        {
                    %>
                    <form action="mainpage" method="POST" name="cartForm">
                        <div class="color-quality">
                            <div class="color-quality-right">
                                <h3>Quality:</h3>
                                <select name="quantity" id="country1" onchange="change_country(this.value)" class="frm-field required sect">
                                    <option value="1">1 Qty</option>
                                    <option value="2">2 Qty</option> 
                                    <option value="3">3 Qty</option>					
                                    <option value="10">10 Qty</option>								
                                </select>
                            </div>
                        </div>

                        <div class="occasional"></div>

                        <div class="occasion-cart">
                            <!--                        <a href="#" class="item_add hvr-outline-out button2">Add to cart</a>-->

                            <button type="submit" name="add_to_cart" value="<%= p_id%>" formmethod="POST" 
                                    class="item_add hvr-outline-out button2 add-to-cart" 
                                    onclick="alert('Added ' + document.cartForm.quantity.value + ' item!')"><span class="glyphicon glyphicon-shopping-cart"></span>Add this item to cart!</button>
                        </div>
                    </form>

                    <%
                            }

                        }
                        else
                        {
                            response.sendRedirect("index.jsp");
                        }
                    %>
                </div>

                <div class="clearfix"> </div>
                <hr>
                <%
                    ArrayList<Comment> cList = dbs.getCommentByPID(p_id);
                    if (cList == null)
                    {
                %>
                <div>
                    <p class="review">
                        <button id="myBtn" class="myBtn" onclick="showFunction('demo');">
                            <b>Reviews &nbsp;</b>
                            <span>3</span>
                        </button>
                    </p>
                    <form method="post" action="mainpage">
                        <div id="demo" style="display: none;" class>
                            <input type="text" name="comment" class="comment" placeholder="Your review about this product">
                            <button type="text" name="add_comment" value="<%= p_id%>" class="commentBtn" formmethod="post">Add a comment</button>
                            <div class="comment-row">
                                <h4><b>Sang</b>
                                    <span class="date">April 7, 2015, 9:12 PM</span>
                                </h4>
                                <p>Great product keep moving..</p>
                            </div>

                            <hr>
                            <div class="comment-row">
                                <h4><b>Sang</b>
                                    <span class="date">April 7, 2015, 9:12 PM</span>
                                </h4>
                                <p>Great product keep moving..</p>
                            </div>

                            <hr>
                            <div class="comment-row">
                                <h4><b>Sang</b>
                                    <span class="date">April 7, 2015, 9:12 PM</span>
                                </h4>
                                <p>Great product keep moving..</p>
                            </div>
                        </div>
                    </form>
                </div>
                <%
                }
                else
                {
                %>    
                <div>
                    <p class="review">
                        <button id="myBtn" class="myBtn" onclick="showFunction('demo');">
                            <b>Reviews &nbsp;</b>
                            <span><%= cList.size()%></span>
                        </button>
                    </p>
                    <%
                        if (session.getAttribute("user") == null && session.getAttribute("admin") == null)
                        {
                            %>
                            <hr>
                            <p><a href="login.jsp" style="color: blue;;">Login</a> to view and give comments</p>
                    <%
                        }
                        else
                        {
                    %>
                    <form method="post" action="mainpage">
                        <div id="demo" style="display: none;" class>
                            <input type="text" name="comment" class="comment" placeholder="Your review about this product">
                            <button type="text" name="add_comment" value="<%= p_id%>" class="commentBtn" formmethod="post">Add a comment</button>

                            <%
                                Collections.sort(cList, new Comparator<Comment>()
                                {
                                    public int compare(Comment o1, Comment o2)
                                    {
                                        return o2.getDate().compareTo(o1.getDate());
                                    }
                                });

                                Collections.sort(cList, new Comparator<Comment>()
                                {
                                    public int compare(Comment o1, Comment o2)
                                    {
                                        return o2.getLike().compareTo(o1.getLike());
                                    }
                                });
                                for (Comment c : cList)
                                {
                            %>

                            <div class="comment-row">
                                <div class="col-md-1" style="padding-right: 0px; width: 5%;">
                                    <button name="upvote" value="<%= c.getCid()%>" formmethod="post"><i class="fa fa-2x fa-thumbs-o-up" aria-hidden="true"></i></button>
                                    <br>
                                    <button name="downvote" value="<%= c.getCid()%>" formmethod="post"><i class="fa fa-2x fa-thumbs-o-down" aria-hidden="true"></i></button>
                                </div>
                                <div class="col-md-1 like">
                                    <b style="margin-left: 20%; font-size: 40px; margin: 0px; padding: 0px;"><%= c.getLike()%></b>
                                </div>
                                <div class="col-md-6 content">                     
                                    <h4><b><%= c.getEmail()%></b>
                                        <span class="date"><%= c.getDate()%></span>
                                    </h4>
                                    <p><%= c.getComment()%></p>
                                </div>
                                <div class="col-md-5"></div>          
                            </div>
                            <div class="col-md-12"> <hr></div>
                                <%
                                    }
                                %>
                        </div>
                    </form>
                </div>
                <%
                            }
                        }
                    }

                %>

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
        <script>
            function showFunction(id)
            {
                var x = document.getElementById(id);
                if (x.className.indexOf("w3-show") == -1)
                {
                    x.className += " w3-show";
                }
                else
                {
                    x.className = x.className.replace(" w3-show", "");
                }
            }
        </script>
        <!-- jQuery (Bootstrap JS plugins depend on it) -->
        <script type="text/javascript" src="js/bootstrap-3.1.1.min.js"></script><!--
        -->                <script src="js/bootstrap.min.js"></script><!--
        -->                <script src="js/script.js"></script>
    </body>
</html>
