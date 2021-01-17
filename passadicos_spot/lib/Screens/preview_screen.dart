import 'dart:io';
import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passadicos_spot/Screens/navigation_screen.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';

class PreviewScreen extends StatefulWidget {
  File img;

  PreviewScreen(File img){
    this.img = img;
  }

  @override
  _PreviewScreenState createState() => _PreviewScreenState(img);
}

class _PreviewScreenState extends State<PreviewScreen> {
  File _img;
  _PreviewScreenState(File f){
    _img = f;
  }
  String baseURL = "gs://icm-trabalho1.appspot.com/";

  Future uploadImageToFirebase(BuildContext context,Position userLocation) async {
    log("REEEEEEE"+userLocation.latitude.toString()+userLocation.longitude.toString());
    String fileName = basename(_img.path);
    List<String> split_filename = fileName.split(".");
    log(fileName);
    fileName = new DateFormat("yyyy_MM_dd_HH_mm_ss").format(new DateTime.now())
        + '.' + split_filename[split_filename.length-1];
    //TODO: somar username
    log(fileName);

    /*
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_img);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getName().then(
          (value) => uploadPostToFirebase(context,baseURL+value,userLocation),
    );
     */
  }
  Future uploadPostToFirebase(BuildContext context, dynamic link,Position pos) async {
    //TODO: Fazer função pra enviar isto
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.file(File(_img.path)),
              TextField(),
              Align(alignment: Alignment.centerRight,child:RaisedButton(
                onPressed: () async {
                    log("it's all coming together");
                    Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;
                    Position userLocation = await geoLocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                    uploadImageToFirebase(context,userLocation).whenComplete(() => log("upload done"));
                    Navigator.push(context,MaterialPageRoute(builder: (context) => NavigationScreen()));
                },
                color: Colors.lightBlue,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    'Publicar',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              )
              )
            ],
          ),
        )
    );
  }
}