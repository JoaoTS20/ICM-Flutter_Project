import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:passadicos_spot/Classes/Users.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String username;
String email;
String imageUrl;
User userlogged;

String tipo_user;
bool reg;

Future<String> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final UserCredential authResult =
  await _auth.signInWithCredential(credential);
  final User user = authResult.user;
  log(user.toString());
  if (user != null) {
    // Checking if email and name is null
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    log(user.displayName);
    username = user.displayName;
    email = user.email;
    imageUrl = user.photoURL;
    userlogged=user;

    //Verificar se o User já existe
    await Firestore.instance.collection('Users').where('username',isEqualTo: username).getDocuments()
    .then((value){
      if(value.documents.length > 0){
        print("User Registado!");
        final xs= Users.fromSnapshot(value.documents.first);
        tipo_user=xs.tipo;
        reg=true;
      }
      else{
        print("User ainda não registado!");
        reg=false;
      }

    });
    print(tipo_user);

    if(tipo_user!=null){
      reg=true;
    }
    else{
      reg=false;
    }
    //
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('signInWithGoogle succeeded: $user');

    return '$user';
  }

  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}