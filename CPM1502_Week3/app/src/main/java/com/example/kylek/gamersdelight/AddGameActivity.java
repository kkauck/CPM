//Kyle Kauck
//February 3, 2015

package com.example.kylek.gamersdelight;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

public class AddGameActivity extends Activity {

    public static final String GAME_NAME = "GAME_NAME";
    public static final String GAME_ID = "GAME_ID";
    public static final String GAME_PRICE = "GAME_PRICE";
    //private double defaultVal = 0.0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.add_game_activity);

        if (savedInstanceState == null){

            AddGameFragment frag = new AddGameFragment();
            getFragmentManager().beginTransaction().replace(R.id.add_container, frag).commit();

            Intent intent = getIntent();

            AddGameFragment.mUpdateName = intent.getStringExtra(GAME_NAME);
            AddGameFragment.mID = intent.getStringExtra(GAME_ID);
            AddGameFragment.mUpdatePrice = intent.getDoubleExtra(GAME_PRICE, 0.0);

        }

    }
}
