import 'dart:ffi';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:passadicos_spot/Classes/Imagem.dart';
import 'package:passadicos_spot/Screens/info_screen.dart';

class FeedScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: FeedPage()
    );
  }
}
class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() {
    return _FeedPageState();
  }
}

class _FeedPageState extends State<FeedPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
        floatingActionButton:FloatingActionButton(
          heroTag: "f1",
          onPressed: () {},
          tooltip: 'Mostrar Aqueles sem identificação dos Animais',
          child: Icon(Icons.remove),
        )
    );
  }
  Widget _buildBody(BuildContext context) {
    // TODO: get actual snapshot from Cloud Firestore
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Imagens').snapshots(), //Talvez passar para Variável global
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }
  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final imagem = Imagem.fromSnapshot(data);
    return FutureBuilder<dynamic>(
      future: getImage(imagem.photoURL), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  // AsyncSnapshot<Your object type>
        if( snapshot.connectionState == ConnectionState.waiting){
          return  Container(margin:EdgeInsets.all(8.0), child: LinearProgressIndicator());
        }else{
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return    Container(
              margin:EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                child: InkWell(
                  onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => InfoScreen(imagem))),//print("ciao"), Função Para Depois ver a página mais em Detalhe.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        child: Image.network(
                            snapshot.data,
                            // width: 300,
                            height: 250,
                            fit:BoxFit.fill

                        ),
                      ),
                      ListTile(
                        title: Text(imagem.username),
                        subtitle: Text(imagem.description),
                      ),
                    ],
                  ),
                ),
              ),
            ); //:- get your object which is pass from your downloadData() function
        }
      },
    );

    //print("isto");
    //print(urlImage);
    //StorageReference _ref =   _storage.getReferenceFromUrl(l) as StorageReference;
    //Image.network(_ref.getDownloadURL().toString());
    //return new Text(imagem.toString());
    /*return Padding(
      key: ValueKey(imagem.username),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(imagem.toString()),
          trailing: Text(imagem.toString()),
          onTap: () => print(imagem),
        ),
      ),
    );*/
  }

}
//Obter link para imagens Storage
Future<dynamic> getImage(String l) async {
  FirebaseStorage _storage = FirebaseStorage.instance;
  StorageReference _ref =  await _storage.getReferenceFromUrl(l);
  return _ref.getDownloadURL();

}



