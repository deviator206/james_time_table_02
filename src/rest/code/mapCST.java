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
 * Servlet implementation class mapCST
 */
public class mapCST extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public mapCST() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		JSONArray onlyClassInfo =  new JSONArray();
		JSONArray onlyClassSubjectView =  new JSONArray();
		
		JSONObject returnableObject = new JSONObject();
		
		try {
			
			Connection conn = DBProperties.getConnection(); //DriverManager.getConnection(DB_URL,User,Password);
			
			Statement stmnt = conn.createStatement();
			System.out.println(" SELECTING FROM SUBJECT test!! ");
			
			//includes teachers.... But it is not requried since we would be using global pool
			//String sql="SELECT a.classid,c.name,a.subjectid,a.name,a.count,a.successive, b.teacherid , d.firstname FROM SUBJECT a   INNER JOIN class c ON  (a.classid = c.classid )LEFT JOIN map_teach_sub b  INNER JOIN teacher d ON b.teacherid = d.teacherid ON (a.subjectid = b.subjectid) AND a.classid = b.classid ";
			
			String sql="SELECT a.classid,c.name,a.subjectid,a.name,a.count,a.successive FROM subject a   INNER JOIN class c ON  (a.classid = c.classid ) " ;
			ResultSet rs = stmnt.executeQuery(sql);
			
			
			while(rs.next())
			{
				JSONObject jObj = new JSONObject();
				int  i=-1;
				Boolean bcheck= false;
				JSONObject temp; 
				for(i=0;i<onlyClassInfo.length();i++)
				{
					temp = onlyClassInfo.getJSONObject(i);
					
					if(rs.getInt(1) == temp.getInt("class_id"))
					{
						bcheck = true;
						break;
					}
				}
				
				
				if(bcheck == false)
				{
					
					//fresh entry
					jObj.put("class_id", rs.getInt(1));
					jObj.put("class_label", rs.getString(2));
					
					JSONArray arrSubject = new JSONArray();
					JSONObject singleSubject = new JSONObject();
					singleSubject.put("subject_id", rs.getInt(3));
					singleSubject.put("subject_label", rs.getString(4));
					singleSubject.put("count", rs.getInt(5));
					singleSubject.put("continous", rs.getInt(6));
					arrSubject.put(singleSubject);
					jObj.put("subjects",arrSubject );
					
					/*JSONArray arrTeacher = new JSONArray();
					JSONObject singleTeacher = new JSONObject();
					
					
					if(rs.getInt(7) != 0)
					{
						singleTeacher.put("teacher_id", rs.getInt(7));
						singleTeacher.put("teacher_name", rs.getString(8));
						arrTeacher.put(singleTeacher );
					}
					jObj.put("teachers",arrTeacher );*/
					
					onlyClassInfo.put(jObj);
					
					
				
				}
				else
				{
					//updating the entry
					jObj = onlyClassInfo.getJSONObject(i);
					
					JSONArray arrSubject = jObj.getJSONArray("subjects");
					JSONObject singleSubject = new JSONObject();
					singleSubject.put("subject_id", rs.getInt(3));
					singleSubject.put("subject_label", rs.getString(4));
					singleSubject.put("count", rs.getInt(5));
					singleSubject.put("continous", rs.getInt(6));
					arrSubject.put(singleSubject);
					jObj.put("subjects",arrSubject );
					
					/*JSONArray arrTeacher =  jObj.getJSONArray("teachers");
					JSONObject singleTeacher = new JSONObject();
					if(rs.getInt(7) != 0)
					{
						singleTeacher.put("teacher_id", rs.getInt(7));
						singleTeacher.put("teacher_name", rs.getString(8));
						arrTeacher.put(singleTeacher );
					}
					jObj.put("teachers",arrTeacher );
					*/
					onlyClassInfo.put(i, jObj);
					
					
				}
				
				//jArr.put(jObj);
			}
			
			sql = "SELECT a.mapid,a.classid,b.name,a.subjectid,c.name,c.count,c.successive,a.teacherid,d.firstname FROM map_teach_sub a INNER JOIN class b ON a.classid = b.classid     JOIN subject c ON c.subjectid = a.subjectid JOIN teacher d ON d.teacherid = a.teacherid";
			rs = stmnt.executeQuery(sql);
			while(rs.next())
			{
				JSONObject tempJObj = new JSONObject();
				tempJObj.put("map_id",rs.getInt(1));
				
				tempJObj.put("class_id",rs.getInt(2));
				tempJObj.put("class_label",rs.getString(3));
				

				tempJObj.put("subject_id",rs.getInt(4));
				tempJObj.put("subject_label",rs.getString(5));
				
				tempJObj.put("count",rs.getInt(6));
				tempJObj.put("continous",rs.getInt(7));
				
				
				tempJObj.put("teacher_id",rs.getInt(8));
				tempJObj.put("teacher_name",rs.getString(9));
				
				onlyClassSubjectView.put(tempJObj);
			}
			
			
			
			try {
				returnableObject.put("cs_view", onlyClassSubjectView);
				returnableObject.put("onlyClass", onlyClassInfo);
			} catch (JSONException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			
			
			
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
		
		
		
		//map entity
		
		
		
		PrintWriter out = response.getWriter();
		out.write(returnableObject.toString());
		out.close();
	}

	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		StringBuilder sb = new StringBuilder();
		String strRequest = "";

		// fetch post params
		while ((strRequest = request.getReader().readLine()) != null) {
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
		
		try {
			
			Connection conn = DBProperties.getConnection();
			
			
			String checkIfExist = "SELECT COUNT(*) FROM map_teach_sub WHERE classid =? AND subjectid = ? AND teacherid =?";
			PreparedStatement checkingStmnt = conn.prepareStatement(checkIfExist, Statement.RETURN_GENERATED_KEYS);
			checkingStmnt.setInt(1, jsonFormatterObject.getInt("class_id"));
			checkingStmnt.setInt(2,jsonFormatterObject.getInt("subject_id"));
			checkingStmnt.setInt(3,jsonFormatterObject.getInt("teacher_id"));
			ResultSet checkingRs = checkingStmnt.executeQuery();
			int alreadyExist = 0;
			
			while(checkingRs.next()) {
				alreadyExist = checkingRs.getInt(1);
			}
			
			checkingStmnt.close();
			
			if(alreadyExist <= 0)
			{
			
				String query = "INSERT INTO map_teach_sub (classid,subjectid,teacherid) VALUES (?,?,?)";
				PreparedStatement stmnt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
				
				stmnt.setInt(1, jsonFormatterObject.getInt("class_id"));
				stmnt.setInt(2,jsonFormatterObject.getInt("subject_id"));
				stmnt.setInt(3,jsonFormatterObject.getInt("teacher_id"));
				stmnt.executeUpdate();
				
				ResultSet keyResultSet = stmnt.getGeneratedKeys();
		        int newCustomerId = 0;
		        if (keyResultSet.next()) {
		            newCustomerId = (int) keyResultSet.getInt(1);
		            jsonFormatterObject.put("map_id", String.valueOf(newCustomerId));
		        }
		 		stmnt.close();
				
			}
			else
			{
			      jsonFormatterObject.put("alreadyExist","Mapping Already Exist");
			}
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
