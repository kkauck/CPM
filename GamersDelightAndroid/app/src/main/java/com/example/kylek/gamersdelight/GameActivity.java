//Kyle Kauck
//February 3, 2015

package com.example.kylek.gamersdelight;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.ActionBarActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;

import com.parse.ParseUser;

public class GameActivity extends ActionBarActivity{

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.game_activity);

        GameFragment frag = new GameFragment();
        getFragmentManager().beginTransaction().replace(R.id.game_container, frag).commit();

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.game_menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_create) {

            Intent intent = new Intent(this, AddGameActivity.class);
            startActivity(intent);

        } else if (id == R.id.action_logout){

            ParseUser.logOut();

            Toast.makeText(this, "You Have Successfully Logged Out", Toast.LENGTH_LONG).show();

        }

        return super.onOptionsItemSelected(item);
    }

}