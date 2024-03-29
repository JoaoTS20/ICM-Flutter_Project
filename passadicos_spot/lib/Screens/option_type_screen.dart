import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passadicos_spot/Classes/sign_in.dart';
import 'package:passadicos_spot/Screens/navigation_screen.dart';

class OptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Colors.white,

          body:Container(
            child: Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        createRecord('Normal');
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return NavigationScreen();}), ModalRoute.withName('/'));
                      },
                      color: Colors.lightBlue,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          'Normal',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60)),
                    ),
                    RaisedButton(
                      onPressed: () {
                        createRecord('Perito');
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return NavigationScreen();}), ModalRoute.withName('/'));
                      },
                      color: Colors.lightBlue,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          'Perito',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60)),
                    )
                  ],),
            )
          )


        );
  }
}
void createRecord(String tipo) async {
  DocumentReference ref = await Firestore.instance.collection("Users")
      .add({
    'username': username,
    'tipo': tipo
  });
  tipo_user=tipo;
}