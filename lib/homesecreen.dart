import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  var user;
  HomeScreen({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 60.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "You are logged in\n",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "\t\t\t\t\t\t\t\t\tsucessfully",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            user.phonenumber,
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
