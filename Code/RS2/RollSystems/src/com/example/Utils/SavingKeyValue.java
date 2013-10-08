package com.example.Utils;

import com.example.rollsystems.R;

import android.os.Bundle;
import android.preference.PreferenceActivity;
import android.view.Menu;

public class SavingKeyValue extends PreferenceActivity {

	@SuppressWarnings("deprecation")
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);		
		addPreferencesFromResource(R.xml.preferences);
	}

}
