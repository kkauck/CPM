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

import com.parse.GetCallback;
import com.parse.Parse;
import com.parse.ParseACL;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

public class AddGameFragment extends Fragment {

    TextView mGameName;
    TextView mGamePrice;
    Button mCreateGame;
    public static String mUpdateName;
    public static String mID;
    public static double mUpdatePrice;

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

        if (mID != null){

            mGameName.setText(mUpdateName);
            mGamePrice.setText(Double.toString(mUpdatePrice));

            mCreateGame = (Button) view.findViewById(R.id.createGameButton);
            mCreateGame.setText("Update Game");
            mCreateGame.setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View v) {

                    if (mGameName.getText().toString().equals("") && (mGamePrice.getText().toString().equals(""))) {

                        mGameName.setError("Please Enter A Game Name.");
                        mGamePrice.setError("Please Enter A Price");

                    } else if (mGameName.getText().toString().equals("")) {

                        mGameName.setError("Please Enter A Game Name.");

                    } else if (mGamePrice.getText().toString().equals("")){

                        mGamePrice.setError("Please Enter A Price");

                    } else {

                        try {

                            final String name = mGameName.getText().toString();
                            String value = mGamePrice.getText().toString();
                            final double price = Double.parseDouble(value);

                            ParseACL.setDefaultACL(new ParseACL(), true);

                            ParseQuery<ParseObject> findGame = ParseQuery.getQuery("Game");

                            findGame.getInBackground(mID, new GetCallback<ParseObject>() {

                                @Override
                                public void done(ParseObject game, ParseException e) {

                                    if (e == null){

                                        game.put("title", name);
                                        game.put("price", price);
                                        game.saveInBackground();

                                    }

                                }

                            });

                            Toast.makeText(getActivity(), "Game Has Successfully Been Updated", Toast.LENGTH_LONG).show();
                            mGameName.setText("");
                            mGamePrice.setText("");

                        } catch (NumberFormatException error) {

                            mGamePrice.setError("Please Enter A Valid Price");

                        }

                    }

                }

            });

        } else {

            mCreateGame = (Button) view.findViewById(R.id.createGameButton);
            mCreateGame.setOnClickListener(new View.OnClickListener() {

                @Override
                public void onClick(View v) {

                    if (mGameName.getText().toString().equals("") && (mGamePrice.getText().toString().equals(""))) {

                        mGameName.setError("Please Enter A Game Name.");
                        mGamePrice.setError("Please Enter A Price");

                    } else if (mGameName.getText().toString().equals("")) {

                        mGameName.setError("Please Enter A Game Name.");

                    } else if (mGamePrice.getText().toString().equals("")) {

                        mGamePrice.setError("Please Enter A Price");

                    } else {

                        try {

                            String name = mGameName.getText().toString();
                            String value = mGamePrice.getText().toString();
                            double price = Double.parseDouble(value);

                            ParseUser currentUser = ParseUser.getCurrentUser();

                            ParseACL.setDefaultACL(new ParseACL(), true);

                            ParseObject addGame = new ParseObject("Game");
                            addGame.put("title", name);
                            addGame.put("price", price);
                            addGame.put("user", currentUser);
                            addGame.saveInBackground();

                            Toast.makeText(getActivity(), "Game Has Successfully Been Added", Toast.LENGTH_LONG).show();
                            mGameName.setText("");
                            mGamePrice.setText("");

                        } catch (NumberFormatException error) {

                            mGamePrice.setError("Please Enter A Valid Price");

                        }

                    }

                }

            });

        }

    }
}
