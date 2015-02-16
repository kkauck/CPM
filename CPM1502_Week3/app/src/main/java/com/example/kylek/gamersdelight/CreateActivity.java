package com.example.kylek.gamersdelight;

import android.app.Activity;
import android.os.Bundle;

/**
 * Created by kylek on 02/03/2015.
 */
public class CreateActivity extends Activity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.create_main);

        CreateFragment frag = new CreateFragment();
        getFragmentManager().beginTransaction().replace(R.id.create_container, frag).commit();

    }
}
