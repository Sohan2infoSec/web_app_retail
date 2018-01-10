<%-- 
    Document   : errorUser
    Created on : Dec 18, 2017, 7:19:27 PM
    Author     : Cpt_Snag
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
    </head>
    <body>
        <h1>You input something wrong! Please check again!</h1>
        <button onclick="goBack()">Go Back</button>

        <script>
            function goBack()
            {
                window.history.back();
            }
        </script>
    </body>
</html>
