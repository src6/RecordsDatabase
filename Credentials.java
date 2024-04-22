public class Credentials {
    //JDBC connection
    public static final String USERNAME = "";
    public static final String PASSWORD = "";
    public static final String URL = "jdbc:postgresql://localhost:5432/FSAD2024_Records";
    //Client-server connection
    public static final String HOST = "127.0.0.1"; //localhost
    public static final int PORT = 9994; //This is NOT the port in postgres, but the port at which the RecordsDatabaseServer is listening
}
