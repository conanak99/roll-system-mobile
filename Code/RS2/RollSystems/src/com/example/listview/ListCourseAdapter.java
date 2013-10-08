package com.example.listview;

import java.util.ArrayList;

import org.dto.Course;

import android.content.Context;
import android.graphics.Typeface;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;
 
public class ListCourseAdapter extends ArrayAdapter<Course>{
    ArrayList<Course> array;
    int resource;
    TextView txtNo;
    TextView txtSubject;
    TextView txtClass;
    TextView txtTime;
    TextView txtDate;
    Context context;
    Course rollCall;
    TextView txtCurrent;
    ImageView imgViewIC;
    //CourseTask courseTask;
    //Button btnclick;
 
    public ListCourseAdapter (Context context, int textViewResourceId,ArrayList<Course> array) {
    //private ListCourseAdapter (CourseActivity.) {
        super(context, textViewResourceId,array);
        // TODO Auto-generated constructor stub
 
        this.context = context;
        this.resource = textViewResourceId;
        this.array = array;
    } 

	//Adapter control CustomViewFriend
    public View getView(int position, View convertView, ViewGroup parent){
        View friendView = convertView;
        if(friendView ==null ){
            friendView = new SingleCourseCustom(getContext());
        }
        rollCall = array.get(position);
        if(rollCall !=null){

            //txtNo = ((CustomViewFriend)friendView).txtNo;
            txtSubject = ((SingleCourseCustom)friendView).txtSubject;
            txtClass = ((SingleCourseCustom)friendView).txtClass;
            txtTime = ((SingleCourseCustom)friendView).txtTime;
            txtDate = ((SingleCourseCustom)friendView).txtDate;
            //check =((CustomViewFriend)friendView).checkBox;
            // lay doi tuong friend va dua ra UI
           
        	if(rollCall.isCurrent()) {
        		//((CustomViewFriend)friendView).setBackgroundColor(Color.argb(1, 25, 79, 30));
        		txtDate.setTypeface(Typeface.DEFAULT_BOLD);
        		txtClass.setTypeface(Typeface.DEFAULT_BOLD);
        		txtTime.setTypeface(Typeface.DEFAULT_BOLD);
        		txtSubject.setTypeface(Typeface.DEFAULT_BOLD);
        		//txtCurrent = ((CustomViewFriend)friendView).txtCurrent;
        		//txtCurrent.setText("Current Teaching!");
        		imgViewIC = ((SingleCourseCustom)friendView).imgView;
        		imgViewIC.setImageResource(com.example.rollsystems.R.drawable.heart);
        	}
            
            
            //txtNo.setText(friend.getNo());
            txtSubject.setText(rollCall.getSubject());
            txtClass.setText(rollCall.getClasses());
            txtTime.setText(rollCall.getTime());
            txtDate.setText(rollCall.getDate());
            //check.setChecked(friend.isChecked());
        }
        return friendView;
    }
	
 
}
