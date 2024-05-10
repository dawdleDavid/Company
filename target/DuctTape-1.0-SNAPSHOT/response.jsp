<%-- 
    Document   : response
    Created on : 8 Feb 2024, 15:41:48
    Author     : david
--%>
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0);
//prevents caching at the proxy server
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.company.back.Util" %>
<%@page import="com.company.back.Getstuff" %>
<%@page import="com.company.back.Changestuff" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList;" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="style/mainpage.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Company</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <!-- call script-->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="cls/editbox.js"></script>
    </head>
    <body>
       
    <%
        
        
        
        

       // https://www.tutorialspoint.com/jsp/jsp_architecture.htm
       Getstuff get = new Getstuff(); 
       Changestuff change = new Changestuff(get.GetConnection()); 
       Util util = new Util(); 
       Connection connection = get.GetConnection(); 
    %>
   
    <table id="list">
<% 
        int mode = 0;
        ArrayList<String> res = new ArrayList<String>();
        
        String query = null;
        
        
        
        Cookie cookies[]=request.getCookies();  
	String logintime = "<p style=\"color: red;\">time set err</p>";

        String userCookie = "";
        
        /*
            ArrayList som lägger till alla options som skall vara med,
            valideras en extra gåg i minb backend innan ett query körs.
        */
        
        ArrayList<String> options = new ArrayList();
        
     if (cookies != null) {
	    for (Cookie cookie : cookies) {
		   if (cookie.getName().equals("empnum") && request.getSession().getAttribute("ChangePswd").equals("2")) {
			  System.out.println("this is test");
			  out.print(" <h4> You must change password within 3 days, temp password is</h4>"
			  + "<form method=\"post\" action=\"updatepswd\"><br>"
			  + "<input name=\"newpass\" type=\"text\" value=\"\" placeholder=\"password\"><br>"
			  + "<input name=\"newpass_confirm\" type=\"text\" value=\"\" placeholder=\"confirm\"><br>"
			  + "<input type=\"submit\" value=\"change\">"
			  + "</form>");
		   }else if (cookie.getName().equals("empnum")) {
                        // add cookie to response so that the Cahngestuff might use it
                        // set the usercookie locally to string
                        userCookie = cookie.getValue();
                        
		   }
                   if (cookie.getName().equals("logintime")) {
                        logintime = cookie.getValue();
		   }
	    }
}



        
        if(request.getSession().getAttribute("Job").equals("Sales Rep")){
            mode = 1;  
	  
    
			
            query = "SELECT customerNumber FROM customers WHERE salesRepEmployeeNumber='" + request.getSession().getAttribute("EmployeeNumber") + "';";	
            res = get.GetStringListFromQuery(query, "customerNumber");    
             //for(int i = 0; i <= (res.size()-1); i++){
             //        out.print("----" + get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "customerName", "customers", "customerNumber")  + "---");
	    //}

            

            for(int i = 0; i <= (res.size()-1); i++){ 
                    
                    out.print("<tr><th>Customer name</th><th>country</th><th>Customer number</th><th>Postal code</th><th>City</th><th>Credit limit</th></tr>");

                    out.print("<tr class=\"customer\">");
                    out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "customerName", "customers", "customerNumber").get(0) +"</td>");
                    out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "country", "customers", "customerNumber").get(0) +"</td>");
                    out.print("<td>"+ res.get(i) +"</td>");
                    out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "postalCode", "customers", "customerNumber").get(0) +"</td>");
                    out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "city", "customers",  "customerNumber").get(0) +"</td>");
                    out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "creditLimit", "customers",  "customerNumber").get(0) +"</td>");
                    out.print("</tr>");	

                //System.out.println("p_size:" + Integer.toString((MetaRes.size()-1)));
                
                   // add options
                options.add("<option value="+res.get(i)+">"+res.get(i)+"("+ get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "customerName", "customers", "customerNumber").get(0)+")"+"</option>");

                %>
                <td><h4 id="orders-for">orders for <%= get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "customerName", "customers", "customerNumber").get(0)  %></h4></td>
                <tr><th>orderNumber</th><th>requiredDate</th><th>shippedDate</th><th>status</th><th>comments</th></tr>
                <%
                ResultSet result;
                
                
                            

                result = get.GetResultSetFromQuery("SELECT * from orders WHERE customerNumber="+res.get(i)+";", connection);
              
                
                while(result.next()){
                    out.print("<tr class=\"changecolor\">");
                    // out.print("cuz:" +  customernumber);
                    String orderNumber = result.getString("orderNumber");
                    out.print("<td>" + orderNumber + "</td>");	//  kontrollera html för table
                    out.print("<td>" + result.getString("requiredDate") + "</td>");	
                    out.print("<td>" + result.getString("shippedDate") + "</td>");	
                    out.print("<td>" + result.getString("status") + "</td>");	
                    out.print("<td>" + result.getString("comments") + "</td>");
                    
                    // crimes are a comming
                    out.print("<td><button id="+ orderNumber +" onclick="+"editbtn(this.id)"+">edit</button></td>");	
                    
                    out.print("</tr>");


                   %>
                <tr><td colspan="6">
                <section class="info-dump" id="form-<%= result.getString("orderNumber") %>">  <!-- TODO: this id has to go --> 

                <table class="orderdetails">
                        <form class="order-member" method="post" action="updateOrder">
                            <input autocomplete="off" name="requiredDate" type="date" placeholder="requredDate" value=<%=result.getString("requiredDate")%> /><br>
                            <input autocomplete="off" name="shippedDate" type="date" placeholder="shippedDate"value=<%=result.getString("shippedDate")%> /><br>
                            <input autocomplete="off" name="status" type="text" placeholder="status" value=<%=result.getString("status")%> /><br>
                            <textarea name="comment" rows="5" cols="33" placehoder="message"><%=result.getString("comments")%></textarea><br>
                            <input type="submit" value="commit" /><br>
                        </form>


                    <tr><th>Product code</th><th>Quantity</th><th>Price</th><th>Line number</th></tr>
                    <%

                        ResultSet orders;
                        orders = get.GetResultSetFromQuery("SELECT * from orderdetails WHERE orderNumber="+orderNumber+";", connection);
                        while(orders.next()){      
                    %>

                    
                    
                            <tr>
                                <td> <%= orders.getString("productCode") %></td>
                                <td> <%= orders.getString("quantityOrdered") %></td>
                                <td> <%= orders.getString("priceEach") %></td>
                                <td> <%= orders.getString("orderLineNumber") %></td>
                                <td><button id="<%= orders.getString("productCode") %>" onclick="editbtn(this.id)">edit</button></td>    
                            <td class="hidden-td" id="form-<%= orders.getString("productCode") %>" style="display: none;">
                            <!--<section class="info-dump" id="form-<%= orders.getString("productCode") %>" style="display: none;">  -->
                                <form class="order-member" method="post" action="updateOrderDetails">
                                    <input autocomplete="off" name="productCode" type="text" placeholder="productCode" value=<%=orders.getString("productCode")%> /><br>
                                    <input autocomplete="off" name="quantityOrdered" type="text" placeholder="quantityOrdered"value=<%=orders.getString("quantityOrdered")%> /><br>
                                    <input autocomplete="off" name="priceEach" type="text" placeholder="priceEach" value=<%=orders.getString("priceEach")%> /><br>
                                    <input name="orderLineNumber" placehoder="orderLineNumber" type="number" value="<%=orders.getString("orderLineNumber")%>"/><br>
                                    <input type="submit" value="commit" />
                                </form>
                             <!--</section> -->
                            </td> 
                            </tr>   
                    <%}%>
                </table>
                    <form class="post-order" method="post" action="postToOrder" onsubmit="setCookie('orderCookie', <%=orderNumber%>)">
                        <input autocomplete="off" name="productCode" type="text" placeholder="productCode" value="" /><br>
                        <input autocomplete="off" name="quantityOrdered" type="text" placeholder="quantityOrdered" value="" /><br>
                        <input autocomplete="off" name="priceEach" type="text" placeholder="priceEach" value="" /><br>
                        <input autocomplete="off" name="orderLineNumber" type="text" placeholder="orderLineNumber" value="" /><br>
                        <input type="submit" value="commit" />
                    </form>
                </section></td></tr>
    <%}%>
