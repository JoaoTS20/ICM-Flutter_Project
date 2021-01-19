import 'dart:collection';
import 'dart:io';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:passadicos_spot/Classes/Imagem.dart';
import 'package:passadicos_spot/Classes/RouteInfo.dart';
import 'package:passadicos_spot/Screens/preview_screen.dart';
import 'package:passadicos_spot/Screens/qrcodereader_screen.dart';
import 'package:passadicos_spot/Widgets/MapPin.dart';
import 'navigation_screen.dart';



class MapaScreen extends StatefulWidget {
  @override
  _MapaWidgetState createState() => _MapaWidgetState();

 

}
enum Sentidos { FIRST, SECOND}
class _MapaWidgetState extends State<MapaScreen>{
  GoogleMapController mapController;
  bool percorrer=false;
  int distancia=0;
  String sentido;
  Set<Marker> markerlist = new HashSet();
  Geolocator geolocator;
  Imagem _imagem_atual = null;
  
  int marker_id = 0;
  final LatLng _center = const LatLng(40.9932033,-8.2113233);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> _setMarkers(){
    markerlist = new HashSet();
    FirebaseFirestore.instance.collection('Imagens').get().then((value) => initializeMarkers(value.docs));
    final String markerIdVal = 'marker_id$marker_id';
    Marker marker = new Marker(
        markerId: MarkerId(markerIdVal),
        position: const LatLng(40.9932033,-8.2113233)
    );
    markerlist.add(marker);
    marker_id++;
    return markerlist;
  }

  void initializeMarkers(List<QueryDocumentSnapshot> docs){
    for(var doc in docs){
      final Imagem i = Imagem.fromSnapshot(doc);
      GeoPoint loc =  i.location;
      final String markerIdVal = 'marker_id$marker_id';
      double lat = loc.latitude;
      double lon = loc.longitude;
      Marker marker = new Marker(
          markerId: MarkerId(markerIdVal),
          position: LatLng(lat,lon),
          onTap:(){
            setState(() {
              _imagem_atual = i;
            });
      },
      );
      markerlist.add(marker);
      marker_id++;
    }
    log("acabei");
    setState((){});
  }

  Set<Polyline> _setPolylines(){
    Set<Polyline> polylinelist = new HashSet();
    final String markerIdVal = 'Polyline_id$marker_id';
    Polyline polyline = new Polyline(
        polylineId: PolylineId(markerIdVal),
        points: RouteInfo.routePoints,
    );
    polylinelist.add(polyline);
    return polylinelist;
  }
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );
    return image;
  }


  @override
  void initState() {
    _setMarkers();
    geolocator = Geolocator()..forceAndroidLocationManager;
  }

  @override
  Widget build(BuildContext context) {
    //_setMarkers();
    log(markerlist.toString());
    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[ 
        
        GoogleMap(

        onMapCreated: _onMapCreated,
          myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
    ),
            markers: markerlist,
            polylines: _setPolylines(),
      ),
        /*floatingActionButton: Align(
          child: FloatingActionButton(
        onPressed: (null),
        tooltip: 'Add_Image',
        child: Icon(Icons.add))
        ,alignment: Alignment.bottomLeft 
      ),
      *///floatingActionButtonLocation:
              //FloatingActionButtonLocation.startDocked,
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: "f1",
                  onPressed: (){ !percorrer ? showDialog( 
                context: context, 
                builder: (ctx) => AlertDialog( 
                  title: Text("Qual o Sentido do Percurso?"), 
                  //content: Text("You have raised a Alert Dialog Box"), 
                  actions: <Widget>[ 
                  SimpleDialogOption(
                  child: Text('Areinho -> Espiunca'),
                  onPressed: () {
                  sentido='Areinho -> Espiunca';
                  //percorrer=true;
                  _percorrerBotton();
                Navigator.of(ctx).pop();
              },
            ),
                  SimpleDialogOption(
                    child: Text('Espiunca -> Areinho'),
                    onPressed: () {
                      sentido='Espiunca -> Areinho';
                      //percorrer=true;
                      _percorrerBotton();
                      Navigator.of(ctx).pop();
                    },
                  )
                  ], 
                ), 
              ) : _percorrerBotton();}, //percorrer ? _percorrerBotton : _selectSentido,
                  tooltip: 'Calcular tempo',
                  child: Icon(Icons.directions_walk),
                ),
                FloatingActionButton(
                  heroTag: "f2",
                  onPressed: () {
                   // Navigator.push(context,MaterialPageRoute(builder: (context) => CameraScreen()));
                    _imgFromCamera().then(
                            (image) => {
                              if(image!=null)
                              Navigator.push(context,MaterialPageRoute(builder: (context) => PreviewScreen(image)))
                            }
                    );
                  },
                  tooltip: 'Add_Image',
                  child: Icon(Icons.add),
                ),
                FloatingActionButton(
                  heroTag: "f3",
                  onPressed: () {
                    //Navigator.push(context,MaterialPageRoute(builder: (context) => QRReaderView()));
                    Navigator.push(context,MaterialPageRoute(builder: (context) => QRReaderView()));

                  },
                  tooltip: 'Add_Image',
                  child: Icon(Icons.add),
                ),

              ],
            ),
          ),
        Visibility(
        visible: (percorrer? true: false),
        child: Positioned(
        top: 60,
        left: 20,
        child: Text("Faltam cerca de x minutos\nPara Completar o Percurso",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 ), )
        )
      ),

            MapPin(imageInfo: _imagem_atual,)]
      )
    )
    );
  }

void _percorrerBotton() {
  setState(() {
    if (!percorrer) {
      percorrer = true;
    } else {
      percorrer = false;
    }
  });
}

  Future<Widget> build_text_percorrer() async{
    //TODO: aqui fazeres os teus cálculos bonitos
    Position userLocation = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return Text("Faltam cerca de x minutos\nPara Completar o Percurso",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18 ), );
  }
}
