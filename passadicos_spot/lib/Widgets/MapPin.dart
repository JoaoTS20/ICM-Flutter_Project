import 'dart:developer';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 50, height: 50,
                margin: EdgeInsets.only(left: 10),
                //child: ClipOval(child: Image.asset(widget.currentlySelectedPin.avatarPath, fit: BoxFit.cover )),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Text(widget.currentlySelectedPin.locationName, style: TextStyle(color: widget.currentlySelectedPin.labelColor)),
                      //Text('Latitude: ${widget.currentlySelectedPin.location.latitude.toString()}', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      //Text('Longitude: ${widget.currentlySelectedPin.location.longitude.toString()}', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
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