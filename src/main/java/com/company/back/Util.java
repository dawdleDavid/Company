/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.company.back;

import jakarta.mail.Session;
import jakarta.mail.Transport;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Properties;




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
    
   
    
    public Util(){
        
    }
}