<%
}



    }else{


%>

<div id="scroll">
          <tr><th>id</th><th>First Name</th><th>last name</th><th>Extension</th><th>Email</th><th>Job Title</th></tr>
  <%
        query = "SELECT * FROM employees WHERE reportsTo='"+ request.getSession().getAttribute("EmployeeNumber") +"';";
        //res = get.GetStringListFromQuery(query, "employeeNumber");
            
	if(res == null){
	    System.out.println("die");
	}
        // samma resultset som tidigare
        ResultSet result = get.GetResultSetFromQuery(query, connection);
        while(result.next()){
                    out.print("<tr class="+"changecolor"+">");
                    out.print("<td>" + result.getString("employeeNumber") + "</td>");	
                    out.print("<td>" + result.getString("firstName") + "</td>");	
                    out.print("<td>" + result.getString("lastName") + "</td>");	
                    out.print("<td>" + result.getString("extension") + "</td>");	
                    out.print("<td>" + result.getString("email") + "</td>");
                    out.print("<td>" + result.getString("jobTitle") + "</td>");
                    out.print("</tr>");
        }	
    }

    %>
    <!-- Audio tag -->
    <audio controls id="phone" style="display: none;">
     <source src="cls/office_phone-ring_medium-loudaif-14604.mp3" type="audio/mp3">
     Your browser does not support the audio tag.
   </audio> 
    </table>   
        
     
