package rest.code;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
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
 * Servlet implementation class GetTimeTableOfClass
 */
public class GetTimeTableOfClass extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetTimeTableOfClass() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/*
		SELECT tbl.slotid, tbl.classid, tbl.teacherid, tbl.teachername ,tbl.subjectid,tbl.subjectname,tbl.dayid,tbl.daylabel,tbl1.label  FROM   time_slot  tbl1 LEFT JOIN  time_table  tbl ON tbl.slotid = tbl1.slotid    AND tbl.classid =2   ORDER BY label ASC 
       "readOnlyTimeTable" :[["8-9","Hindi","History","Computer","RECESS1","RECESS2"],]
		 * 
		 * */
				
		JSONObject slotWise = new JSONObject();
		try {
			
			Connection conn = DBProperties.getConnection();

			

			String sql; 

			ResultSet rs;
				
			//FETCH CLASS
			sql = "SELECT tbl.slotid, tbl.classid, tbl.teacherid, tbl.teachername ,tbl.subjectid,tbl.subjectname,tbl.dayid,tbl.daylabel,tbl1.label  FROM   time_slot  tbl1 LEFT JOIN  time_table  tbl ON tbl.slotid = tbl1.slotid    AND tbl.classid = ?   ORDER BY label ASC";
			
			PreparedStatement preparedStmt = conn.prepareStatement(sql);
			String inputParam = request.getParameter("id");
			preparedStmt.setInt(1,Integer.parseInt(inputParam));
		    rs =preparedStmt.executeQuery();
			    
			//Statement stmnt = conn.createStatement();
			//rs = stmnt.executeQuery(sql);
			/*while (rs.next()) {
				JSONObject jObj = new JSONObject();
				//tbl.slotid
				jObj.put("slot_id", rs.getInt(1));
				//tbl.classid
				jObj.put("class_id", rs.getInt(2));
				//tbl.teacherid
				jObj.put("teacher_id", rs.getInt(3));
				// tbl.teachername 
				jObj.put("teacher_label", rs.getString(4));
				//tbl.subjectid
				jObj.put("subject_id", rs.getInt(5));
				//tbl.subjectname
				jObj.put("subject_name", rs.getString(6));
				//tbl.dayid
				jObj.put("day_id", rs.getInt(7));
				//tbl.daylabel
				jObj.put("day_label", rs.getString(8));
				//tbl1.label
				jObj.put("slot_label", rs.getString(9));
				returnableJSON.put(jObj);
			}
			*/
			
			while(rs.next())
			{
				String weekDayName =  rs.getString(8);
				if(weekDayName != null)
				{
					if (slotWise.has(weekDayName)) {
						// has that week day

						JSONArray jResp = (JSONArray) slotWise.get(weekDayName);

						JSONObject jObj = new JSONObject();
						// tbl.slotid
						jObj.put("slot_id", rs.getInt(1));
						// tbl.classid
						jObj.put("class_id", rs.getInt(2));
						// tbl.teacherid
						jObj.put("teacher_id", rs.getInt(3));
						// tbl.teachername
						jObj.put("teacher_label", rs.getString(4));
						// tbl.subjectid
						jObj.put("subject_id", rs.getInt(5));
						// tbl.subjectname
						jObj.put("subject_name", rs.getString(6));
						// tbl.dayid
						jObj.put("day_id", rs.getInt(7));
						// tbl.daylabel
						jObj.put("day_label", rs.getString(8));
						// tbl1.label
						jObj.put("slot_label", rs.getString(9));
						jResp.put(jObj);

						slotWise.put(weekDayName, jResp);

					} else {
						JSONArray jArr = new JSONArray();
						// new weekday
						JSONObject jObj = new JSONObject();
						// tbl.slotid
						jObj.put("slot_id", rs.getInt(1));
						// tbl.classid
						jObj.put("class_id", rs.getInt(2));
						// tbl.teacherid
						jObj.put("teacher_id", rs.getInt(3));
						// tbl.teachername
						jObj.put("teacher_label", rs.getString(4));
						// tbl.subjectid
						jObj.put("subject_id", rs.getInt(5));
						// tbl.subjectname
						jObj.put("subject_name", rs.getString(6));
						// tbl.dayid
						jObj.put("day_id", rs.getInt(7));
						// tbl.daylabel
						jObj.put("day_label", rs.getString(8));
						// tbl1.label
						jObj.put("slot_label", rs.getString(9));
						jArr.put(jObj);

						slotWise.put(rs.getString(8), jArr);
					}

					/*
					 * int key = rs.getInt(1);
					 * System.out.println(rs.getString(6)); if(rs.getString(6)
					 * != null && rs.getString(6).equals("BREAK")) {
					 * 
					 * //break JSONArray jArr = new JSONArray();
					 * jArr.put(rs.getString(9)); jArr.put(""); jArr.put("");
					 * jArr.put("BREAK"); jArr.put(""); jArr.put("");
					 * slotWise.put("BREAK",jSlotArray.length()-1);
					 * jSlotArray.put(jArr);
					 * 
					 * } else {
					 * 
					 * if(slotWise.has(key+"")) { //is OBJECT EXIST int k =
					 * (Integer) slotWise.get(key+""); JSONArray jResp =
					 * (JSONArray) jSlotArray.get(k);
					 * jResp.put(rs.getString(6)); jSlotArray.put(k,jResp); //
					 * slotWise.put(key+"",jResp); } else { JSONArray jArr = new
					 * JSONArray(); jArr.put(rs.getString(9));
					 * jArr.put(rs.getString(6)); int kIndex =
					 * jSlotArray.length()-1; if(kIndex <= 0) kIndex = 0;
					 * slotWise.put(key+"",kIndex); jSlotArray.put(jArr); } }
					 */
				}
			}
			rs.close();
			preparedStmt.close();
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
		JSONObject returnableJSON = new JSONObject();
		try {
			returnableJSON.put("readOnlyTimeTable", slotWise);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		out.write(returnableJSON.toString());
		out.close();
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
