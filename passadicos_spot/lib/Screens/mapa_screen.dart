import 'dart:collection';
import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:passadicos_spot/Classes/RouteInfo.dart';
import 'package:passadicos_spot/Screens/preview_screen.dart';



class MapaScreen extends StatelessWidget {
  GoogleMapController mapController;
  int marker_id = 0;
  final LatLng _center = const LatLng(40.9932033,-8.2113233);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> _setMarkers(){
    Set<Marker> markerlist = new HashSet();
    final String markerIdVal = 'marker_id$marker_id';
    Marker marker = new Marker(
        markerId: MarkerId(markerIdVal),
        position: const LatLng(40.9932033,-8.2113233)
    );
    markerlist.add(marker);
    return markerlist;
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
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 11.0,
    ),
            markers: _setMarkers(),
            polylines: _setPolylines(),
      ),
        /*floatingActionButton: Align(
          child: FloatingActionButton(
        onPressed: (null),
        tooltip: 'Add_Image',
        child: Icon(Icons.add))
        ,alignment: Alignment.bottomLeft 
      ),
      */floatingActionButtonLocation:
              FloatingActionButtonLocation.startDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: "f1",
                  onPressed: () {},
                  tooltip: 'Calcular tempo',
                  child: Icon(Icons.directions_walk),
                ),
                FloatingActionButton(
                  heroTag: "f2",
                  onPressed: () {
                   // Navigator.push(context,MaterialPageRoute(builder: (context) => CameraScreen()));
                    _imgFromCamera().then(
                            (image) => {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => PreviewScreen(image)))
                            }
                    );
                  },
                  tooltip: 'Add_Image',
                  child: Icon(Icons.add),
                )
              ],
            ),
          ))
    );
  }
}