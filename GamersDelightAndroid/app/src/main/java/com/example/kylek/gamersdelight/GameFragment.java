//Kyle Kauck
//February 3, 2015

package com.example.kylek.gamersdelight;

import android.app.Fragment;
import android.os.Bundle;
import android.view.ActionMode;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
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
    private ActionMode mAction;
    private int mPosition = -1;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

        return inflater.inflate(R.layout.game_fragment, container, false);

    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {

        super.onActivityCreated(savedInstanceState);

    }

    private ActionMode.Callback actionCallback = new ActionMode.Callback(){

        @Override
        public boolean onCreateActionMode(ActionMode mode, Menu menu) {

            MenuInflater inflate = mode.getMenuInflater();
            inflate.inflate(R.menu.delete_menu, menu);

            return true;

        }

        @Override
        public boolean onPrepareActionMode(ActionMode mode, Menu menu) {

            return false;

        }

        @Override
        public boolean onActionItemClicked(ActionMode mode, MenuItem item) {

            if (item.getItemId() == R.id.gameDelete){

                deleteThisGame();
                mode.finish();

                return true;

            } else {

                return false;

            }

        }

        @Override
        public void onDestroyActionMode(ActionMode mode) {

            mAction = null;

        }

    };

    @Override
    public void onResume() {

        super.onResume();

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
                        String id = parseObjects.get(i).getObjectId();

                        mGameDetails.add(new GameHelper(name, price, id));

                    }

                } else {

                    Toast.makeText(getActivity(), "Sorry There Were No Games To Display", Toast.LENGTH_LONG).show();

                }

                mGameList.setAdapter(null);
                mGameList.setAdapter(new GameAdapter(getActivity(), mGameDetails));

            }

        });

        mGameList.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() {

            @Override
            public boolean onItemLongClick(AdapterView<?> parent, View view, int position, long id) {

                if (mAction != null){

                    return false;

                }

                mPosition = position;
                mAction = getActivity().startActionMode(actionCallback);

                return true;

            }

        });

    }

    private void deleteThisGame() {

        mHelper = mGameDetails.get(mPosition);
        String gameID = mHelper.getID();

        final ParseQuery<ParseObject> games = ParseQuery.getQuery("Game");
        games.whereEqualTo("objectId", gameID);
        games.findInBackground(new FindCallback<ParseObject>() {

            @Override
            public void done(List<ParseObject> parseObjects, ParseException e) {

                if (e == null){

                    for (int i = 0; i < parseObjects.size(); i++){

                        ParseObject current = parseObjects.get(i);
                        current.deleteInBackground();
                        updateList();

                    }

                }

            }

        });

    }

    private void updateList(){

        mGameDetails.clear();

        ParseUser currentUser = ParseUser.getCurrentUser();

        final ParseQuery<ParseObject> games = ParseQuery.getQuery("Game");
        games.whereEqualTo("user", currentUser);
        games.findInBackground(new FindCallback<ParseObject>() {

            @Override
            public void done(List<ParseObject> parseObjects, ParseException e) {

                if (e == null) {

                    for (int i = 0; i < parseObjects.size(); i++) {

                        String name = parseObjects.get(i).getString("title");
                        Double price = parseObjects.get(i).getDouble("price");
                        String id = parseObjects.get(i).getObjectId();

                        mGameDetails.add(new GameHelper(name, price, id));

                    }

                } else {

                    Toast.makeText(getActivity(), "Sorry There Were No Games To Display", Toast.LENGTH_LONG).show();

                }

                mGameList.setAdapter(null);
                mGameList.setAdapter(new GameAdapter(getActivity(), mGameDetails));

            }

        });

    }

}
