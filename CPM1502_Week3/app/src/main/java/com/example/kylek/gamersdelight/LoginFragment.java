//Kyle Kauck
//February 3, 2015

package com.example.kylek.gamersdelight;

import android.app.AlertDialog;
import android.app.Fragment;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.parse.LogInCallback;
import com.parse.Parse;
import com.parse.ParseACL;
import com.parse.ParseException;
import com.parse.ParseUser;

public class LoginFragment extends Fragment {

    TextView mUsername;
    TextView mPassword;
    Button mLogin;
    Button mCreate;


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

        return inflater.inflate(R.layout.login_layout, container, false);

    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {

        super.onActivityCreated(savedInstanceState);

        final View view = getView();
        assert view != null;

        mUsername = (TextView) view.findViewById(R.id.usernameLogin);
        mPassword = (TextView) view.findViewById(R.id.passwordLogin);
        mLogin = (Button) view.findViewById(R.id.loginButton);
        mCreate = (Button) view.findViewById(R.id.createButton);

    }

    @Override
    public void onResume() {

        super.onResume();

        if (networkCheck()){

            connectedToNet();

        } else {

            notConnectedToNet();

        }

    }

    private void connectedToNet(){

        //This will ensure that both buttons are enabled after finding a connection
        mLogin.setEnabled(true);
        mCreate.setEnabled(true);

        Parse.initialize(getActivity(), "nIUQZ0RdsWtOjHfl1fVSZ2sUpz6s3kqJRQdyTlwW", "buz2Dn0Mv74kEiW4klIExjoqcXokTznG40UIMqBj");

        ParseUser current = ParseUser.getCurrentUser();
        if (current != null){

            current.setACL(new ParseACL(current));

            Intent intent = new Intent(getActivity(), GameActivity.class);
            startActivity(intent);
            getActivity().finish();

        }

        mLogin.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {

                String username = mUsername.getText().toString().toLowerCase();
                String password = mPassword.getText().toString();

                ParseUser.logInInBackground(username, password, new LogInCallback() {

                    @Override
                    public void done(ParseUser parseUser, ParseException e) {

                        if (parseUser != null){

                            Toast.makeText(getActivity(), "You Have Successfully Logged In", Toast.LENGTH_LONG).show();
                            Intent intent = new Intent(getActivity(), GameActivity.class);
                            startActivity(intent);
                            getActivity().finish();

                        } else {

                            Toast.makeText(getActivity(), "Login Has Failed, Please Check Username/Password", Toast.LENGTH_LONG).show();

                        }

                    }

                });

            }

        });

        mCreate.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {

                Intent createUser = new Intent(getActivity(), CreateActivity.class);
                startActivity(createUser);

            }

        });

    }

    private void notConnectedToNet(){

        //Disables buttons so user cannot try and access sections of the app that do not work
        mCreate.setEnabled(false);
        mLogin.setEnabled(false);

        //Will create a new Alert that is displayed to the user when they are not connected to any network
        AlertDialog.Builder newAlert = new AlertDialog.Builder(getActivity());
        newAlert.setTitle(R.string.noNetwork);
        newAlert.setMessage(R.string.noNetMessage);
        newAlert.setNegativeButton("Close", new DialogInterface.OnClickListener() {

            @Override
            public void onClick(DialogInterface dialog, int which) {

                dialog.cancel();

            }
        });

        AlertDialog noNetAlert = newAlert.create();
        noNetAlert.show();

    }

    protected boolean networkCheck(){

        ConnectivityManager manager = (ConnectivityManager) getActivity().getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo information =  manager.getActiveNetworkInfo();

        if (information != null && information.isConnectedOrConnecting()){

            return true;

        } else {

            return false;

        }

    }

}
