package com.example.rollsystems;

import com.example.rollsystems.R;

import java.util.ArrayList;
import java.util.List;
import android.view.View.OnClickListener;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.TextView;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;


public class CheckManual extends Activity {
	
	TextView txtClassAt;
	TextView txtSubjectAt;
	TextView txtInstructorAt;
	TextView txtTimeAt;
	TextView txtDateAt;
	Button btnSubmitAt;
	//private Spinner spinner1;
	
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		this.setContentView(R.layout.activity_atmanual);
		
		btnSubmitAt = (Button) findViewById(R.id.btSubmitAt);
		
		TextView txtClassAt = (TextView) findViewById(R.id.txtClassAt1);
		TextView txtSubjectAt = (TextView) findViewById(R.id.txtSubjectAt1);
		TextView txtInstructorAt = (TextView) findViewById(R.id.txtInstructorAt1);
		TextView txtTimeAt = (TextView) findViewById(R.id.txtTimeAt1);
		TextView txtDateAt = (TextView) findViewById(R.id.txtDateAt1);
        
        Intent i = getIntent();
        
        // getting attached intent data
        String classAt = i.getStringExtra("classAt");
        String instructorAt = i.getStringExtra("instructorAt");
        String subjectAt = i.getStringExtra("subjectAt");
        String timeAt = i.getStringExtra("timeAt");
        String dateAt = i.getStringExtra("dateAt");
        
        // displaying selected product name
        txtClassAt.setText(classAt);
        txtSubjectAt.setText(instructorAt);
        txtInstructorAt.setText(subjectAt);
        txtTimeAt.setText(timeAt);
        txtDateAt.setText(dateAt);
		
		//Activity Check button
		btnSubmitAt.setOnClickListener(new View.OnClickListener() {
					//@Override
					public void onClick(View v) {
						
					}
				});
				
	}
}
