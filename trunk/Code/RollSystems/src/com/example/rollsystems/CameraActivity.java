package com.example.rollsystems;

import android.hardware.Camera.PictureCallback;

import com.example.camera.*;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.example.camera.CameraPreview;
import com.example.camera.FileEncoding;
import com.example.camera.FileJson;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import android.hardware.Camera;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.os.StrictMode;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.ProgressBar;

public class CameraActivity extends Activity {
    private Camera mCamera;
    CameraPreview mCameraPreview;
    ProgressBar pB1;
    File mediaStorageDir = new File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES),"RollSystemApp");
    /** Called when the activity is first created. */
    @SuppressWarnings("deprecation")
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_capture);
        //Set IP emulator
        if (android.os.Build.VERSION.SDK_INT > 9) {
		    StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
		    StrictMode.setThreadPolicy(policy);
		}
        
        mCamera = getCameraInstance();
        FrameLayout preview = (FrameLayout) findViewById(R.id.camera_preview);
		mCameraPreview = new CameraPreview(this, mCamera);
		preview.addView(mCameraPreview);

		//create alert box
				final AlertDialog alertDialog = new AlertDialog.Builder(this).create();
				alertDialog.setTitle("SUCCESS");
				alertDialog.setMessage("Image send successful!");
				alertDialog.setIcon(R.drawable.tick1);
				alertDialog.setButton("OK", new DialogInterface.OnClickListener() {
				   public void onClick(DialogInterface dialog, int which) {
					   
					   Intent i = new Intent(getApplicationContext(), CourseActivity.class);
					   startActivity(i);
					   Intent myIntent = new Intent();
		            	CameraActivity.this.UploadImage(myIntent);
				   }
				});
		
				//Create action of Capture Button
        Button captureButton = (Button) findViewById(R.id.button_capture);
        captureButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
            	 //CameraActivity appState = ((CameraActivity)this.getApplication());
            	
                mCamera.takePicture(null, null, mPicture);
                alertDialog.show();
                
                //UploadImage(getParentActivityIntent());
            }
        });
    }

    //Upload Image to server
    protected void UploadImage(Intent myIntent) {
    	String url = "http://10.0.2.2:4980/RestService.svc/Upload";
		URL obj;
		
		try {
			obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();
			 
			//add reuqest header
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-Type", "application/json");
			
			
			//FileJson json = FileEncoding.createFileJson(mediaStorageDir.getPath() + File.separator + "IMG_" + timeStamp + ".jpg");
            
			
			FileJson json = FileEncoding.createFileJson(mediaStorageDir.getPath() + File.separator + "IMG_check.jpg");
			
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
		
	}

    //try catch camera 
    private Camera getCameraInstance() {
        Camera camera = null;
        try {
            camera = Camera.open();
        } catch (Exception e) {
            // cannot get camera or does not exist
        }
        return camera;
    }
    
    //Create image with Frame layout
    PictureCallback mPicture = new PictureCallback() {
    	@Override
        public void onPictureTaken(byte[] data, Camera camera) {
            File pictureFile = getOutputMediaFile();
            if (pictureFile == null) {
                return;
            }
            try {
                FileOutputStream fos = new FileOutputStream(pictureFile);
                fos.write(data);
                fos.close();
                File mediaStorageDir = new File(Environment.getExternalStoragePublicDirectory(
                	    Environment.DIRECTORY_PICTURES), "RollSystemApp");
                	sendBroadcast(new Intent(Intent.ACTION_MEDIA_MOUNTED, 
                	    Uri.parse("file://"+ mediaStorageDir)));
            } catch (FileNotFoundException e) {

            } catch (IOException e) {
            }
        }
    };

    //Cerate folder & image format
    private static File getOutputMediaFile() {
        File mediaStorageDir = new File(
                Environment
                        .getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES),
                "RollSystemApp");
        if (!mediaStorageDir.exists()) {
            if (!mediaStorageDir.mkdirs()) {
                Log.d("RollSystemApp", "failed to create directory");
                return null;
            }
        }
        // Create a media file name
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss")
                .format(new Date());
        File mediaFile;
        //mediaFile = new File(mediaStorageDir.getPath() + File.separator + "IMG_" + timeStamp + ".jpg");
        mediaFile = new File(mediaStorageDir.getPath() + File.separator + "IMG_" + "check" + ".jpg");
        
        return mediaFile;
    }
}
