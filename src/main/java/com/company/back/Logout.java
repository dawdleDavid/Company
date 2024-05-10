/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.company.back;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
<<<<<<< HEAD
import jakarta.servlet.http.Cookie;
=======
>>>>>>> b2120d04b4420e9a9811bf79dbaa42708ec6569c
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 *
 * @author david
 */
@WebServlet("/logout")
public class Logout extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
    try  {
<<<<<<< HEAD
        // set error attribut
        request.getSession().removeAttribute("error");
        request.getSession().removeAttribute("EmployeeNumber"); 
        request.getSession().removeAttribute("Firstname"); 
        request.getSession().removeAttribute("Job"); 
        request.getSession().removeAttribute("Lastname");        
        request.getSession().removeAttribute("Extension");       

	   
        // request.getSession().removeAttribute(LEGACY_DO_HEAD);
        HttpSession session = request.getSession();
        System.out.println("SESSION(Logout): " + session.getId());
        
        // //
        Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                        cookie.setValue("");
                        cookie.setMaxAge(0);
                        cookie.setPath("/");
                        response.addCookie(cookie);
                }
        }
        request.getSession().invalidate();
        request.getRequestDispatcher("index.jsp").forward(request, response);
         
=======
// set error attribut
         request.getSession().removeAttribute("error");
         request.getSession().removeAttribute("EmployeeNumber"); 
         request.getSession().removeAttribute("Firstname"); 
         request.getSession().removeAttribute("Job"); 
         request.getSession().removeAttribute("Lastname");        
         request.getSession().removeAttribute("Extension");       

	   
       request.getSession().removeAttribute(LEGACY_DO_HEAD);
        HttpSession session = request.getSession();
        System.out.println("SESSION(Logout): " + session.getId());
        
         request.getSession().invalidate();
        
         request.getRequestDispatcher("index.jsp").forward(request, response);
>>>>>>> b2120d04b4420e9a9811bf79dbaa42708ec6569c
    }catch(Exception e){
	    System.out.println("logout exception: " + e);
     }    
    }
}
