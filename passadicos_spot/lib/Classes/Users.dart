import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String _tipo;
  String _username;

  set tipo (String tipo){
    _tipo = tipo;
  }
    set username (String user){
    _username = user;
  }

 @override
 String toString() => "User<$_username:$_tipo>";
}
