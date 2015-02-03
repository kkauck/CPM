//Kyle Kauck
//February 3, 2015

package com.example.kylek.gamersdelight.Helpers;

public class GameHelper {

    private String mGameName;
    private double mGamePrice;

    public GameHelper(){

        mGameName = "";
        mGamePrice = 0;

    }

    public GameHelper (String _name, double _price){

        mGameName = _name;
        mGamePrice = _price;

    }

    public String getName(){

        return mGameName;

    }

    public double getPrice(){

        return mGamePrice;

    }

}
