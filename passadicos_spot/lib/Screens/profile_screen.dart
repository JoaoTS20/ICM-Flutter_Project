import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:passadicos_spot/Classes/Imagem.dart';
import 'package:passadicos_spot/Classes/sign_in.dart';
import 'package:passadicos_spot/Screens/sign_in_screen.dart';
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: <Widget>[
          Image(
            width: double.infinity,
            height: MediaQuery.of(context).size.height/4,
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/passadico_do_paiva_fundo.jpg'
            ),
          ),
          Positioned(bottom:-60.0,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(imageUrl),
              ),
          ),
        ],
      ),
      Container(

      child:Align(alignment: Alignment.centerRight,child:RaisedButton(
        onPressed: () {
          signOutGoogle();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return SignInScreen();}), ModalRoute.withName('/'));
        },
        color: Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            'Sign Out',
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)),
          )
        )
      ),
      SizedBox(height: 15
      ),
      ListTile(
        title: Center(child:Text(username)),
        subtitle:Center(child: Text(tipo_user),)
        ),
      Card(
        child: ListTile(
          title: Text("Os seus Posts:"),
        ),
      ),
      Expanded(child: FeedPart())
    ]);
  }
}
class FeedPart extends StatefulWidget {
@override
_FeedPageState createState() {
  return _FeedPageState();
}
}

class _FeedPageState extends State<FeedPart>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }
  Widget _buildBody(BuildContext context) {
    // TODO: get actual snapshot from Cloud Firestore
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Imagens').where('username', isEqualTo: username).snapshots(), //Talvez passar para Variável global
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );

  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      shrinkWrap: true,
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
                  onTap: () => print("ciao"), //Função Para Depois ver a página mais em Detalhe.
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