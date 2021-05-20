import java.sql.*;
class connect{
    public static void main (String args[]){
        try{
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306","root","jose");
            System.out.println("Sucess...");
            con.close();
        }
        catch(Exception e){
            System.out.println(e);
        }
    }
}