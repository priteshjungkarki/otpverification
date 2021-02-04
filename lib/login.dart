import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:optapp/homesecreen.dart';
import './error.dart';

class LoginScreen extends StatelessWidget {
  final _phonecontroller = TextEditingController();
  final _codecontroller = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();
        UserCredential result = await _auth.signInWithCredential(credential);

        FirebaseUser user = result.user;
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(user: user),
            ),
          );
        } else {
          print('Error');
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ErrorScreen(),
          //   ),
          // );
        }
      },
      verificationFailed: (Exception exception) {
        print(exception);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ErrorScreen(),
        // ),
        //);
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text('Give the code'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _codecontroller,
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () async {
                    final code = _codecontroller.text.trim();
                    AuthCredential credential = PhoneAuthProvider.getCredential(
                        verificationId: verificationId, smsCode: code);

                    UserCredential result =
                        await _auth.signInWithCredential(credential);
                    FirebaseUser user = result.user;
                    if (user != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(user: user)));
                    } else {
                      print('Error');
                    }
                  },
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
        print(verificationId);
        print("Timout");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32.0),
        child: Container(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.lightBlue,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _phonecontroller,
                  decoration: InputDecoration(
                    focusColor: Colors.black87,
                    filled: true,
                    hintText: 'Mobile Number',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                        color: Colors.black87,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Login',
                    ),
                    onPressed: () {
                      final phone = _phonecontroller.text.trim();
                      loginUser(phone, context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
