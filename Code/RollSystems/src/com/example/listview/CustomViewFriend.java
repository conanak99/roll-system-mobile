package com.example.listview;

import com.example.rollsystems.R;

import android.content.Context;
import android.view.LayoutInflater;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.TextView;
 
public class CustomViewFriend extends LinearLayout {
    //CheckBox checkBox;
    TextView txtNo;
    TextView txtSubject;
    TextView txtClass;
    TextView txtTime;
    TextView txtDate;
    
    Context context;
    public CustomViewFriend(Context context) {
        super(context);
        // TODO Auto-generated constructor stub
        // su dung LayoutInflater de gan giao dien trong listview.xml
        this.context = context;
        LayoutInflater li = (LayoutInflater)this.getContext()
        .getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        li.inflate(R.layout.listview, this,true);
 
        
        txtNo= (TextView)findViewById(R.id.txtNo);
        txtSubject = (TextView)findViewById(R.id.txtSubject);
        txtClass= (TextView)findViewById(R.id.txtClass);
        txtTime = (TextView)findViewById(R.id.txtTime);
        txtDate= (TextView)findViewById(R.id.txtDate);
    }
}
