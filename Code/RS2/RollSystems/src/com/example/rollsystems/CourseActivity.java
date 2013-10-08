package com.example.rollsystems;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.dto.Course;
import org.dto.LoginResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import com.example.Utils.AllBO;
import com.example.listview.*;
//import com.example.androidhive.LazyAdapter;
//import com.example.androidhive.XMLParser;
import com.example.rollsystems.R;
//import com.example.androidhive.*;

import android.animation.AnimatorSet.Builder;
import android.app.Activity;
import android.app.AlertDialog;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Environment;
import android.os.Debug.InstructionCount;
import android.preference.PreferenceManager;
import android.provider.MediaStore;
import android.sax.RootElement;
import android.support.v4.app.NotificationCompat;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;


public class CourseActivity extends Activity {
	
	Button btnCheck;
	private int currentRollCallID;
	private String imagePath;
	private SharedPreferences instructorID;
	
	ArrayList<Course> array;
    ListCourseAdapter arrayAdapter;
    ListView list;
    
    public class CourseTask extends AsyncTask<Void, Void, List<Course>> {

		@Override
		protected List<Course> doInBackground(Void... params) {
			SharedPreferences sharedPref = getApplicationContext().getSharedPreferences("rs", Context.MODE_PRIVATE);
			String instructorID = sharedPref.getString("instructorID", "");
			
			list = (ListView)findViewById(R.id.list);
			ArrayList<Course> rollCalls = new AllBO().getRollCallList(instructorID);
			array = rollCalls;
			
			currentRollCallID = 0;
			for(Course roll: rollCalls)
			{
				if(roll.isCurrent())
				{
					currentRollCallID = Integer.parseInt(roll.getRollID().trim());
				}
			}
			
	        //arrayAdapter = new ListCourseAdapter(this, R.layout.listview, array);
	        list.setAdapter(arrayAdapter);
	        btnCheck = (Button) findViewById(R.id.btCheck);
			//import Edit text & button of page
	        if(currentRollCallID == 0){
	        	btnCheck.setEnabled(false);
	        	
	        }
	     // listening to single list item on click
	        list.setOnItemClickListener(new OnItemClickListener() {
	          public void onItemClick(AdapterView<?> parent, View view,
	              int position, long id) {
	        	  
	        	  // selected item 
	        	  String classAt = ((TextView) view).getText().toString();
	        	  String instructorAt = ((TextView) view).getText().toString();
	        	  String subjectAt = ((TextView) view).getText().toString();
	        	  String timeAt = ((TextView) view).getText().toString();
	        	  String dateAt = ((TextView) view).getText().toString();
	        	  // Launching new Activity on selecting single List Item
	        	  Intent i = new Intent(getApplicationContext(), CheckManual.class);
	        	  // sending data to new activity
	        	  i.putExtra("classAt", classAt);
	        	  i.putExtra("instructorAt", instructorAt);
	        	  i.putExtra("subjectAt", subjectAt);
	        	  i.putExtra("timeAt", timeAt);
	        	  i.putExtra("dateAt", dateAt);
	        	  startActivity(i);
	        	
	          }
	        });
			//btnCheck = (Button) findViewById(R.id.btCheck);
			return null;
		}
    	
    }
    
    private class MyTask extends AsyncTask<Void, Void, List<Student>> {

    	public CourseActivity activity;

        public MyTask(CourseActivity a)
        {
            activity = a;
        }
		String textResult;

		
		
		@Override
		protected void onPreExecute() {
			// TODO Auto-generated method stub
			
			Toast a = Toast.makeText(getApplicationContext(), "Begin to Upload.", Toast.LENGTH_LONG);
			a.show();
			super.onPreExecute();
		}

		@Override
		protected List<Student> doInBackground(Void... params) {
			//FileUploader.UploadFile(imagePath);
			//String result = new AllBO().UploadFile(imagePath);
			if(currentRollCallID == 0)
			{
				//Error	
			}
			return  new AllBO().checkAttendanceAuto(currentRollCallID, imagePath);
		}

		
		
		@Override
		protected void onPostExecute(List<Student> result) {
			
			/*
			Context context = getApplicationContext();
			Toast a = Toast.makeText(context, result, Toast.LENGTH_LONG);
			a.show();
			*/
			List<String> StudentCodeName = new ArrayList<String>();

			String[] array = StudentCodeName.toArray(new String[StudentCodeName.size()]);
			String resultString = result.size() + " student founds\n";
			for(Student s: result)
			{
			 resultString += s.getCodeName() + "\n";
			}
			
			showDialog(this.activity, "Result", resultString);
			
			super.onPostExecute(result);
		}
		
		public void showDialog(Activity activity, String title, CharSequence message) {
		    AlertDialog.Builder builder = new AlertDialog.Builder(activity);
		    if (title != null)
		        builder.setTitle(title);
		    builder.setMessage(message);
		   // builder.setItems(items, null);
		    builder.setPositiveButton("OK", null);
		    builder.setNegativeButton("Cancel", null);
		    builder.show();
		}
		
    }
	
	
	
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_course);
		
		
		
		    
		
		//Activity Check button
				btnCheck.setOnClickListener(new View.OnClickListener() {
					//@Override
					public void onClick(View v) {
						//Intent i = new Intent(getApplicationContext(), CameraActivity.class);
							//startActivity(i);
						Intent takePictureIntent = new Intent(
								MediaStore.ACTION_IMAGE_CAPTURE);
						Date today = new Date();
						DateFormat df = new SimpleDateFormat("dd-MM-yyyy_HH-mm-ss");				
						String path = "photo_" + df.format(today) + ".jpg";
						
					//	File f = new File(Environment.getExternalStorageDirectory(),
					//			"photo_" + df.format(today) + ".jpg");
						
						File f = new File(Environment.getExternalStoragePublicDirectory(
					            Environment.DIRECTORY_PICTURES),
										"photo_" + df.format(today) + ".jpg");
									
						
						imagePath = f.getAbsolutePath();
						takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT,
								Uri.fromFile(f));

						// mUri = Uri.fromFile(f);
						startActivityForResult(takePictureIntent, 12345);
					
					}
				});
				
				
				
				
	}
    
	public void addNick(Course friend){
        array.add(0,friend);
        arrayAdapter.notifyDataSetChanged();
    }
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		if (resultCode != Activity.RESULT_CANCELED) {
			switch (requestCode) {
			case 12345:

				if (resultCode == Activity.RESULT_OK) {
					Context context = getApplicationContext();
					File f = new File(imagePath);
					Toast a = Toast.makeText(context, imagePath + ". Size: "
							+ f.length() +".", Toast.LENGTH_LONG);
					a.show();
					new MyTask(this).execute();
					// FileUploader.UploadFile(imagePath);

				}
			}
		}
	}
}