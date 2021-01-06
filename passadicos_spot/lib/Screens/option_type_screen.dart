import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passadicos_spot/Classes/sign_in.dart';
import 'package:passadicos_spot/Screens/navigation_screen.dart';

class OptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      RaisedButton(
        onPressed: () {
          createRecord('Normal');
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return NavigationScreen();}), ModalRoute.withName('/'));
        },
        color: Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            'Normal',
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)),
      ),
      RaisedButton(
        onPressed: () {
          createRecord('Perito');
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return NavigationScreen();}), ModalRoute.withName('/'));
        },
        color: Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            'Perito',
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)),
      )

        ]);
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