package com.example.rollsystems;

import com.example.rollsystems.R;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ProgressBar;
import android.app.AlertDialog;

public class LoginActivity extends Activity  {

	protected static final int ACTIVITY_CREATE = 0;
	//protected static final Context Context = null;
	
	EditText inputUsername;
	EditText inputPassword;
	Button btnLogin;
	ProgressBar pB1;
	
	@SuppressWarnings("deprecation")
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_login);
		
		//import Edit text & button of page
		inputUsername = (EditText) findViewById(R.id.txtUsername);
		inputPassword = (EditText) findViewById(R.id.txtPassword);
		btnLogin = (Button) findViewById(R.id.btnLogin);
		
		
		//create alert box
		final AlertDialog alertDialog = new AlertDialog.Builder(this).create();
		alertDialog.setTitle("Error!");
		alertDialog.setMessage("Wrong username or password, please try again!");
		alertDialog.setIcon(R.drawable.icon_smile);
		alertDialog.setButton("OK", new DialogInterface.OnClickListener() {
		   public void onClick(DialogInterface dialog, int which) {
		      // here you can add functions
			   pB1.setVisibility(View.INVISIBLE);
		   }
		}); 
		
		//create alert box
				final AlertDialog alertDialog1 = new AlertDialog.Builder(this).create();
				alertDialog1.setTitle("Error!");
				alertDialog1.setMessage("Please field full username and password!");
				alertDialog1.setIcon(R.drawable.icon_smile);
				alertDialog1.setButton("OK", new DialogInterface.OnClickListener() {
				   public void onClick(DialogInterface dialog, int which) {
				      // here you can add functions
					   pB1.setVisibility(View.INVISIBLE);
				   }
				}); 
		
		//Create progressBar
		pB1 = (ProgressBar) findViewById(R.id.progressBarLogin);
		pB1.setVisibility(View.INVISIBLE);
		
		//Activity Login button
		btnLogin.setOnClickListener(new View.OnClickListener() {
			//@Override
			public void onClick(View v) {
				String name = inputUsername.getText().toString();
				String password = inputPassword.getText().toString();
				pB1.setVisibility(View.VISIBLE);
				if ((name.equals("")) || (password.equals(""))) {
					alertDialog1.show();
				} else if ((name.equals("instructor")) && (password.equals("123456"))) {
					Intent i = new Intent(getApplicationContext(), CourseActivity.class);
					startActivity(i);
				} else {
					alertDialog.show();
				}
			}
		});
	}
}
