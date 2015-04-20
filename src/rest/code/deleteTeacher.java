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

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Servlet implementation class deleteTeacher
 */
public class deleteTeacher extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public deleteTeacher() {
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
					.println(" ID to be deleted " + jsonFormatterObject.get("id"));
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		
		
		
		
		JSONObject returnableObject = new JSONObject();
		try {
		
			Connection conn = DBProperties.getConnection();

			Statement stmnt = conn.createStatement();
			String sql = "delete from teacher where teacherid=? ";
			PreparedStatement preparedStmt = conn.prepareStatement(sql);
		    preparedStmt.setInt(1, jsonFormatterObject.getInt("id"));
		    preparedStmt.execute();
			
			returnableObject.put("result", true);
			
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

}
