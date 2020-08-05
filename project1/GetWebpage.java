import java.net.*;
import java.io.*;
public class GetWebpage {
  public static void main(String args[]) throws Exception {

      // args[0] has the URL passed as the command parameter.
      // You need to retrieve the webpage corresponding to the URL and print it out on console
      // Here, we simply printout the URL
      
      URL url_now = new URL(args[0]);
      BufferedReader reader = new BufferedReader(new InputStreamReader(url_now.openStream()));
      String line;
      while ((line = reader.readLine()) != null) {
      	System.out.println(line);
      }

      reader.close();
    }
}
