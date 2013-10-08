package com.example.Utils;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.NameValuePair;
import org.apache.http.HttpEntity;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.message.BasicNameValuePair;
import org.dto.Course;
import org.dto.LoginResult;
import org.json.JSONException;
import org.json.JSONObject;

import android.R.array;

import com.example.listview.Student;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class AllBO {

	public LoginResult checkLogin(String inUsername, String inPassword) {
		HttpEntity postEntity;

		// postEntity = new UrlEncodedFormEntity(postParams);

		postEntity = MultipartEntityBuilder.create()
				.addTextBody("Username", inUsername)
				.addTextBody("Password", inPassword).build();
		String result = new ConnectUtil().GetResponse("Login", postEntity);
		Gson gson = new Gson();
		LoginResult lResult = gson.fromJson(result, LoginResult.class);
		if (lResult.getMessage().equals("Success")) {
			return lResult;
		} else {

			return null;
		}

	}
	
	public String UploadFile(String filePath)
	{
		HttpEntity postEntity;
		
		FileBody bf = new FileBody(new File(filePath));
		
		postEntity = MultipartEntityBuilder.create().addPart("ImageFiles", bf) .build();
		String result = new ConnectUtil().GetResponse("UploadFile", postEntity);
		
		return result;
	}
	
	public ArrayList<Course> getRollCallList(String instructorID) {
		
		HttpEntity postEntity;

		// postEntity = new UrlEncodedFormEntity(postParams);

		postEntity = MultipartEntityBuilder.create()
				.addTextBody("instructorID", instructorID).build();
		String result = new ConnectUtil().GetResponse("GetCurrentRollCalls", postEntity);
		Gson gson = new Gson();
		
		TypeToken<ArrayList<Course>> type = new TypeToken<ArrayList<Course>>(){};
		 ArrayList<Course> lResult = gson.fromJson(result, type.getType());
		return lResult;
	}
	public ArrayList<Student> getStudentList(String courseID) {
		
		HttpEntity postEntity;

		// postEntity = new UrlEncodedFormEntity(postParams);

		postEntity = MultipartEntityBuilder.create()
				.addTextBody("courseID", courseID).build();
		String result = new ConnectUtil().GetResponse("GetCurrentStudents", postEntity);
		Gson gson = new Gson();
		
		TypeToken<ArrayList<Student>> type = new TypeToken<ArrayList<Student>>(){};
		 ArrayList<Student> lResult = gson.fromJson(result, type.getType());
		return lResult;
	}

	public List<Student> checkAttendanceAuto(int rollCallID, String filePath)
	{
		HttpEntity postEntity;

		// postEntity = new UrlEncodedFormEntity(postParams);

		FileBody fb = new FileBody(new File(filePath));
		
		postEntity = MultipartEntityBuilder.create()
				.addTextBody("RollCallID", rollCallID + "")
				.addPart("ImageFiles", fb)
				.build();
		String result = new ConnectUtil().GetResponse("CheckAttendanceAuto", postEntity);
		Gson gson = new Gson();
		
		TypeToken<List<Student>> type = new TypeToken<List<Student>>(){};
		List<Student> lResult = gson.fromJson(result, type.getType());
		return lResult;
	}


}
