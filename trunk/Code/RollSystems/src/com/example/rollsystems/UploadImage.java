package com.example.rollsystems;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.example.rollsystems.FileEncoding;
import com.example.rollsystems.FileJson;
import com.example.rollsystems.CameraActivity;

import com.example.rollsystems.R;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Environment;
import android.os.StrictMode;
import android.util.Log;
import android.view.View;
import android.widget.Button;

public class UploadImage extends Activity {
	Button btnSend;
	String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
	//File path = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES);
            
    //File file = new File(path, "DemoPicture.jpg");
	File mediaStorageDir = new File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES),"MyCameraApp");
	
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.failed_layout);
		if (android.os.Build.VERSION.SDK_INT > 9) {
		    StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
		    StrictMode.setThreadPolicy(policy);
		}
		btnSend = (Button) findViewById(R.id.btSend);
	//String url = "http://localhost:4980/RestService.svc/InsertFeedback";
			//String url = "http://localhost:4980/RestService.svc/Upload";
			String url = "http://10.0.2.2:4980/RestService.svc/Upload";
			URL obj;
			
			try {
				obj = new URL(url);
				HttpURLConnection con = (HttpURLConnection) obj.openConnection();
				 
				//add reuqest header
				con.setRequestMethod("POST");
				con.setRequestProperty("Content-Type", "application/json");
				
				
				//FileJson json = FileEncoding.createFileJson(mediaStorageDir.getPath() + File.separator + "IMG_" + timeStamp + ".jpg");
                
				
				FileJson json = FileEncoding.createFileJson(mediaStorageDir.getPath() + File.separator + "IMG_gacon.jpg");
				
				Gson gson = new GsonBuilder().create();
				String sendJson = gson.toJson(json);
				
				//System.out.println(sendJson);
				
				// Send post request
				con.setDoOutput(true);
				DataOutputStream wr = new DataOutputStream(con.getOutputStream());
				wr.writeBytes(sendJson);
				wr.flush();
				wr.close();
				
				System.out.println(con.getResponseCode());
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//Activity Login button
			btnSend.setOnClickListener(new View.OnClickListener() {
				//@Override
				public void onClick(View v) {
					//UploadImage();
				}
			});
			
	}
	
}
