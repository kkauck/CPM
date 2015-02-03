//Kyle Kauck
//February 3, 2015

package com.example.kylek.gamersdelight;

import android.app.Fragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.Toast;

import com.example.kylek.gamersdelight.Helpers.GameAdapter;
import com.example.kylek.gamersdelight.Helpers.GameHelper;
import com.parse.FindCallback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.ArrayList;
import java.util.List;

public class GameFragment extends Fragment {

    private ArrayList<GameHelper> mGameDetails = new ArrayList<>();
    GameHelper mHelper;
    private ListView mGameList;
    View view;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

        return inflater.inflate(R.layout.game_fragment, container, false);

    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {

        super.onActivityCreated(savedInstanceState);

        final View view = getView();
        assert view != null;

        ParseUser currentUser = ParseUser.getCurrentUser();

        mGameDetails.clear();

        mGameList = (ListView) view.findViewById(R.id.gameList);

        final ParseQuery<ParseObject> games = ParseQuery.getQuery("Game");
        games.whereEqualTo("user", currentUser);
        games.findInBackground(new FindCallback<ParseObject>() {

            @Override
            public void done(List<ParseObject> parseObjects, ParseException e) {

                if (e == null){

                    for (int i = 0; i < parseObjects.size(); i++){

                        String name = parseObjects.get(i).getString("title");
                        Double price = parseObjects.get(i).getDouble("price");

                        mGameDetails.add(new GameHelper(name, price));

                    }

                } else {

                    Toast.makeText(getActivity(), "Sorry There Were No Games To Display", Toast.LENGTH_LONG).show();

                }

                mGameList.setAdapter(new GameAdapter(getActivity(), mGameDetails));

            }

        });

    }

}
