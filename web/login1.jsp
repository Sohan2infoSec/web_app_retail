<%-- 
    Document   : login
    Created on : Dec 16, 2017, 12:37:04 PM
    Author     : Cpt_Snag
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="js/core.js"></script>
        <script type="text/javascript" src="js/validation.js"></script>
        <title>JSP Page</title>
    </head>
    <body>

        <form method="POST" action="LoginHandler" name="form1">
            <table>
                <tr>
                    <td><h1>Login:</h1></td>
                </tr>
                <tr>
                    <td>Email:<input type="text" name="email"> </td>
                    <td>Password:<input type="password" name="password"> </td>
                    <td><input type="submit" name="login"></td>
                </tr>

                <tr>
                    <td><h1>Or you can Register:</h1></td>
                </tr>

                <tr>
                    <td>Email:</td>
                    <td><input type="email" name="re_email"></td>
                </tr>
                <tr>
                    <td>Password:</td>
                    <td><input type="password" name="re_password"></td>
                </tr>
                <tr>
                    <td>Retype-password:</td>
                    <td><input type="password" name="re_password0"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" name="register" onclick="return validate(document.form1)" ></td>
                </tr>

            </table>
        </form>
        
    </body>
</html>
