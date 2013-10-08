package com.example.rollsystems;

import java.io.DataOutputStream;
import java.io.File;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import com.example.camera.FileEncoding;
import com.example.camera.FileJson;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class FileUploader {

	/**
	 * @param args
	 */
	private static String url = "http://192.168.1.62:12345/RestService.svc/Upload";
	
	public static void UploadFile(String filePath)
	{
		URL obj;
		
		try {
			obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();
			 
			//add reuqest header
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/json");
			
			
			//FileJson json = FileEncoding.createFileJson(mediaStorageDir.getPath() + File.separator + "IMG_" + timeStamp + ".jpg");
            
			
			FileJson json = FileEncoding.createFileJson(filePath);
			
			Gson gson = new GsonBuilder().create();
			String sendJson = gson.toJson(json);
			
			//System.out.println(sendJson);
			
			// Send post request
			con.setDoOutput(true);
			DataOutputStream wr = new DataOutputStream(con.getOutputStream());
			wr.writeBytes(sendJson);
			wr.flush();
			wr.close();
			String abc = con.getResponseCode() + "";
			System.out.println();
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
