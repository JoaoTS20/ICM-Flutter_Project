import 'package:cloud_firestore/cloud_firestore.dart';

class User {
 final String tipo;
 final int username;
 final DocumentReference reference;

 User.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['tipo'] != null),
       assert(map['username'] != null),
       tipo = map['tipo'],
       username = map['username'];

 User.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data(), reference: snapshot.reference);

 @override
 String toString() => "User<$username:$tipo>";
}
