/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.company.back;

import jakarta.servlet.http.Cookie;
import java.math.BigInteger;
import java.net.http.HttpRequest;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;




/**
 *
 * @author david
 */
public class Util {
        

    public String HashString(String input, String mode){
        String result;
        try{
            
            MessageDigest md = MessageDigest.getInstance(mode);
            
            result = ByteToString(md.digest(input.getBytes(StandardCharsets.UTF_8)));
            
        }catch(NoSuchAlgorithmException e){
           result = "F"; // Thats an acai refrence "Big F"
           System.out.println(e.getMessage());
        }

        
        return result;
    }
    
    public String ByteToString(byte[] in){
        
       BigInteger number = new BigInteger(1, in);
            
            
        StringBuilder hexString = new StringBuilder(number.toString(16));
        while (hexString.length() < 64) {
            hexString.insert(0, '0');
        }
        return (hexString.toString().toLowerCase());
    }
    public String getCookie(HttpRequest request, String name){
        Cookie cookies[] = request.getCookies();  
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(name)) {
                    return cookie.getValue();
                }               
            }
                   
        }
        System.out.println("cookie error ):");
        return "err";
    }

    
   
    
    
    public Util(){
        
    }
}
