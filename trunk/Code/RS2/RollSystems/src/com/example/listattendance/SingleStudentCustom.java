package com.example.listattendance;

import com.example.rollsystems.R;

import android.content.Context;
import android.view.LayoutInflater;
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
 
public class SingleStudentCustom extends LinearLayout {
    //CheckBox checkBox;
    
    TextView txtStuCode;
    TextView txtStuName;
    
    
    Context context;
    public SingleStudentCustom(Context context) {
        super(context);
        // TODO Auto-generated constructor stub
        // su dung LayoutInflater de gan giao dien trong listview.xml
        this.context = context;
        LayoutInflater li = (LayoutInflater)this.getContext()
        .getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        li.inflate(R.layout.list_atstudent, this,true);
 
        
        //txtNo= (TextView)findViewById(R.id.txtNo);
        txtStuCode = (TextView)findViewById(R.id.txtStudentCode);
        txtStuName= (TextView)findViewById(R.id.txtStudentName);
        
    }
}
