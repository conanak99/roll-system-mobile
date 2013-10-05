package com.example.rollsystems;

import java.util.ArrayList;
import java.util.HashMap;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import com.example.listview.*;
import com.example.listview.Friend;
import com.example.listview.ListFriendAdapter;
//import com.example.androidhive.LazyAdapter;
//import com.example.androidhive.XMLParser;
import com.example.rollsystems.R;
//import com.example.androidhive.*;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ListView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;


public class CourseActivity extends Activity {
	
	Button btnCheck;
	Button btnReport;
	
        ArrayList<Friend> array;
    ListFriendAdapter arrayAdapter;
    ListView list;
	// All static variables
/*		static final String URL = "http://api.androidhive.info/music/music.xml";
		// XML node keys
		static final String KEY_SONG = "song"; // parent node
		static final String KEY_ID = "id";
		static final String KEY_TITLE = "title";
		static final String KEY_ARTIST = "artist";
		static final String KEY_DURATION = "duration";
		static final String KEY_THUMB_URL = "thumb_url";
		
		ListView list;
	    LazyAdapter adapter; */
	
	
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_course);
		
		list = (ListView)findViewById(R.id.list);
        array = new ArrayList<Friend>();
        arrayAdapter = new ListFriendAdapter(this, R.layout.listview, array);
 
        list.setAdapter(arrayAdapter);
        Friend f = new Friend("SE0569");
        f.setSubject("Advanced Java");
        f.setTime("08h45 - 10h00");
        f.setDate("01-09-2013 to 01-11-2013");
        //f.setSubject("Advanced Java");
        //f.setChecked(true);
        this.addNick(f);
        this.addNick(f =new Friend("SE113"));
        f.setSubject("TTHCM");
        f.setTime("10:15 - 11:45");
        f.setDate("01-09-2013 to 01-11-2013");
        this.addNick(f =new Friend("FB888"));
        f.setSubject("Advanced Database");
        f.setTime("10:15 - 11:45");
        f.setDate("01-09-2013 to 01-11-2013");
        this.addNick(f = new Friend("FA111"));
        f.setSubject("Data Structure and Algorithm");
        f.setTime("12:30 - 15:45");
        f.setDate("01-09-2013 to 01-11-2013");
        //f.setChecked(true);
        this.addNick(f = new Friend("SE0569"));
        f.setSubject("Object Oriented Paradigm");
        f.setTime("08h45 - 10h00");
        f.setDate("01-09-2013 to 01-11-2013");
        this.addNick(f = new Friend("FA777"));
        f.setSubject("Elementary Business English");
        f.setTime("10:15 - 11:45");
        f.setDate("01-09-2013 to 01-11-2013");
        this.addNick(f = new Friend("FA112"));
        f.setSubject("Principles of Accounting 4 Weeks");
        f.setTime("12:30 - 15:45");
        f.setDate("01-09-2013 to 01-11-2013");
        this.addNick(f = new Friend("SE113"));
        f.setSubject("Integrated Marketing Communications");
        f.setTime("08h45 - 10h00");
        f.setDate("01-09-2013 to 01-11-2013");
        this.addNick(f = new Friend("FB881"));
        f.setSubject("Advance Java");
        f.setTime("10:15 - 11:45");
        f.setDate("01-09-2013 to 01-11-2013");
        this.addNick(f = new Friend("FB888"));
        f.setSubject("Advanced Corporate");
        f.setTime("12:30 - 15:45");
        f.setDate("01-09-2013 to 01-11-2013");
        this.addNick(f = new Friend("SE789"));
        f.setSubject("Embedded Software Development");
        f.setTime("08h45 - 10h00");
        f.setDate("01-09-2013 to 01-11-2013");
        this.addNick(f = new Friend("SE432"));
        f.setSubject("Advance Java");
        f.setTime("10:15 - 11:45");
        f.setDate("01-09-2013 to 01-11-2013");
