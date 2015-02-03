//Kyle Kauck
//February 3, 2015

package com.example.kylek.gamersdelight;

import android.app.Activity;
import android.os.Bundle;

public class AddGameActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.add_game_activity);

        AddGameFragment frag = new AddGameFragment();
        getFragmentManager().beginTransaction().replace(R.id.add_container, frag).commit();
    }
}
