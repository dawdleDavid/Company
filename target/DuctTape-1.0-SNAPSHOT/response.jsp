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
<%@page import="java.util.ArrayList;" %>
<!DOCTYPE html>
<html>

    <head>
        <link rel="stylesheet" href="style/mainpage.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Company</title>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <script src="cls/editbox.js"></script>
    </head>
    <body>
       
    <%
       // https://www.tutorialspoint.com/jsp/jsp_architecture.htm
       Getstuff get = new Getstuff(); 
       Changestuff change = new Changestuff(get.GetConnection()); 
       Util util = new Util(); 
       /*Cookies*/
       //UserCookie.setMaxAge(60*60);
       //response.addCookie(UserCookie);
    %>
   
    <table id="list">
<% 
        int mode = 0;
        ArrayList<String> res = new ArrayList<String>();
        ArrayList<String> MetaRes = new ArrayList<String>();
        String query = null;
        
        Cookie cookies[]=request.getCookies();  
	String logintime = "<p style=\"color: red;\">time set err</p>";

        String userCookie = "";
        
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
	  
  
            out.print("<tr><th>Customer name</th><th>country</th><th>Employee Number(you)</th><th>Postal code</th><th>City</th><th>Credit limit</th></tr>");

			
            query = "SELECT customerNumber FROM customers WHERE salesRepEmployeeNumber='" + request.getSession().getAttribute("EmployeeNumber") + "';";	
            res = get.GetStringListFromQuery(query, "customerNumber");    
             //for(int i = 0; i <= (res.size()-1); i++){
             //        out.print("----" + get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "customerName", "customers", "customerNumber")  + "---");
	    //}

            for(int i = 0; i <= (res.size()-1); i++){
                out.print("<tr class="+"changecolor"+">");
                out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "customerName", "customers", "customerNumber").get(0) +"</td>");
                out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "country", "customers", "customerNumber").get(0) +"</td>");
                out.print("<td>"+ res.get(i) +"</td>");
                out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "postalCode", "customers", "customerNumber").get(0) +"</td>");
                out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "city", "customers",  "customerNumber").get(0) +"</td>");
                out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "creditLimit", "customers",  "customerNumber").get(0) +"</td>");
                //out.print("<td><button  onclick="+"showUpdateBox()"+">update</button></td>");
                out.print("</tr>");	
                MetaRes = get.GetStringListFromQuery("SELECT DISTINCT customerNumber FROM orders WHERE customerNumber='" +res.get(i) + "';", "customerNumber");	    
                    System.out.println("p_size:" + Integer.toString((MetaRes.size()-1)));
                    out.print("<tr><th>orderNumber</th><th>requiredDate</th><th>shippedDate</th><th>status</th><th>comments</th></tr>");

                    for(int p = 0;p<= (MetaRes.size()-1);p++){

                          out.print("<tr class="+"orders"+">");

                          out.print("<div style=\"display: hidden;\">");
                          out.print("<td >"+ get.GetFromEmployeeNumber(Integer.parseInt(MetaRes.get(p)), "orderNumber", "orders", "customerNumber") +"</td>");
			  out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(MetaRes.get(p)), "requiredDate", "orders", "customerNumber") +"</td>");
			  out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(MetaRes.get(p)), "shippedDate", "orders", "customerNumber") +"</td>");
			  out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(MetaRes.get(p)), "status", "orders",  "customerNumber") +"</td>");
			  out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(MetaRes.get(p)), "comments", "orders",  "customerNumber") +"</td>");		  

                          out.print("</tr>");
		  }
	
	 out.print("</tr>");	
     }
     }else{
            out.print("<tr><th>First name</th><th>Last name</th><th>Employee number</th><th>Position</th><th>Extension</th><th>Edit</th></tr>");
   
            query = "SELECT employeeNumber FROM employees WHERE reportsTo='"+ request.getSession().getAttribute("EmployeeNumber") +"';";
            res = get.GetStringListFromQuery(query, "employeeNumber");
            
	if(res == null){
	    System.out.println("die");
	}
		
		
		
           for(int i = 0; i <= (res.size()-1); i++){
	     
	  if(get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "requirePwdChange", "employees", "employeeNumber").equals("1")){
		   out.print(get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "firstName", "employees", "employeeNumber") + " " + get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "lastName", "employees", "employeeNumber") + " has requested a password change.<br>");
		   out.print("<form method=\"post\" action=\"changepswd\"><input name=\" " + Integer.parseInt(res.get(i)) + "\" type=\"submit\" value=\"allow\"><br><input name=\"deny\"  type=\"submit\" value=\"deny\"><br></form>");		   
	   }   
                out.print("<tr class="+"changecolor"+">");
                out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "firstName", "employees", "employeeNumber").get(0) +"</td>");
                out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "lastName", "employees", "employeeNumber").get(0) +"</td>");
                out.print("<td>"+ res.get(i) +"</td>");
                out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "jobTitle", "employees", "employeeNumber").get(0) +"</td>");
                out.print("<td>"+ get.GetFromEmployeeNumber(Integer.parseInt(res.get(i)), "extension", "employees", "employeeNumber").get(0) +"</td>");
                out.print("<td><form method="+"post"+" action="+"change"+"></form>");
                out.print("<td><button  onclick="+"showUpdateBox()"+">update</button></td>");
                out.print("</tr>");
            }  
        }
    %>
    </table>

     <%-- 
     Vi får helt enkelt ladda in filer allt eftersom.... Det kan låta lite trassligt, vilket det kommer att vara,
     men det är den bästa lösningen jag kan komma på just nu. Servern listar ut vilken nivå på privilegiestegen du är
     och agerar enligt det...
    --%>

	 
        <!--<button onclick="hideBox()">exit</button> -->
   
    <!--<div id="change_password"> 
        <button onclick="hideBox()">exit</button>
    </div>-->
	  

    <span style="color: lightcoral;"name="error">${error}</span> 


    
 
    <section id="controls">
        
        <section id="login-info-box">
            <h4>Welcome,  ${Firstname}!</h4>
            <h4>Logged in at: <%= logintime%></h4>    
            <ul>
                <li>${Job}</li>
                <li>${Extension}</li>
            </ul>
        </section>

    
        
        
        
        <button  class="add_Employee_box" id="controls-member" onclick="showBox()">Add</button><br>
            <button class="update_box" id="controls-member" onclick="showUpdateBox()">Update</button><br>
            <form id="controls-member" method="post" action="logout">
                <input id="controls-member"  type="submit" value="logout">
            </form>
	    <section id="control-panel"><br>
            <form id="controls-member" method="post">
		 <input id="controls-member"  type="submit" value="add order"><br>
		 <input id="controls-member"  type="submit" value="update"><br>	 
		 <input id="controls-member"  type="submit" value="add">	 
            </form>
            <textarea id="controls-member" name="story" rows="5" cols="33" placehoder="message">yrdy</textarea>
            
 <%
            if(mode == 0){	
               out.print("<form id=\"controls-member\" method=\"post\" action=\"add\">"
                    + "<input id=\"controls-member\" autocomplete=\"off\" name=\"firstname\" type=\"text\" placeholder=\"firstname\" value=\"\"><br>"
                    + "<input id=\"controls-member\" autocomplete=\"off\" name=\"officeCode\" type=\"text\" placeholder=\"officecode\" value=\"\"><br>"
                    + "<input id=\"controls-member\" autocomplete=\"off\" name=\"lastname\" type=\"text\" placeholder=\"lastname\" value=\"\"><br>"
                    + "<input id=\"controls-member\" autocomplete=\"off\" name=\"email\" type=\"text\" placeholder=\"email\" value=\"\"><br>"
                    + "<input id=\"controls-member\" autocomplete=\"off\" name=\"extension\" type=\"text\" placeholder=\"extension\" value=\"\"><br>"
                    + "<input id=\"controls-member\" autocomplete=\"off\" name=\"jobtitle\" type=\"text\" placeholder=\"jobtitle\" value=\"\"><br>"
                    + "<input id=\"controls-member\" autocomplete=\"off\" name=\"password\" type=\"password\" placeholder=\"password\" value=\"\"><br>"
                                   + "<input type=\"submit\" value=\"commit\"></form>");	  
            }else if(mode == 1){ // sales rep
               out.print(" <form id=\"controls-member\" method=\"post\" action=\"addCustomer\">"
                   + "<input id=\"controls-member\" autocomplete=\"off\" name=\"customerName\" type=\"text\" placeholder=\"Full name off customer\" value=\"DAvid\"><br>"
                   + "<input id=\"controls-member\" autocomplete=\"off\" name=\"phone\" type=\"text\" placeholder=\"phone\" value=\"070 890 90 89\"><br>"
                   + "<input id=\"controls-member\" autocomplete=\"off\" name=\"addressline1\" type=\"text\" placeholder=\"addressline 1\" value=\"Huddingevagen 1\"><br>"
                   + "<input id=\"controls-member\" autocomplete=\"off\" name=\"addressline2\" type=\"text\" placeholder=\"addressline 2\" value=\"Huddingevagen 2\"><br>"
                   + "<input id=\"controls-member\" autocomplete=\"off\" name=\"city\" type=\"text\" placeholder=\"city\" value=\"Stockholm\"><br>"
                   + "<input id=\"controls-member\" autocomplete=\"off\" name=\"state\" type=\"text\" placeholder=\"state\" value=\"Stockholm\"><br>"
                   + "<input id=\"controls-member\" autocomplete=\"off\" name=\"postalCode\" type=\"text\" placeholder=\"postalCode\" value=\"14144\"><br>"
                   + "<input id=\"controls-member\" autocomplete=\"off\" name=\"country\" type=\"text\" placeholder=\"country\" value=\"sweden\"><br>"
                   + "<input id=\"controls-member\" autocomplete=\"off\" name=\"creditLimit\" type=\"text\" placeholder=\"creditLimit\" value=\"90 000\"><br>"
                   + "<input type=\"submit\" value=\"commit\">"
                                       + "</form>");	  
                         }
 %>
            
            
  </section> 
	  
    </section>
        
    <footer>
	   <ul style="list-style-type: none;">
		  <li>082-345-34-23</li>
		  <li>company@support.com</li>
		  <li>Company: Cars for all</li>
	   </ul>
    </footer>
    
    
    </body>
    
    
    
</html>
<!-- https://waitbutwhy.com/2013/11/how-to-beat-procrastination.html -->