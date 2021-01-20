import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:passadicos_spot/Classes/Imagem.dart';
import 'package:passadicos_spot/Screens/info_screen.dart';

class MapPin extends StatefulWidget {

  Imagem imageInfo;

  MapPin({ this.imageInfo});

  @override
  State<StatefulWidget> createState() => MapPinState();
}

class MapPinState extends State<MapPin> {

  @override
  Widget build(BuildContext context) {
    if(widget.imageInfo ==null)
      return Container();
    return
      AnimatedPositioned(
      bottom: 0,
      right: 0,
      left: 0,
      duration: Duration(milliseconds: 200),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: (){
            log(widget.imageInfo.toString());
            Navigator.push(context,MaterialPageRoute(builder: (context) => InfoScreen(widget.imageInfo)));
          },
          child: Container(
          margin: EdgeInsets.all(20),
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: <BoxShadow>[
                BoxShadow(blurRadius: 20, offset: Offset.zero, color: Colors.grey.withOpacity(0.5))
              ]
          ),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50, height: 50,
                //margin: EdgeInsets.only(left: 10),
                //child: ClipOval(child: Image.asset(widget.currentlySelectedPin.avatarPath, fit: BoxFit.cover )),
              ),
              Expanded(
                //TODO: Tirar aquele Espaço extra da Esquerda e fazer o coiso desaparecer depois de clicar
                child: Container(
                  child:FutureBuilder<dynamic>(
                    future: getImage(widget.imageInfo.photoURL), // function where you call your api
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  // AsyncSnapshot<Your object type>
                      if( snapshot.connectionState == ConnectionState.waiting){
                        return  Container(margin:EdgeInsets.all(8.0), child: LinearProgressIndicator());
                      }else{
                        if (snapshot.hasError)
                          return Center(child: Text('Error: ${snapshot.error}'));
                        else
                          return ListTile(leading: Image.network(snapshot.data), title: Text(widget.imageInfo.username), subtitle: Text(widget.imageInfo.description));   //:- get your object which is pass from your downloadData() function
                      }
                    },
                  ),


                  //ListTile(leading: Image(image: AssetImage("assets/pa_logo.png")), title: Text(widget.imageInfo.username), subtitle: Text(widget.imageInfo.description))

                  /*Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.imageInfo.username + ": "+ widget.imageInfo.description)
                      //Text(widget.currentlySelectedPin.locationName, style: TextStyle(color: widget.currentlySelectedPin.labelColor)),
                      //Text('Latitude: ${widget.currentlySelectedPin.location.latitude.toString()}', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      //Text('Longitude: ${widget.currentlySelectedPin.location.longitude.toString()}', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),*/
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
Future<dynamic> getImage(String l) async {
  FirebaseStorage _storage = FirebaseStorage.instance;
  StorageReference _ref =  await _storage.getReferenceFromUrl(l);
  return _ref.getDownloadURL();
}