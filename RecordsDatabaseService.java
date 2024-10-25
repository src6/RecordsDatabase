/*
 * RecordsDatabaseService.java
 *
 * The service threads for the records database server.
 * This class implements the database access service, i.e. opens a JDBC connection
 * to the database, makes and retrieves the query, and sends back the result.
 *
 *
 */

import javax.sql.rowset.CachedRowSet;
import javax.sql.rowset.RowSetFactory;
import javax.sql.rowset.RowSetProvider;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.ObjectOutputStream;
import java.net.Socket;
import java.sql.*;
import java.util.StringTokenizer;
    //Direct import of the classes CachedRowSet and CachedRowSetImpl will fail becuase
    //these clasess are not exported by the module. Instead, one needs to impor
    //javax.sql.rowset.* as above.



public class RecordsDatabaseService extends Thread{

    private Socket serviceSocket = null;
    private String[] requestStr  = new String[2]; //One slot for artist's name and one for recordshop's name.
    private ResultSet outcome   = null;

	//JDBC connection
    private String USERNAME = Credentials.USERNAME;
    private String PASSWORD = Credentials.PASSWORD;
    private String URL      = Credentials.URL;



    //Class constructor
    public RecordsDatabaseService(Socket aSocket){
        this.serviceSocket = aSocket;
        this.start();
		
    }


    //Retrieve the request from the socket
    public String[] retrieveRequest()
    {
        this.requestStr[0] = ""; //For artist
        this.requestStr[1] = ""; //For recordshop
		
		String tmp = "";
        try {
            InputStream socketStream = this.serviceSocket.getInputStream();
            InputStreamReader socketReader = new InputStreamReader(socketStream);
            StringBuffer stringBuffer = new StringBuffer();
            char x;
            while (true)
            {
                System.out.println("Service thread: reading characters ");
                x = (char) socketReader.read();
                System.out.println("Service thread: " + x);
                if (x == '#') {
                    break;
                }
                stringBuffer.append(x);
            }

            tmp = stringBuffer.toString();

            StringTokenizer st1 = new StringTokenizer(tmp, ";");
            this.requestStr[0] = st1.nextToken();
            this.requestStr[1] = st1.nextToken();
			
         }catch(IOException e){
            System.out.println("Service thread " + this.getId() + ": " + e);
        }
        return this.requestStr;
    }


    //Parse the request command and execute the query
    public boolean attendRequest()
    {
        boolean flagRequestAttended = true;
		
		this.outcome = null;

        String sql = "SELECT record.title, record.label, record.genre, record.rrp, count(recordcopy.recordid) AS copyID FROM (recordcopy JOIN record ON recordcopy.recordid = record.recordid JOIN artist ON record.artistid = artist.artistid JOIN recordshop ON recordcopy.recordshopid = recordshop.recordshopID) WHERE artist.lastname = ? AND recordshop.city = ? GROUP BY record.title, record.label, record.genre, record.rrp HAVING COUNT(recordcopy.recordid) > 0;" ;



        try {
			//Connect to the database
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			
			//Make the query
			PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, requestStr[0]);
            statement.setString(2, requestStr[1]);
            ResultSet rs = statement.executeQuery();
			
			//Process query
            RowSetFactory aFactory = RowSetProvider.newFactory();
            CachedRowSet crs = aFactory.createCachedRowSet();
            crs.populate(rs);
            this.outcome = crs;
            this.outcome.beforeFirst();

			//Clean up
            rs.close();
            connection.close();
            statement.close();
			
		} catch (Exception e)
		{ System.out.println(e); }

        return flagRequestAttended;
    }



    //Wrap and return service outcome
    public void returnServiceOutcome(){
        try {
			//Return outcome
            ObjectOutputStream outcomeStreamWriter = new ObjectOutputStream(this.serviceSocket.getOutputStream());
            outcomeStreamWriter.writeObject(this.outcome);
            outcomeStreamWriter.flush();

            while(outcome.next()) {
                String title = outcome.getString("title");
                String label = outcome.getString("label");
                String genre = outcome.getString("genre");
                String rrp = outcome.getString("rrp");
                String copyID = outcome.getString("copyID");
                System.out.println(title + " | " + label +  " | " + genre +  " | " + rrp +  " | " + copyID);
            }
			
            System.out.println("Service thread " + this.getId() + ": Service outcome returned; " + this.outcome);
            
			//Terminating connection of the service socket
            this.serviceSocket.close();
			
			
        }catch (IOException e){
            System.out.println("Service thread " + this.getId() + ": " + e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    //The service thread run() method
    public void run()
    {
		try {
			System.out.println("\n============================================\n");
            //Retrieve the service request from the socket
            this.retrieveRequest();
            System.out.println("Service thread " + this.getId() + ": Request retrieved: "
						+ "artist->" + this.requestStr[0] + "; recordshop->" + this.requestStr[1]);

            //Attend the request
            boolean tmp = this.attendRequest();

            //Send back the outcome of the request
            if (!tmp)
                System.out.println("Service thread " + this.getId() + ": Unable to provide service.");
            this.returnServiceOutcome();

        }catch (Exception e){
            System.out.println("Service thread " + this.getId() + ": " + e);
        }
        //Terminate service thread (by exiting run() method)
        System.out.println("Service thread " + this.getId() + ": Finished service.");
    }

}
