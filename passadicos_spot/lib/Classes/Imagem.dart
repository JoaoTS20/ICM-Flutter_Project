import 'package:cloud_firestore/cloud_firestore.dart';

class Imagem{
  final String description;
  final String especialista;
  final String photoURL;
  final String username;
  final List<String> animaisIdentificados;
  final GeoPoint location;
  final DateTime date;
  final DocumentReference reference;

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