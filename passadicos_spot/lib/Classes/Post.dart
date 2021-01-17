

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  String description;
  String especialista;
  String photoURL;
  String username;
  List<String> animaisIdentificados;
  GeoPoint location;
  Timestamp date;

  Post(String id, String desc, String esp, String purl, String user, List<String> an, GeoPoint location, Timestamp date){
    this.id = id;
    this.description = desc;
    this.especialista = esp;
    this.photoURL = purl;
    this.username = user;
    this.animaisIdentificados = an;
    this.location = location;
    this.date = date;
  }


  Map<String, dynamic> toJson() {
    return {
      "id":id,
      "description":description,
      "especialista":especialista,
      "photoURL":photoURL,
      "username": username,
      "animaisIdentificados":animaisIdentificados,
      "location":location,
      "date":date
    };
  }

  @override
  String toString() {
    return "id"+id+ "description"+description+
    "especialista"+especialista+
    "photoURL"+photoURL+
    "username"+ username+
    "animaisIdentificados"+animaisIdentificados.toString()+
    "location"+location.toString()+
    "date"+date.toString();
  }
}

