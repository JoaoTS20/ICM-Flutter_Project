
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:passadicos_spot/main.dart';
import 'package:passadicos_spot/Classes/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'navigation_screen.dart';
import 'option_type_screen.dart';



class SignInScreen extends StatefulWidget {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  //final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<SignInScreen>{
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      );
  }
  Widget _signInButton() {
    return OutlineButton(
    splashColor: Colors.grey,
    onPressed: () {signInWithGoogle().whenComplete(() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            print("SIgn in");
            print(tipo_user);
            if(tipo_user==null){
              return OptionScreen();
            }
            else {
              return NavigationScreen();
            }
          },
        ),
      );
    });},
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Colors.grey),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Sign in with Google',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    ),
  );}

}

