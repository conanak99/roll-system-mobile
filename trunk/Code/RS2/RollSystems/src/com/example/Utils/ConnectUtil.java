package com.example.Utils;

import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;

import org.apache.http.util.EntityUtils;

public class ConnectUtil {
	private  HttpClient httpClient;
	
	//private  String url = "http://192.168.218.1:12345/Service";
	private  String url = "http://10.0.2.2:5935/Service";
	private  HttpResponse httpResponse;
	
	
	
	public  String GetResponse(String serviceName)
	{
		httpClient = new DefaultHttpClient();
		HttpPost post = new HttpPost(url + "/" + serviceName);
		
		try {
			httpResponse = httpClient.execute(post);
			HttpEntity responseEntity = httpResponse.getEntity();
			return EntityUtils.toString(responseEntity);
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public  String GetResponse(String serviceName, HttpEntity postEntity)
	{
		httpClient = new DefaultHttpClient();
		HttpPost post = new HttpPost(url + "/" + serviceName);
		
		try {
			post.setEntity(postEntity);
			httpResponse = httpClient.execute(post);
			HttpEntity responseEntity = httpResponse.getEntity();
			return EntityUtils.toString(responseEntity);
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
}
