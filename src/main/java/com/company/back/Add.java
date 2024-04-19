/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.company.back;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

/**
 *
 * @author david
 */
@WebServlet("/add")
public class Add extends HttpServlet{
    
    Changestuff change;
    Getstuff get;
    ArrayList<String> parameters = new ArrayList();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
            

        
            this.get = new Getstuff();
            this.change = new Changestuff(this.get.GetConnection());
        
        
            System.out.println("SESSION_VALUE: " + request.getSession().getAttribute("EmployeeNumber").toString());
            this.parameters.add(request.getSession().getAttribute("EmployeeNumber").toString());
            this.parameters.add(request.getParameter("officeCode"));
            this.parameters.add(request.getParameter("firstname"));
            this.parameters.add(request.getParameter("lastname"));
            this.parameters.add(request.getParameter("email"));
            this.parameters.add(request.getParameter("extension"));
            this.parameters.add(request.getParameter("jobtitle"));
            this.parameters.add(request.getParameter("password"));

            if(this.parameters.contains("")){
                System.out.println("this.parameters.contains(null)");
                request.setAttribute("error", "All fields are mandatory");
                this.parameters.clear();
                request.getRequestDispatcher("response.jsp").forward(request, response);   
            }

            int res = this.change.AddEmployee(
            Integer.parseInt(this.parameters.get(0)),  
            Integer.parseInt(this.parameters.get(1)),
            this.parameters.get(2),
            this.parameters.get(3),
            this.parameters.get(4),
            this.parameters.get(5),
            this.parameters.get(6),
            this.parameters.get(7)
            );
            
            
            
            if(res == 1){
                request.setAttribute("error", "User already exists");
                this.parameters.clear();
                request.getRequestDispatcher("response.jsp").forward(request, response);   
            }
            // this has not worked too well, too bad!
            // ???

            this.parameters.clear();
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("response.jsp");   
            requestDispatcher.forward(request, response);
    }

}
@WebServlet("/addCustomer")
class AddCustomer extends HttpServlet{
        
    Changestuff change;
    Getstuff get;
    ArrayList<String> parameters = new ArrayList();
    
    @Override
     protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    
	    // cookies code
	    
	    
	    Cookie cookies[]=request.getCookies();  
	

	     if (cookies != null) {
		   for (Cookie cookie : cookies) {
			  if (cookie.getName().equals("empnum")){
                                System.out.println("we are rolling");
                                System.out.println("Empnum_cookie: " + cookie.getValue());
				 this.get = new Getstuff();
				 this.change = new Changestuff(this.get.GetConnection());
					this.parameters.add(request.getParameter("customerName"));
					this.parameters.add(get.GetFromEmployeeNumber(Integer.parseInt(cookie.getValue()),"lastName" , "employees","employeeNumber"));
					this.parameters.add(get.GetFromEmployeeNumber(Integer.parseInt(cookie.getValue()),"firstName" , "employees","employeeNumber"));
					this.parameters.add(request.getParameter("phone"));
					this.parameters.add(request.getParameter("addressline1"));
					this.parameters.add(request.getParameter("addressline2"));
					this.parameters.add(request.getParameter("city"));
					this.parameters.add(request.getParameter("state"));	
					this.parameters.add(request.getParameter("postalCode"));
					this.parameters.add(request.getParameter("country"));
					this.parameters.add(cookie.getValue());
					this.parameters.add(request.getParameter("creditLimit"));


   
                                        // debug print for late scrappers
                                        System.out.println("contact firstname: " + this.parameters.get(1));
                                        
					if(this.parameters.contains("")){
					   System.out.println("this.parameters.contains(null)");
						request.setAttribute("error", "All fields are mandatory");
					     this.parameters.clear();
					     request.getRequestDispatcher("response.jsp").forward(request, response);   
					}
                                        try{
                                            if(Float.parseFloat(this.parameters.get(11)) > 99999.0){
                                                request.setAttribute("error", "The credit limit is set too high!");
                                                request.getRequestDispatcher("response.jsp").forward(request, response);   
                                            }
                                        }catch(Exception e){
                                            request.setAttribute("error", "invalid number format for credit limit");
                                            request.getRequestDispatcher("response.jsp").forward(request, response);   
                                        }
                                            

					int res = this.change.AddCustomer(parameters);
				   if(res == 1){
					 request.setAttribute("error", "Customer already exists");
					 request.getRequestDispatcher("response.jsp").forward(request, response);   
				   }
				   this.parameters.clear();
				   RequestDispatcher requestDispatcher = request.getRequestDispatcher("response.jsp");   
				   requestDispatcher.forward(request, response);
			}
	    }
}else{
     request.setAttribute("error", "Cookie error, have you allowed cookies on this site?");
     RequestDispatcher requestDispatcher = request.getRequestDispatcher("/logout");  
     requestDispatcher.forward(request, response);
}
	  
	    
	    

    }

}
