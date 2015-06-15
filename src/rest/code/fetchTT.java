package rest.code;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
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
 * Servlet implementation class fetchTT
 */
public class fetchTT extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public fetchTT() {
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
		JSONArray collectiveTT = new JSONArray();
		
		try {
			Connection conn = DBProperties.getConnection();

			Statement stmnt = conn.createStatement();

			String sql;

			ResultSet rs;

			// FETCH CLASS
			sql = "SELECT * FROM time_table";

			rs = stmnt.executeQuery(sql);

			while (rs.next()) {
				JSONObject jObj = new JSONObject();
				jObj.put("timetable_id", rs.getInt(1));
				
				jObj.put("slot_id", rs.getInt(2));
				jObj.put("class_id", rs.getInt(3));
				jObj.put("teacher_id", rs.getInt(4));
				jObj.put("teacher_name", rs.getString(5));
				jObj.put("subject_id", rs.getInt(6));
				jObj.put("subject_label", rs.getString(7));
				jObj.put("day_id", rs.getInt(8));
				jObj.put("day_label", rs.getString(9));
				
			/*	"subject_label":"susane"
				"class_label":"I",
				"teacher_name":"aila",
				"slot_label":"8-9"
				*/
				
				collectiveTT.put(jObj);
			}
			
			returnableJSON.putOnce("timetable",collectiveTT);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
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
