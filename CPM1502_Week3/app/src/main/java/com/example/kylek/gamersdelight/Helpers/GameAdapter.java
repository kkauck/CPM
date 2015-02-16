//Kyle Kauck
//February 3, 2015

package com.example.kylek.gamersdelight.Helpers;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.example.kylek.gamersdelight.R;

import java.util.ArrayList;

public class GameAdapter extends BaseAdapter {

    public static final long CONSTANT_ID = 0x01010101L;
    private Context mContext;
    private ArrayList<GameHelper> mHelper;

    public GameAdapter(Context _context, ArrayList<GameHelper> _gameArray){

        mContext = _context;
        mHelper = _gameArray;

    }

    @Override
    public int getCount() {

        return mHelper.size();

    }

    @Override
    public Object getItem(int position) {

        return mHelper.get(position);

    }

    @Override
    public long getItemId(int position) {

        return CONSTANT_ID + position;

    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {

        if (convertView == null){

            convertView = LayoutInflater.from(mContext).inflate(R.layout.game_list, parent, false);

        }

        GameHelper helper = (GameHelper) getItem(position);

        TextView name = (TextView) convertView.findViewById(R.id.listGameName);
        TextView price = (TextView) convertView.findViewById(R.id.listGamePrice);

        name.setText(helper.getName());
        price.setText("Price Of Game: $" + helper.getPrice());

        return convertView;

    }
}
