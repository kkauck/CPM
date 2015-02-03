//Kyle Kauck
//February 3, 2015

package com.example.kylek.gamersdelight;

import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;

public class GameActivity extends ActionBarActivity{

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        GameFragment frag = new GameFragment();
        getFragmentManager().beginTransaction().replace(R.id.game_container, frag).commit();

    }

}