package rest.code;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * Servlet implementation class mapEntity
 */
public class mapEntity extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public mapEntity() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/*StringBuilder sb = new StringBuilder();
		String strRequest = "";

		// fetch post params
		while ((strRequest = request.getReader().readLine()) != null) {
			System.out.println("RCVD strRequest=" + strRequest);
			sb.append(strRequest);
		}
		// convert STRING to JSON
		JSONObject jsonFormatterObject;
		try {
			jsonFormatterObject = new JSONObject(sb.toString());
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			jsonFormatterObject = new JSONObject();
			e.printStackTrace();
		}
		// printing the VALUES & sending mail
		try {
			System.out
					.println(" MESSAGE " + jsonFormatterObject.get("message"));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		*/
		
		String JDBC_DRIVER = "com.mysql.jdbc.Driver";
		String DB_URL ="jdbc:mysql://localhost/dev_teacher";
		
		String User = "root";
		String Password = "root";
		
		JSONArray jArr = new JSONArray();
		
		
		
		try {
			Class.forName(JDBC_DRIVER);
			
			Connection conn = DriverManager.getConnection(DB_URL,User,Password);
			
			Statement stmnt = conn.createStatement();
			
			String sql="Select * from teacher";
			
			ResultSet rs = stmnt.executeQuery(sql);
			
			
			while(rs.next())
			{
				JSONObject jObj = new JSONObject();
				jObj.put("teacher_id", rs.getInt(1));
				jObj.put("teacher_fname", rs.getString(2));
				jObj.put("teacher_lname", rs.getString(3));
				jObj.put("teacher_isactive", rs.getInt(4));
				
				jArr.put(jObj);
			}
			
			
			 rs.close();
	         stmnt.close();
	         conn.close();
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		//map entity
		
		
		
		PrintWriter out = response.getWriter();
		out.write(jArr.toString());
		out.close();
		
	
	}

}