<section class="controls"><br>
            <form class="controls-member" method="post" action="logout">
                <input class="controls-member"  type="submit" value="logout">
            </form>
            <a href="status.jsp">employee status</a>
    

               <% 
                    if(mode == 0)	
                    { 
                %>
                    <h2>Add Employee</h2>
                    <form class="controls-member" method="post" action="add">
                        <input autocomplete="off" name="firstname" type="text" placeholder="firstname" value=""><br>
                        <input autocomplete="off" name="officeCode" type="text" placeholder="officecode" value=""><br>
                        <input autocomplete="off" name="lastname" type="text" placeholder="lastname" value=""><br>
                        <input autocomplete="off" name="email" type="text" placeholder="email" value=""><br>
                        <input autocomplete="off" name="extension" type="text" placeholder="extension" value=""><br>
                        <input autocomplete="off" name="jobtitle" type="text" placeholder="jobtitle" value=""><br>
                        <input autocomplete="off" name="password" type="password" placeholder="password" value=""><br>
                        <input type="submit" value="commit">
                    </form>
                <% }else if(mode == 1){ 
                %>

                    <section id="phone-section">                
                    <!-- <img src="https://upload.wikimedia.org/wikipedia/commons/6/6c/Phone_icon.png" alt="phone"> -->

                    <button>Answer</button>
                    <button>Hang up</button>
                    <button>+5</button>
                    <button id="busy" onclick="answerphone(this.id)">Busy</button>
                    <button>auto</button>
                    <button>Answer</button>


                    </section>
                    <h2>Add Customer</h2>
                    <form class="controls-member" method="post" action="addCustomer">
                        <input autocomplete="off" name="customerName" type="text" placeholder="Full name off customer" value=""><br>
                        <input autocomplete="off" name=phone" type="text" placeholder="phone" value=""><br>
                        <input autocomplete="off" name="addressline1" type="text" placeholder="addressline 1" value=""><br>
                        <input autocomplete="off" name="addressline2" type="text" placeholder="addressline 2" value=""><br>
                        <input autocomplete="off" name="city" type="text" placeholder="city" value=""><br>
                        <input autocomplete="off" name="state" type="text" placeholder="state" value=""><br>
                        <input autocomplete="off" name="postalCode" type="text" placeholder="postalCode" value=""><br>
                        <input autocomplete="off" name="country" type="text" placeholder="country" value=""><br>
                        <input autocomplete="off" name="creditLimit" type="text" placeholder="creditLimit" value=""><br>
                        <input type="submit" value="commit">
                    </form>
                    <h2>Add order</h2>                  
                    <form class="controls-member" method="post" action="addOrder">
                        <!-- <input id="controls-member" autocomplete="off" name="customerNumber" type="text" placeholder="customerNumber" value=""><br> -->
                        
                        <select width=300 name="customerNumber">
                            <%
                            for(int i = 0; i <= options.size()-1; i++){
                                out.print(options.get(i));
                            }
                            %>
                        </select><br>    
                        <label for="requiredDate">required date</label><br>
                        <input class="controls-member" autocomplete="off" name="requiredDate" type="date" placeholder="startdate" value=""><br>
                        <label for="shippedDate">shipped date</label><br> 
                        <input class="controls-member" autocomplete="off" name="shippedDate" type="date" placeholder="shippeddate" value=""><br>
                        <label for="orderDate">order date</label><br>
                        <input class="controls-member" autocomplete="off" name="orderDate" type="date" placeholder="orderdate" value=""><br>
                        <select width=300  name="status">

                            <option value="Shipped">Shipped</option>
                            <option value="Not shipped">Not shipped</option>
                            <option value="Shipping">Shipping</option>
                            <option value="Awaiting payment">Awaiting payment</option>
                            <option value="see comment">see comment</option>
                        </select><br>    
                        <label for="html">comment</label><br>
                        <textarea class="controls-member" autocomplete="off" name="comment" rows="5" cols="33" placehoder="message"></textarea>
                        <input type="submit" value="commit">
                    </form>
                <%}
                    /* closing connection */
                    connection.close();
                %>             
                <span style="color: lightcoral;"name="error">${error}</span> 
            
        </section> 	  
    </section>
</section>
    
    
    </body>
    
    
    
</html>
<!-- https://waitbutwhy.com/2013/11/how-to-beat-procrastination.html -->