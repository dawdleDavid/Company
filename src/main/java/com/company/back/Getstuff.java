/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.company.back;

import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author david
 */
public class Getstuff {
      
    String url;
    String mysql_username;
    String mysql_password;

    public Connection GetConnection() {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // låt oss test denna istället
        Connection connection = DriverManager.getConnection(this.url, this.mysql_username, this.mysql_password);
        return connection;
    }catch (ClassNotFoundException e) {
        System.out.println("ClassNotFoundException(GetConnection): " + e.getMessage());
        return null;
    }catch(SQLException e){
        System.out.println("SQLException(GetConnection): " + e.getMessage());
        return null;
    }
    }

    public ArrayList<String> GetFromEmployeeNumber(int employeeNumber, String column, String table, String cond){
        ArrayList<String> retval = new ArrayList(); 

        try{
            Connection connection = GetConnection();
    
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery("SELECT " + column + " FROM "+ table +" WHERE "+cond+" =" + employeeNumber + ";");

            while(result.next()){
		   retval.add(result.getString(column));
            }
            connection.close();
        }catch(SQLException e){
            // some black magic going on with this SQL exception.... 
            System.out.println("SQLException(GetFromEmployeeNumber): " + e);
        }
        if(retval.isEmpty()){
            retval.add("<p style=\"color: red;\">no data</p>");
        }
        
        System.out.println("retval: " + retval.toString());
        
        
        return retval;
    }
    public ResultSet GetResultSetFromQuery(String query, Connection connection){
        try{
            Statement statement = connection.createStatement();  
            ResultSet result = statement.executeQuery(query);  
            return result;
        }catch(SQLException e){
            System.out.println("SQLException(GetResultSetFromQuery): "  + e);
        }
        return null;   
    }
    
    public ArrayList<String> GetStringListFromQuery(String query, String thing){
        ArrayList<String> ret = new ArrayList();

        try{
            Connection connection = GetConnection();
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery(query);
            int i = 0;
            while(result.next()){
                ret.add(i, result.getString(thing));
                i++;
            }
        
            return ret;
        }catch(SQLException e){
            System.out.println("SQLException(GetStringListFromQuery): "  + e);
        }
        return null;
    }
    
    
    public Getstuff(){
        this.url = "jdbc:mysql://localhost:3306/company?zeroDateTimeBehavior=CONVERT_TO_NULL&useLegacyDatetimeCode=false&serverTimezone=UTC";
        this.mysql_username = "david";
        this.mysql_password = "password";
    }    
}


