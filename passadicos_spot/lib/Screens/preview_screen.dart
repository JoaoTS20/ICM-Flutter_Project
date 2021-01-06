import 'dart:io';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              Image(image: AssetImage(_img.path)),
              TextField(),
              Align(alignment: Alignment.centerRight,child:RaisedButton(
                onPressed: () {
                    log("it's all coming together");
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