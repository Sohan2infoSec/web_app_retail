<%-- 
    Document   : loginPage
    Created on : Dec 20, 2017, 10:44:47 PM
    Author     : Admin
--%>

<%@page import="ultilities.CookieService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        
        <script type="text/javascript" src="js/core.js"></script>
        <script type="text/javascript" src="js/validation.js"></script>
    </head>
    <body>

        <br>
        <div class="container-fluid">
            <div class="container">
                <h2 class="text-center" id="title">Register and Login</h2>
                <hr>
                <div class="row">
                    <div class="col-md-5">
                        <form role="form" action="LoginHandler" method="post">
                            
                            <fieldset>							
                                <p class="text-uppercase"> Login using your account: </p>	

                                <div class="form-group">
                                    <input type="text" name="email" id="username" class="form-control input-lg" placeholder="Email">
                                </div>
                                <div class="form-group">
                                    <input type="password" name="password" id="password" class="form-control input-lg" placeholder="Password">
                                </div>
                                <div>
                                    <input type="submit" name="login" class="btn btn-md btn-primary" value="Sign In">
                                </div>

                            </fieldset>
                        </form>	
                    </div>

                    <div class="col-md-2">
                        <!-------null------>
                    </div>

                    <div class="col-md-5">
                        <form role="form1" method="post" action="LoginHandler" name="form1">
                            
                            <fieldset>							
                                <p class="text-uppercase pull-center"> SIGN UP.</p>	
                                <div class="form-group">
                                    <input
                                        type="email" name="re_email"
                                        id="email"
                                        class="form-control input-lg"
                                        placeholder="Email"
                                        required
                                        >
                                </div>
                                <div class="form-group">
                                    <input type="password" name="re_password" id="re_password" class="form-control input-lg" placeholder="Password">
                                </div>
                                <div class="form-group">
                                    <input type="password" name="re_password0" id="re_password0" class="form-control input-lg" placeholder="Password Confirm">
                                </div>

                                <div>
                                    <input type="submit" name="register" class="btn btn-lg btn-primary" value="Register" onclick="return validate(document.form1)">
                                </div>
                            </fieldset>
                        </form>
                    </div>          
                </div>
            </div>
        </div> 
    </body>
</html>
