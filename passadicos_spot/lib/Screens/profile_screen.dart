import 'package:flutter/material.dart';
import 'package:passadicos_spot/Classes/sign_in.dart';
import 'package:passadicos_spot/Screens/sign_in_screen.dart';
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: <Widget>[
          Image(
            width: double.infinity,
            height: MediaQuery.of(context).size.height/4,
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/passadico_do_paiva_fundo.jpg'
            ),
          ),
          Positioned(bottom:-60.0,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(imageUrl),
              ),
          ),
        ],
      ),
      Container(

      child:Align(alignment: Alignment.centerRight,child:RaisedButton(
        onPressed: () {
          signOutGoogle();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return SignInScreen();}), ModalRoute.withName('/'));
        },
        color: Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            'Sign Out',
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)),
          )
        )
      ),
      SizedBox(height: 15
      ),
      ListTile(
        title: Center(child:Text(username)),
        subtitle:Center(child: Text("Tipo de User"),)
        ),
      Card(
        child: ListTile(
          title: Text("Os seus Posts:"),
        ),
      )

    ]);
    /*return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 40),
              Text(
                'NAME',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                username,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'EMAIL',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              SizedBox(height: 40),
              RaisedButton(
                onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return SignInScreen();}), ModalRoute.withName('/'));
                },
                color: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              )
            ],
          ),
        ),
      ),
    );*/
  }
}