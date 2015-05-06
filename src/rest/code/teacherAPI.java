package rest.code;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
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
 * Servlet implementation class teacherAPI
 */
public class teacherAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public teacherAPI() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		

		JSONArray jArr = new JSONArray();
		JSONObject returnableObject = new JSONObject();

		try {
			
			Connection conn = DBProperties.getConnection();

			Statement stmnt = conn.createStatement();
			String sql = "Select * from teacher";
			ResultSet rs = stmnt.executeQuery(sql);
			while (rs.next()) {
				JSONObject jObj = new JSONObject();
				jObj.put("id", rs.getInt(1));
				jObj.put("first_name", rs.getString(2));
				jObj.put("last_name", rs.getString(3));
				jArr.put(jObj);
			}

			returnableObject.put("teachers", jArr);
			rs.close();
			stmnt.close();
			DBProperties.closeConnection();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		PrintWriter out = response.getWriter();
		out.write(returnableObject.toString());
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		
		StringBuilder sb = new StringBuilder();
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
					.println(" MESSAGE " + jsonFormatterObject.get("first_name"));
			
			System.out
			.println(" MESSAGE " + jsonFormatterObject.get("last_name"));
	
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		try {
			
			Connection conn = DBProperties.getConnection();

			String query = "INSERT INTO teacher (firstname,lastname) VALUES (?,?)";
			PreparedStatement stmnt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			
			stmnt.setString(1,(String) jsonFormatterObject.get("first_name"));
			stmnt.setString(2,(String) jsonFormatterObject.get("last_name"));

			stmnt.executeUpdate();
			
			ResultSet keyResultSet = stmnt.getGeneratedKeys();
	        int newCustomerId = 0;
	        if (keyResultSet.next()) {
	            newCustomerId = (int) keyResultSet.getInt(1);
	            jsonFormatterObject.put("id", String.valueOf(newCustomerId));
	        }
	 
			
			stmnt.close();
			DBProperties.closeConnection();

		}  catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		PrintWriter out = response.getWriter();
		out.write(jsonFormatterObject.toString());
		out.close();
	}

}
