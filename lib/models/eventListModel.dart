import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FBLAEvent {
  String title, description, date, location, state, url;
  Image picture;
  LatLng coordinate;
  var localOfficers = [];
  var localOfficerPositions = [];

  FBLAEvent(String title, String description, String date, String location, String state, String url, Image picture, LatLng coordinate, var localOfficers, var localOfficerPositions){
    this.title  = title;
    this.description = description;
    this.date = date;
    this.location = location;
    this.state = state;
    this.url = url;
    this.picture = picture;
    this.coordinate = coordinate;
    this.localOfficers = localOfficers;
    this.localOfficerPositions = localOfficerPositions;
  }
}

class FBLAEventModel {
  static var CaliforniaEvents = [
    FBLAEvent(
        "Northern Section",
        "At the Northern Section Leadership Conference, students compete in events testing their business knowledge and skills. Top section winners are then eligible to compete for state-level awards at the State Leadership Conference each spring.",
        "February 8th, 2020",
        "Colusa High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=158",
        Image.asset("assets/eventImages/colusa.jpg", fit: BoxFit.fill,),
        LatLng(39.199978, -122.020491),
        [
          "Kelsey Whiting",
          "Shahil Pal",
          "Renee Wrysinsiki",
          "Nitya Agarwal",
          "Emily Cerney"
        ],
        [
          "President",
          "Vice President",
          "Secretary/Treasurer",
          "Public Relations Officer",
          "Executive Secretary",
        ]
    ),
    FBLAEvent(
        "Bay Section",
        "At the Bay Section Leadership Conference, students compete in events testing their business knowledge and skills. Top section winners are then eligible to compete for state-level awards at the State Leadership Conference each spring.",
        "February 8th, 2020",
        "Westmoor High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=118",
        Image.asset("assets/eventImages/westmoor.jpg", fit: BoxFit.fill,),
        LatLng(37.684251, -122.483085),
        [
          "Roma Bedekar",
          "Darrren Hsing",
          "Sanya Jain",
          "Angela Zhang",
          "Daniel Zhang",
          "Anna Chiang"
        ],
        [
          "President",
          "VP Outreach",
          "VP Activities",
          "Secretary/Treasurer",
          "Public Relations",
          "Parlimentarian"
        ]
    ),
    FBLAEvent(
        "Central Section",
        "At the Central Section Leadership Conference, students compete in events testing their business knowledge and skills. Top section winners are then eligible to compete for state-level awards at the State Leadership Conference each spring.",
        "February 8th, 2020",
        "Redwood High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=131",
        Image.asset("assets/eventImages/redwood.jpg", fit: BoxFit.fill,),
        LatLng(36.329872, -119.301711),
        [
          "Kyle Tran",
          "Abbie Linhares",
          "Parneet Sahota",
          "Paola Garcia",
          "Haley Cortez",
          "Jessica Abarca",
          "Mr. Jacob Avila"
        ],
        [
          "President",
          "Vice President",
          "Secretary",
          "Treasurer",
          "Public Relations",
          "Historian/Parlimentarian",
          "Central Section Director"
        ]
    ),
    FBLAEvent(
        "Gold Coast Section",
        "At the Gold Coast Section Leadership Conference, students compete in events testing their business knowledge and skills. Top section winners are then eligible to compete for state-level awards at the State Leadership Conference each spring.",
        "February 22nd, 2020",
        "South Pasadena High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=136",
        Image.asset("assets/eventImages/pasadena.jpg", fit: BoxFit.fill,),
        LatLng(34.110013, -118.154397),
        [
          "Christine Huynh",
          "Trevor Gadsby",
          "Aashika Srinivas",
          "Nikil Thanlaki",
          "Casey Lee",
          "Catherine Xu",
          "Mrs. Cathy Mason"
        ],
        [
          "President",
          "VP Activities",
          "VP Membership",
          "Secretary",
          "Public Relations",
          "Leadership Associate",
          "Section Director"
        ]
    ),
    FBLAEvent(
        "Inland Section",
        "At the Inland Section Leadership Conference, students compete in events testing their business knowledge and skills. Top section winners are then eligible to compete for state-level awards at the State Leadership Conference each spring.",
        "February 8th, 2020",
        "Los Osos High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=142",
        Image.asset("assets/eventImages/lososos.jpg", fit: BoxFit.fill,),
        LatLng(34.146786, -117.556609),
        [
          "Joshua Zhang",
          "Calvin Liang",
          "Ashley Ching",
          "Avantika Rozario",
          "Megan Le",
          "Noel Nixen",
          "Arti Patel",
          "Mr. Lee Lara"
        ],
        [
          "President",
          "VP Communications",
          "VP Programs",
          "Secretary",
          "Historian",
          "Leadership Associate",
          "Ex-Officer",
          "Section Director"
        ]
    ),
    FBLAEvent(
        "Southern Section",
        "At the Southern Section Leadership Conference, students compete in events testing their business knowledge and skills. Top section winners are then eligible to compete for state-level awards at the State Leadership Conference each spring.",
        "February 22nd, 2020",
        "Valencia High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=172",
        Image.asset("assets/eventImages/valencia.jpg", fit: BoxFit.fill,),
        LatLng(34.441434, -118.562566),
        [
          "Lauren Cho",
          "Raymond Mo",
          "Jessica Susanto",
          "Shiny Weng",
          "Phuong Tran",
          "Ishaan Sakhrani",
          "Samiya Hai",
          "Joy Millam"
        ],
        [
          "President",
          "VP Activities",
          "VP Membership",
          "Secretary",
          "Public Relations Officer",
          "Leadership Associate",
          "Section Director",
          "Section Director"
        ]
    ),
    FBLAEvent(
        "SLC",
        "At the State Leadership Conferences, students compete in events testing their business knowledge and skills. Top state winners are then eligible to compete for national awards at the National Leadership Conference each summer.",
        "April 23rd, 2020",
        "Ontario Convention Center",
        "California",
        "https://www.cafbla.org/domain/34",
        Image.asset("assets/eventImages/ontario.jpg", fit: BoxFit.fill,),
        LatLng(34.441434, -118.562566),
        [
          "Amber Afzali",
          "Jessie Cheng",
          "Tania Jiroudi",
          "Christian Sim",
          "Muskaan Abdul Sattar",
          "Chloe Ferraiuolo",
          "Emily Remer",
          "Laeticia Yang",
          "Lorna Louie"
        ],
        [
          "State President",
          "Bay Section VP",
          "Central Section VP",
          "Gold Coast Section VP",
          "Inland Section VP",
          "Northern Section VP",
          "Southern Section VP",
          "State Secretary",
          "State Public Relations"
        ]
    ),
    FBLAEvent(
        "NLC",
        "The National Leadership Conference is an extravegant event with lots of talented people from across the nation. ",
        "June 29th, 2020",
        "Salt Lake City",
        "National/Statewide",
        "https://www.fbla-pbl.org/conferences/nlc/",
        Image.asset("assets/eventImages/saltlakecity.jpg", fit: BoxFit.fill,),
        LatLng(34.441434, -118.562566),
        ["NA"],
        ["NA"]
    ),
  ];

