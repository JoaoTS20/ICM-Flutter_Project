import 'package:cloud_firestore/cloud_firestore.dart';

class Imagem{
  String description;
  String especialista;
  String photoURL;
  String username;
  List<String> animaisIdentificados;
  GeoPoint location;
  DateTime date;
  Timestamp dateJson;
  DocumentReference reference;

  Imagem(String desc, String esp, String purl, String user, List<String> an, GeoPoint location, Timestamp date){
    this.description = desc;
    this.especialista = esp;
    this.photoURL = purl;
    this.username = user;
    this.animaisIdentificados = an;
    this.location = location;
    this.dateJson = date;
  }


  Map<String, dynamic> toJson() {
    return {
      "description":description,
      "especialista":especialista,
      "photoURL":photoURL,
      "username": username,
      "animaisIdentificados":animaisIdentificados,
      "location":location,
      "date":dateJson
    };
  }


  Imagem.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['description'] != null),
        assert(map['especialista'] != null),
        assert(map['photoURL'] != null),
        assert(map['username'] != null),
        assert(map['animaisIdentificados'] != null),
        assert(map['location'] != null),
        assert(map['date'] != null),
        description = map['description'],
        especialista = map['especialista'],
        photoURL = map['photoURL'],
        username = map['username'],
        animaisIdentificados = map['animaisIdentificados'].cast<String>(),
        location = map['location'],
        date = map['date'].toDate();


  Imagem.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Imagem{" +
                "id='" + reference.toString() + '\'' +
                ", Description='" + description + '\'' +
                ", Especialista='" + especialista + '\'' +
                ", PhotoURL='" + photoURL + '\'' +
                ", Username='" + username + '\'' +
                ", AnimaisIdentificados=" + animaisIdentificados.toString() +
                ", Location=" + "/"+location.latitude.toString()+ ","+ location.longitude.toString() +"/"+
                ", Date=" + date.toString() +
                '}\n';


}