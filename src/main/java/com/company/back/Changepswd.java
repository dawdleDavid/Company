/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.company.back;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.PasswordAuthentication;
import java.util.Enumeration;


/**
 *
 * @author david
 */

// this issome
@WebServlet("/changeps")
class changeps extends HttpServlet {
         @Override
         protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	   Getstuff get = new Getstuff();
	   Changestuff change = new Changestuff(get.GetConnection());
	   
	   if(change.RequestPasswordChange(request.getParameter("employee"), "1" ) == 0){
		  request.setAttribute("response", "a password change has been requested");
		  // respond back to index
		  request.getRequestDispatcher("index.jsp").forward(request, response);
	   }else{
		  request.setAttribute("error", "employee not found");
		  request.getRequestDispatcher("changepswd.jsp").forward(request, response);
	   }
     }
}

@WebServlet("/changepswd")
public class Changepswd extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	    Enumeration<String> names = request.getParameterNames();
	   
	   String empnum = names.nextElement();
	    
	   
	   System.out.println(empnum);
	   
	   System.out.println("empnum:" + empnum);
	   
	   Getstuff get = new Getstuff();
	   Changestuff change = new Changestuff(get.GetConnection());
	   Util util = new Util();
	   
	  String hashed_password =   util.HashString("temporary", "SHA-256");

	   
	   if(empnum .equals("deny")){
		  System.out.println("deny");
		  change.RequestPasswordChange(empnum, "0");
	   }else{
		  System.out.println("allow");
		  change.RequestPasswordChange(empnum, "2");
		  change.genericQuery("UPDATE employees SET password='" + hashed_password + "' WHERE employeeNumber ='"+ empnum +"';");	  
	   }
	   

	   
	   request.getRequestDispatcher("response.jsp").forward(request, response);
	   

    }
}
@WebServlet("/updatepswd")
class UpdatePswd extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     
	   Getstuff get = new Getstuff();
	   Util util = new Util();
	   Changestuff change = new Changestuff(get.GetConnection());
	   
	   
	   System.out.println("UpdatePswd test");
	   
	   
	   Enumeration<String> names = request.getParameterNames();
	   
	   String empnum = names.nextElement();
	   
	   if(!request.getParameter("newpass").equals(request.getParameter("newpass_confirm"))){
		   request.setAttribute("error", "passwords not the same");
		   request.getRequestDispatcher("response.jsp").forward(request, response);
	   }
	   
	   
	   String hashed_password =   util.HashString(request.getParameter("newpass_confirm"), "SHA-256");
	   
	   
	   
	   Cookie[] cookies = request.getCookies();
	   if (cookies != null) {
		   for (Cookie cookie : cookies) {
		   if (cookie.getName().equals("empnum")) {
		   	   change.genericQuery("UPDATE employees SET password='" + hashed_password + "' WHERE employeeNumber ='"+ cookie.getValue() +"';");
			   change.RequestPasswordChange(cookie.getValue() , "0");
			   request.getRequestDispatcher("logout").forward(request, response);
		   }
	    }
	}else{
	  change.closeConnection();
	   
	   request.setAttribute("error", "session error, usercookie not set");
    	   request.getRequestDispatcher("response.jsp").forward(request, response);
	   }
    }
}