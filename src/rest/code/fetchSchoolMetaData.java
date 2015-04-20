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
 * Servlet implementation class fetchSchoolMetaData
 */
public class fetchSchoolMetaData extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public fetchSchoolMetaData() {
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

		
		JSONObject returnableJSON = new JSONObject();	
		JSONArray onlyClass = new JSONArray();
		JSONArray onlyDays =new JSONArray();
		JSONArray onlySlots =new JSONArray();
		JSONObject ttMetaData =new JSONObject();

		try {
		
			Connection conn = DBProperties.getConnection();

			Statement stmnt = conn.createStatement();

			String sql; 

			ResultSet rs;
			
			//FETCH CLASS
			sql = "Select * from class where isactive = 1";
			rs = stmnt.executeQuery(sql);
			while (rs.next()) {
				JSONObject jObj = new JSONObject();
				jObj.put("class_id", rs.getInt(1));
				jObj.put("class_label", rs.getString(2));
				onlyClass.put(jObj);
			}
			returnableJSON.put("onlyClass",onlyClass);
			
			
			//Days
			sql = "Select * from days where isactive=1";
			rs = stmnt.executeQuery(sql);
			while(rs.next())
			{
				JSONObject tempObj = new JSONObject();
				tempObj.put("day_id",rs.getInt(1));
				tempObj.put("day_label",rs.getString(2));
				onlyDays.put(tempObj);
			}
			ttMetaData.put("days",onlyDays);
			
			//SLOTS
			sql = "Select * from time_slot where active=1";
			rs = stmnt.executeQuery(sql);
			while(rs.next())
			{
				JSONObject tempObj1 = new JSONObject();
				tempObj1.put("slot_id",rs.getInt(1));
				tempObj1.put("slot_label",rs.getString(2));
				onlySlots.put(tempObj1);
			}
			
			ttMetaData.put("days",onlyDays);
			ttMetaData.put("slots",onlySlots);
			
			returnableJSON.put("onlyMetaData",ttMetaData);
			
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

		// map entity

		PrintWriter out = response.getWriter();
		out.write(returnableJSON.toString());
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
