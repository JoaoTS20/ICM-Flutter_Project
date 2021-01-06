import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final tipo;
  final username;
  final DocumentReference reference;

  Users.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['tipo'] != null),
        assert(map['username'] != null),
        username = map['username'],
        tipo = map['tipo'];

  Users.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

 @override
 String toString() => "User<$username:$tipo>";
}
