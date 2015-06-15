package rest.code;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * Servlet implementation class SubmitGeneratedTimeTable
 */
public class SubmitGeneratedTimeTable extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SubmitGeneratedTimeTable() {
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
	}
	
	
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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
			System.out.println(" MESSAGE "
					+ jsonFormatterObject.get("schedule"));

		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {

			Connection conn = DBProperties.getConnection();
			String truncateTable = "TRUNCATE TABLE time_table";
			PreparedStatement truncateStmnt = conn.prepareStatement(truncateTable,
					Statement.RETURN_GENERATED_KEYS);
			
			truncateStmnt.execute();
			
			
			String query = "INSERT INTO time_table (slotid,classid,teacherid,teachername,subjectid,subjectname,dayid,daylabel) VALUES (?,?,?,?,?,?,?,?)";
			PreparedStatement stmnt = conn.prepareStatement(query,
					Statement.RETURN_GENERATED_KEYS);

			JSONArray jsRequest = jsonFormatterObject.getJSONArray("schedule");
			System.out.println("fetching array");
			for(int i =0;i<jsRequest.length();i++)
			{
				System.out.println("________________________________");
				if(jsRequest.get(i) != null)
				{
					System.out.println("&&&&&&&&&&&&&&&&&&&&&");
					System.out.println(jsRequest.get(i));
					JSONObject jsTemp = (JSONObject) jsRequest.get(i);
					
						System.out.println(jsTemp.toString());
						stmnt.setInt(1,converJSONToInt(jsTemp.get("slot_id")));
						stmnt.setInt(2, converJSONToInt(jsTemp.get("class_id")));
						stmnt.setInt(3, converJSONToInt(jsTemp.get("teacher_id")));
						stmnt.setString(4, (String)jsTemp.get("teacher_name"));
						stmnt.setInt(5, converJSONToInt(jsTemp.get("subject_id")));
						stmnt.setString(6, (String)jsTemp.get("subject_label"));
						stmnt.setInt(7, converJSONToInt(jsTemp.get("day_id")));
						stmnt.setString(8, (String)jsTemp.get("day_label"));
						stmnt.addBatch(); 
				}
			}
			int[] resp = stmnt.executeBatch();
			System.out.println("EXECUTION DONE!!");
			System.out.println(resp.length);
			stmnt.close();
			DBProperties.closeConnection();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		JSONObject jsReturn = new JSONObject();
		try {
			jsReturn.put("success",true);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		PrintWriter out = response.getWriter();
		out.write(jsReturn.toString());
		out.close();

	}

	private int converJSONToInt(Object object) {
		int result = 0 ;
		System.out.println("***************");
		System.out.println(object);
		if(object instanceof Integer)
		{
			result = (Integer) object;
		}
		else
		{
			System.out.println(object);
			result =Integer.parseInt((String)object);
		}
		return result; 
	}

}
