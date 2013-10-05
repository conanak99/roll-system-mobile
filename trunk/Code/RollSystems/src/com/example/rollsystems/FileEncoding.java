package com.example.rollsystems;

import java.io.File;
import android.util.Base64;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
//import org.apache.commons.codec.binary.Base64;

public class FileEncoding {

	/**
	 * @param args
	 */
	public static String encodeFileToBase64(String fileName)
	{	
		/*
		try {
			File file = new File(fileName);
			byte[] byteArray = FileUtils.readFileToByteArray(file);
			return Base64.encodeBase64String(byteArray);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return ""; */
		try {
			File file = new File(fileName);
			byte[] byteArray = FileUtils.readFileToByteArray(file);
			return Base64.encodeToString(byteArray, Base64.DEFAULT);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return ""; 
	}

	
	public static FileJson createFileJson(String fileName)
	{
		File file = new File(fileName);
		return new FileJson(file.getName(), file.length()/1024, encodeFileToBase64(fileName));
	}
}
