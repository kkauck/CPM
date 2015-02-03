//Kyle Kauck
//February 3, 2015

package com.example.kylek.gamersdelight;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.parse.Parse;
import com.parse.ParseObject;
import com.parse.ParseUser;

public class AddGameFragment extends Fragment {

    TextView mGameName;
    TextView mGamePrice;
    Button mCreateGame;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

        return inflater.inflate(R.layout.add_game_fragment, container, false);

    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {

        super.onActivityCreated(savedInstanceState);

        Parse.initialize(getActivity(), "nIUQZ0RdsWtOjHfl1fVSZ2sUpz6s3kqJRQdyTlwW", "buz2Dn0Mv74kEiW4klIExjoqcXokTznG40UIMqBj");

        final View view = getView();
        assert view != null;

        mGameName = (TextView) view.findViewById(R.id.createGameName);
        mGamePrice = (TextView) view.findViewById(R.id.createGamePrice);

        mCreateGame = (Button) view.findViewById(R.id.createGameButton);
        mCreateGame.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {

                String name = mGameName.getText().toString();
                String value = mGamePrice.getText().toString();
                double price = Double.parseDouble(value);

                ParseUser currentUser = ParseUser.getCurrentUser();

                ParseObject addGame = new ParseObject("Game");
                addGame.put("title", name);
                addGame.put("price", price);
                addGame.put("user", currentUser);
                addGame.saveInBackground();

                Toast.makeText(getActivity(), "Game Has Successfully Been Added", Toast.LENGTH_LONG).show();
                mGameName.setText("");
                mGamePrice.setText("");

            }

        });

    }
}
