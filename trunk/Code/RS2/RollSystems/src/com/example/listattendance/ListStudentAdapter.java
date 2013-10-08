package com.example.listattendance;

import java.util.ArrayList;

import android.R;
import android.content.Context;
import android.graphics.Color;
import android.graphics.Typeface;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView.FindListener;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.TextView;
 
public class ListStudentAdapter extends ArrayAdapter<Student>{
    ArrayList<Student> array;
    int resource;
    TextView txtStuCode;
    TextView txtStuName;
    Context context;
    Student rollCall;
    ImageView imgViewIC;
    //Button btnclick;
 
    public ListStudentAdapter(Context context, int textViewResourceId,ArrayList<Student> array) {
        super(context, textViewResourceId,array);
        // TODO Auto-generated constructor stub
 
        this.context = context;
        this.resource = textViewResourceId;
        this.array = array;
    }
    //Adapter control CustomViewFriend
    public View getView(int position, View convertView, ViewGroup parent){
        View studentView = convertView;
        if(studentView ==null ){
        	studentView = new SingleStudentCustom(getContext());
        }
        rollCall = array.get(position);
        if(rollCall !=null){

        	txtStuCode = ((SingleStudentCustom)studentView).txtStuCode;
        	txtStuName = ((SingleStudentCustom)studentView).txtStuName;
            
            // lay doi tuong friend va dua ra UI
            //txtNo.setText(friend.getNo());
            txtStuCode.setText(rollCall.getStudentCode());
            txtStuName.setText(rollCall.getStudentName());
        }
        return studentView;
    }
	
 
}
