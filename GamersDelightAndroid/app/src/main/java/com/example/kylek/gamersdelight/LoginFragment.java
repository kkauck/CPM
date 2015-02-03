//Kyle Kauck
//February 3, 2015

package com.example.kylek.gamersdelight;

import android.app.Fragment;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import com.parse.LogInCallback;
import com.parse.Parse;
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

        Parse.initialize(getActivity(), "nIUQZ0RdsWtOjHfl1fVSZ2sUpz6s3kqJRQdyTlwW", "buz2Dn0Mv74kEiW4klIExjoqcXokTznG40UIMqBj");

        ParseUser current = ParseUser.getCurrentUser();
        if (current != null){

            Intent intent = new Intent(getActivity(), GameActivity.class);
            startActivity(intent);
            getActivity().finish();

        }

        mLogin = (Button) view.findViewById(R.id.loginButton);
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

        mCreate = (Button) view.findViewById(R.id.createButton);
        mCreate.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {

                Intent createUser = new Intent(getActivity(), CreateActivity.class);
                startActivity(createUser);

            }

        });

    }

}
