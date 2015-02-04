//Kyle Kauck
//February 3, 2015

package com.example.kylek.gamersdelight.Helpers;

public class GameHelper {

    private String mGameName;
    private double mGamePrice;
    private String mGameID;

    public GameHelper(){

        mGameName = "";
        mGamePrice = 0;
        mGameID = "";

    }

    public GameHelper (String _name, double _price, String _id){

        mGameName = _name;
        mGamePrice = _price;
        mGameID = _id;

    }

    public String getName(){

        return mGameName;

    }

    public double getPrice(){

        return mGamePrice;

    }

    public String getID(){

        return mGameID;

    }

}
