<%-- 
    Document   : status
    Created on : 23 Apr 2024, 14:28:23
    Author     : david
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="style/status.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Status</title>
    </head>
    <body>
         <section id="controls">
        
        <section id="login-info-box">
            <img src="https://i2.pickpik.com/photos/1013/641/84/confident-successful-girl-woman-preview.jpg">
        </section>
        <button onclick="showHiddenMenu()">Leave</button>
        <section class="hidden-menu" id="leave" style="display: none;">
            <form method="post "action="leave">
                <input type="text" placeholder="reason for leave"><br>
                <input type="date" placeholder="start of leave">
                <input type="date" placeholder="end of leave"><br>
                <input type="submit" value="reqiester leave">

            </form>
        </section>
        <button onclick="showHiddenMenu()">Request password change</button>
        <section class="hidden-menu" id="request-a-password-change" style="display: none;">
            <form method="post "action="request-a-password-change">
                <input type="password" placeholder="new password"><br>    
                <input type="password" placeholder="confirm password"><br>    
                <input type="submit" value="">
            </form>
        </section>
        
    </body>
</html>
