package com.example.rollsystems;

import com.example.rollsystems.R;

import java.util.ArrayList;
import java.util.List;
import android.view.View.OnClickListener;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;


public class CheckAttendanceActivity extends Activity {
	
	
	Button btnCheckAll;
	Button btnAtten;
	private Spinner spinner1;
	
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_face);
		
		//import Edit text & button of page
		btnCheckAll = (Button) findViewById(R.id.btCheckAll);
		btnAtten = (Button) findViewById(R.id.btAtten);
		
		
		//Activity Check button
				btnCheckAll.setOnClickListener(new View.OnClickListener() {
					//@Override
					public void onClick(View v) {
						
					}
				});
				//Activity Check button
				btnAtten.setOnClickListener(new View.OnClickListener() {
					//@Override
					public void onClick(View v) {
						Intent i = new Intent(getApplicationContext(), CourseActivity.class);
							startActivity(i);
					}
				});
	}
}
