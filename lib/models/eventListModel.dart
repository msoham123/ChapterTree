import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FBLAEvent {
  String title, description, date, location, state, url;
  Image picture;
  LatLng coordinate;

  FBLAEvent(String title, String description, String date, String location, String state, String url, Image picture, LatLng coordinate){
    this.title  = title;
    this.description = description;
    this.date = date;
    this.location = location;
    this.state = state;
    this.url = url;
    this.picture = picture;
    this.coordinate = coordinate;
  }
}

class FBLAEventModel{
  static var CaliforniaEvents = [
    FBLAEvent(
        "Northern Section",
        "",
        "February 8th, 2020",
        "Colusa High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=158",
        Image.asset("assets/eventImages/colusa.jpg",fit: BoxFit.fill,),
        LatLng(39.199978, -122.020491)
    ),
    FBLAEvent("Bay Section",
        "",
        "February 8th, 2020",
        "Westmoor High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=118",
        Image.asset("assets/eventImages/westmoor.png",fit: BoxFit.fill,),
        LatLng(37.684251, -122.483085)
    ),
    FBLAEvent("Central Section",
        "",
        "February 8th, 2020",
        "Redwood High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=131",
        Image.asset("assets/eventImages/redwood.jpg",fit: BoxFit.fill,),
        LatLng(36.329872, -119.301711)
    ),
    FBLAEvent("Gold Coast Section",
        "",
        "February 22nd, 2020",
        "South Pasadena High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=136",
        Image.asset("assets/eventImages/pasadena.jpg",fit: BoxFit.fill,),
        LatLng(34.110013, -118.154397)
    ),
    FBLAEvent("Inland Section",
        "",
        "February 8th, 2020",
        "Los Osos High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=142",
        Image.asset("assets/eventImages/lososos.jpg",fit: BoxFit.fill,),
        LatLng(34.146786, -117.556609)
    ),
    FBLAEvent("Southern Section",
        "",
        "February 22nd, 2020",
        "Valencia High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=172",
        Image.asset("assets/eventImages/valencia.jpg",fit: BoxFit.fill,),
        LatLng(34.441434, -118.562566)
    ),
  ];

}