/*		ArrayList<HashMap<String, String>> songsList = new ArrayList<HashMap<String, String>>();

		XMLParser parser = new XMLParser();
		String xml = parser.getXmlFromUrl(URL); // getting XML from URL
		Document doc = parser.getDomElement(xml); // getting DOM element
		
		NodeList nl = doc.getElementsByTagName(KEY_SONG);
		// looping through all song nodes <song>
		for (int i = 0; i < nl.getLength(); i++) {
			// creating new HashMap
			HashMap<String, String> map = new HashMap<String, String>();
			Element e = (Element) nl.item(i);
			// adding each child node to HashMap key => value
			map.put(KEY_ID, parser.getValue(e, KEY_ID));
			map.put(KEY_TITLE, parser.getValue(e, KEY_TITLE));
			map.put(KEY_ARTIST, parser.getValue(e, KEY_ARTIST));
			map.put(KEY_DURATION, parser.getValue(e, KEY_DURATION));
			//map.put(KEY_THUMB_URL, parser.getValue(e, KEY_THUMB_URL));

			// adding HashList to ArrayList
			songsList.add(map);
		}
		

		list=(ListView)findViewById(R.id.list);
		
		// Getting adapter by passing xml data ArrayList
        adapter=new LazyAdapter(this, songsList);        
        list.setAdapter(adapter);
        

        // Click event for single list row
        list.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
							

			}
		});  */
		
		
		//import Edit text & button of page
		btnCheck = (Button) findViewById(R.id.btCheck);
		//btnReport = (Button) findViewById(R.id.btReport);
		//Activity Check button
				btnCheck.setOnClickListener(new View.OnClickListener() {
					//@Override
					public void onClick(View v) {
						Intent i = new Intent(getApplicationContext(), CameraActivity.class);
							startActivity(i);
					}
				});
				//Activity Report button
		/*		btnReport.setOnClickListener(new View.OnClickListener() {
					//@Override
					public void onClick(View v) {
						Intent i = new Intent(getApplicationContext(), CheckManual.class);
							startActivity(i);
					}
				}); */
	}
	/* Initiating Menu XML file (menu.xml) */
  /*  @Override
    public boolean onCreateOptionsMenu(Menu menu)
    {
        MenuInflater menuInflater = getMenuInflater();
        menuInflater.inflate(R.layout.menu, menu);
        return true;
    } */
    
    /**
     * Event Handling for Individual menu item selected
     * Identify single menu item by it's id
     * */
/*    @Override
    public boolean onOptionsItemSelected(MenuItem item)
    {
        
        switch (item.getItemId())
        {
        case R.id.menu_bookmark:
        	// Single menu item is selected do something
        	// Ex: launching new activity/screen or show alert message
            Toast.makeText(CourseActivity.this, "Bookmark is Selected", Toast.LENGTH_SHORT).show();
            return true;
        case R.id.menu_save:
        	Toast.makeText(CourseActivity.this, "Save is Selected", Toast.LENGTH_SHORT).show();
            return true;
        case R.id.menu_search:
        	Toast.makeText(CourseActivity.this, "Search is Selected", Toast.LENGTH_SHORT).show();
            return true;
        case R.id.menu_share:
        	Toast.makeText(CourseActivity.this, "Share is Selected", Toast.LENGTH_SHORT).show();
            return true;
        case R.id.menu_delete:
        	Toast.makeText(CourseActivity.this, "Delete is Selected", Toast.LENGTH_SHORT).show();
            return true;
        case R.id.menu_preferences:
        	Toast.makeText(CourseActivity.this, "Preferences is Selected", Toast.LENGTH_SHORT).show();
            return true;
        default:
            return super.onOptionsItemSelected(item);
        }
    } */
	public void addNick(Friend friend){
        array.add(0,friend);
        arrayAdapter.notifyDataSetChanged();
    }
}