  // ----------> <---------- // // ----------> <---------- // // ----------> <---------- // // ----------> <---------- // // ----------> <---------- //

  static var CaliforniaIndex = [
    "Northern Section",
    "Bay Section",
    "Central Section",
    "Gold Coast Section",
    "Inland Section",
    "Southern Section",
    "SLC",
    "NLC"
  ];

  // ----------> <---------- // // ----------> <---------- // // ----------> <---------- // // ----------> <---------- // // ----------> <---------- //

  static Map<String, FBLAEvent> map = {
    "Northern Section": FBLAEvent(
        "Northern Section",
        "At the Northern Section Leadership Conference, students compete in events testing their business knowledge and skills. Top section winners are then eligible to compete for state-level awards at the State Leadership Conference each spring.",
        "February 8th, 2020",
        "Colusa High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=158",
        Image.asset("assets/eventImages/colusa.jpg", fit: BoxFit.fill,),
        LatLng(39.199978, -122.020491),
        [
          "Kelsey Whiting",
          "Shahil Pal",
          "Renee Wrysinsiki",
          "Nitya Agarwal",
          "Emily Cerney"
        ],
        [
          "President",
          "Vice President",
          "Secretary/Treasurer",
          "Public Relations Officer",
          "Executive Secretary",
        ]
    ),
    "Bay Section": FBLAEvent(
        "Bay Section",
        "At the Bay Section Leadership Conference, students compete in events testing their business knowledge and skills. Top section winners are then eligible to compete for state-level awards at the State Leadership Conference each spring.",
        "February 8th, 2020",
        "Westmoor High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=118",
        Image.asset("assets/eventImages/westmoor.jpg", fit: BoxFit.fill,),
        LatLng(37.684251, -122.483085),
        [
          "Roma Bedekar",
          "Darrren Hsing",
          "Sanya Jain",
          "Angela Zhang",
          "Daniel Zhang",
          "Anna Chiang"
        ],
        [
          "President",
          "VP Outreach",
          "VP Activities",
          "Secretary/Treasurer",
          "Public Relations",
          "Parlimentarian"
        ]
    ),
    "Central Section": FBLAEvent(
        "Central Section",
        "At the Central Section Leadership Conference, students compete in events testing their business knowledge and skills. Top section winners are then eligible to compete for state-level awards at the State Leadership Conference each spring.",
        "February 8th, 2020",
        "Redwood High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=131",
        Image.asset("assets/eventImages/redwood.jpg", fit: BoxFit.fill,),
        LatLng(36.329872, -119.301711),
        [
          "Kyle Tran",
          "Abbie Linhares",
          "Parneet Sahota",
          "Paola Garcia",
          "Haley Cortez",
          "Jessica Abarca",
          "Mr. Jacob Avila"
        ],
        [
          "President",
          "Vice President",
          "Secretary",
          "Treasurer",
          "Public Relations",
          "Historian/Parlimentarian",
          "Central Section Director"
        ]
    ),
    "Gold Coast Section": FBLAEvent(
        "Gold Coast Section",
        "At the Gold Coast Section Leadership Conference, students compete in events testing their business knowledge and skills. Top section winners are then eligible to compete for state-level awards at the State Leadership Conference each spring.",
        "February 22nd, 2020",
        "South Pasadena High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=136",
        Image.asset("assets/eventImages/pasadena.jpg", fit: BoxFit.fill,),
        LatLng(34.110013, -118.154397),
        [
          "Christine Huynh",
          "Trevor Gadsby",
          "Aashika Srinivas",
          "Nikil Thanlaki",
          "Casey Lee",
          "Catherine Xu",
          "Mrs. Cathy Mason"
        ],
        [
          "President",
          "VP Activities",
          "VP Membership",
          "Secretary",
          "Public Relations",
          "Leadership Associate",
          "Section Director"
        ]
    ),
    "Inland Section": FBLAEvent(
        "Inland Section",
        "At the Inland Section Leadership Conference, students compete in events testing their business knowledge and skills. Top section winners are then eligible to compete for state-level awards at the State Leadership Conference each spring.",
        "February 8th, 2020",
        "Los Osos High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=142",
        Image.asset("assets/eventImages/lososos.jpg", fit: BoxFit.fill,),
        LatLng(34.146786, -117.556609),
        [
          "Joshua Zhang",
          "Calvin Liang",
          "Ashley Ching",
          "Avantika Rozario",
          "Megan Le",
          "Noel Nixen",
          "Arti Patel",
          "Mr. Lee Lara"
        ],
        [
          "President",
          "VP Communications",
          "VP Programs",
          "Secretary",
          "Historian",
          "Leadership Associate",
          "Ex-Officer",
          "Section Director"
        ]
    ),
    "Southern Section": FBLAEvent(
        "Southern Section",
        "At the Southern Section Leadership Conference, students compete in events testing their business knowledge and skills. Top section winners are then eligible to compete for state-level awards at the State Leadership Conference each spring.",
        "February 22nd, 2020",
        "Valencia High School",
        "California",
        "https://www.cafbla.org/site/Default.aspx?PageID=172",
        Image.asset("assets/eventImages/valencia.jpg", fit: BoxFit.fill,),
        LatLng(34.441434, -118.562566),
        [
          "Lauren Cho",
          "Raymond Mo",
          "Jessica Susanto",
          "Shiny Weng",
          "Phuong Tran",
          "Ishaan Sakhrani",
          "Samiya Hai",
          "Joy Millam"
        ],
        [
          "President",
          "VP Activities",
          "VP Membership",
          "Secretary",
          "Public Relations Officer",
          "Leadership Associate",
          "Section Director",
          "Section Director"
        ]
    ),
    "SLC": FBLAEvent(
        "SLC",
        "At the State Leadership Conferences, students compete in events testing their business knowledge and skills. Top state winners are then eligible to compete for national awards at the National Leadership Conference each summer.",
        "April 23rd, 2020",
        "Ontario Convention Center",
        "California",
        "https://www.cafbla.org/domain/34",
        Image.asset("assets/eventImages/ontario.jpg", fit: BoxFit.fill,),
        LatLng(34.441434, -118.562566),
        [
          "Amber Afzali",
          "Jessie Cheng",
          "Tania Jiroudi",
          "Christian Sim",
          "Muskaan Abdul Sattar",
          "Chloe Ferraiuolo",
          "Emily Remer",
          "Laeticia Yang",
          "Lorna Louie"
        ],
        [
          "State President",
          "Bay Section VP",
          "Central Section VP",
          "Gold Coast Section VP",
          "Inland Section VP",
          "Northern Section VP",
          "Southern Section VP",
          "State Secretary",
          "State Public Relations"
        ]
    ),
    "NLC": FBLAEvent(
        "NLC",
        "",
        "June 29th, 2020",
        "Salt Lake City",
        "National/Statewide",
        "https://www.fbla-pbl.org/conferences/nlc/",
        Image.asset("assets/eventImages/saltlakecity.jpg", fit: BoxFit.fill,),
        LatLng(34.441434, -118.562566),
        ["NA"],
        ["NA"]
    )
  };
}