package com.example.listview;

import java.util.ArrayList;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.TextView;
 
public class ListFriendAdapter extends ArrayAdapter<Friend>{
    ArrayList<Friend> array;
    int resource;
    TextView txtNo;
    TextView txtSubject;
    TextView txtClass;
    TextView txtTime;
    TextView txtDate;
    Context context;
    Friend friend;
    //Button btnclick;
 
    public ListFriendAdapter(Context context, int textViewResourceId,ArrayList<Friend> array) {
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
            friendView = new CustomViewFriend(getContext());
        }
        friend = array.get(position);
        if(friend !=null){
            txtNo = ((CustomViewFriend)friendView).txtNo;
            txtSubject = ((CustomViewFriend)friendView).txtSubject;
            txtClass = ((CustomViewFriend)friendView).txtClass;
            txtTime = ((CustomViewFriend)friendView).txtTime;
            txtDate = ((CustomViewFriend)friendView).txtDate;
            //check =((CustomViewFriend)friendView).checkBox;
            // lay doi tuong friend va dua ra UI
            txtNo.setText(friend.getNo());
            txtSubject.setText(friend.getSubject());
            txtClass.setText(friend.getClasses());
            txtTime.setText(friend.getTime());
            txtDate.setText(friend.getDate());
            //check.setChecked(friend.isChecked());
        }
        return friendView;
    }
	
 
}
