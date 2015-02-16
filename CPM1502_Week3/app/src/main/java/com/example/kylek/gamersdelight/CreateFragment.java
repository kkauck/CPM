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

import com.parse.Parse;
import com.parse.ParseException;
import com.parse.ParseUser;
import com.parse.SignUpCallback;

public class CreateFragment extends Fragment {

    TextView mUsername;
    TextView mPassword;
    Button mCreate;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

        return inflater.inflate(R.layout.create_fragment, container, false);

    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {

        super.onActivityCreated(savedInstanceState);

        final View view = getView();
        assert view != null;

        Parse.initialize(getActivity(), "nIUQZ0RdsWtOjHfl1fVSZ2sUpz6s3kqJRQdyTlwW", "buz2Dn0Mv74kEiW4klIExjoqcXokTznG40UIMqBj");

        mUsername = (TextView) view.findViewById(R.id.createUsername);
        mPassword = (TextView) view.findViewById(R.id.createPassword);

        mCreate = (Button) view.findViewById(R.id.createAccount);
        mCreate.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {

                String username = mUsername.getText().toString().toLowerCase();
                String password = mPassword.getText().toString();

                ParseUser user = new ParseUser();
                user.setUsername(username);
                user.setPassword(password);

                user.signUpInBackground(new SignUpCallback() {

                    @Override
                    public void done(ParseException e) {

                        if (e == null){

                            Toast.makeText(getActivity(), "New User Was Successfully Created", Toast.LENGTH_LONG).show();
                            Intent login = new Intent(getActivity(), LoginActivity.class);
                            startActivity(login);

                        } else {

                            e.printStackTrace();
                            Toast.makeText(getActivity(), "New User Was Not Created, Try Again", Toast.LENGTH_LONG).show();
                            mUsername.setText("");
                            mPassword.setText("");

                        }

                    }

                });

            }

        });

    }
}
