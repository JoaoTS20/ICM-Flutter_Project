import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:passadicos_spot/Classes/Imagem.dart';
import 'package:intl/intl.dart';
import 'package:passadicos_spot/Classes/sign_in.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'navigation_screen.dart';

final f = new DateFormat('yyyy-MM-dd hh:mm');
class InfoScreen extends StatefulWidget {
  Imagem imagem;
  

  InfoScreen(Imagem imagem){
    this.imagem=imagem;
  }
  @override
  _InfoScreenState createState() => _InfoScreenState(imagem);
}

class _InfoScreenState extends State<InfoScreen> {
  Imagem _imagem;
  bool editable = false;
  bool editing = false;
  Imagem _imagem_nova;
  final myController = TextEditingController();

  _InfoScreenState(Imagem f){
    _imagem = f;
    log(tipo_user+" "+username);
    if ((_imagem.especialista == "" && tipo_user == "Perito") || _imagem.especialista == username){
      editable = true;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: getImage(_imagem.photoURL), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  // AsyncSnapshot<Your object type>
        if( snapshot.connectionState == ConnectionState.waiting){
          return  Container(margin:EdgeInsets.all(8.0), child: LinearProgressIndicator());
        }else{
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            if (editing){
              return Scaffold(
                  resizeToAvoidBottomPadding: false,
                  appBar: AppBar(//TODO: TALVEZ FAZER UM BACK MANUAL PARA O NAVIGATION _SCREEN DESTE MODO NÃO TEMOS PROBLEMA
                    automaticallyImplyLeading: true,
                  ),
                  body:Container(
                    margin:EdgeInsets.all(10.0),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: InkWell(
                        // onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => InfoScreen(_imagem))),//print("ciao"), Função Para Depois ver a página mais em Detalhe.
                        child: ListView(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
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
                            Card(
                              child: ListTile(title: Text("Autor"),subtitle: Text(_imagem_nova.username)),
                            ),
                            Card(
                              child: ListTile(title: Text("Data") ,subtitle: Text(f.format(_imagem_nova.date))),
                            ),
                            Card(
                              child: ListTile(title: Text("Descrição") ,subtitle: Text(_imagem_nova.description)),
                            ),
                            Card(
                              child: ListTile(title: Text("Perito") ,subtitle: Text(_imagem_nova.especialista)),
                            ),
                            Row(
                              children: [

                                Card(child:Container(width: 150 ,child:ListTile(title: Text("Animais Identificados") ,subtitle: Text(_imagem_nova.animaisIdentificados.toString())),),
                                ),
                                Row(
                                  children: [
                                    Container(width: 125,child:TextField(controller: myController,)),
                                    Align(alignment: Alignment.centerRight,child:RaisedButton(
                                      onPressed: () {
                                        _imagem_nova.animaisIdentificados.add(myController.text);
                                        myController.text = "";
                                        setState(() {
                                        });
                                      },
                                      color: Colors.lightBlue,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          '+',
                                          style: TextStyle(fontSize: 10, color: Colors.white),
                                        ),
                                      ),
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30)),
                                    )
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children:[
                                Align(alignment: Alignment.centerRight,child:RaisedButton(
                                  onPressed: () {
                                    if (listEquals(_imagem_nova.animaisIdentificados,_imagem.animaisIdentificados)){
                                      log("são iguais");
                                      return;
                                    }
                                    else{
                                      log("não são iguais");
                                      uploadAnimals();
                                    }
                                  },
                                  color: Colors.lightBlue,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      'Confirm',
                                      style: TextStyle(fontSize: 10, color: Colors.white),
                                    ),
                                  ),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                )
                                ),
                                Align(alignment: Alignment.centerRight,child:RaisedButton(
                                  onPressed: () {
                                    editing = false;
                                    myController.text="";
                                    setState(() {
                                    });
                                  },
                                  color: Colors.lightBlue,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(fontSize: 10, color: Colors.white),
                                    ),
                                  ),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                )
                                )
                              ]
                            )
                          ],
                        ),
                      ),
                    ),
                  )); //:-
            }
            else{
              return Scaffold(
                resizeToAvoidBottomPadding: false,
                    appBar: AppBar(
                    automaticallyImplyLeading: true,
                    ),
                     body:Container(
                        margin:EdgeInsets.all(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                          child: InkWell(
                           // onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => InfoScreen(_imagem))),//print("ciao"), Função Para Depois ver a página mais em Detalhe.
                            child: ListView(
                              //crossAxisAlignment: CrossAxisAlignment.stretch,  // add this
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
                                Card(
                                  child: ListTile(title: Text("Autor"),subtitle: Text(_imagem.username),),
                                ),
                                Card(
                                  child: ListTile(title: Text("Data") ,subtitle: Text(f.format(_imagem.date))),
                                ),
                                Card(
                                  child: ListTile(title: Text("Descrição") ,subtitle: Text(_imagem.description)),
                                ),
                                Card(
                                  child: ListTile(title: Text("Perito") ,subtitle: Text(_imagem.especialista)),
                                ),
                                Card(
                                  child: ListTile(title: Text("Animais Identificados") ,subtitle: Text(_imagem.animaisIdentificados.toString())),
                                ),
                                getQrCode(),
                                getEditButton()
                              ],
                            ),
                          ),
                        ),
                      )); //:- get your object which is pass from your downloadData() function
                }
              }
      },
    );
  }
  Future uploadAnimals(){
    log(_imagem.reference.id+" "+_imagem.reference.path+" "+_imagem.reference.documentID);
    Firestore.instance.collection("Imagens").doc(_imagem.reference.id).update({
      "especialista":_imagem_nova.especialista,
      "animaisIdentificados": _imagem_nova.animaisIdentificados
    });

    _imagem.especialista = _imagem_nova.especialista;
    _imagem.animaisIdentificados = _imagem_nova.animaisIdentificados;

    editing = false;
    setState(() {
    });
  }


 Widget getQrCode(){
   return Center( child: QrImage(
     data: _imagem.reference.id,
     version: QrVersions.auto,
     size: 200.0,
   ));
 }


  Widget getEditButton(){
    if (editable){
      return Align(alignment: Alignment.centerRight,child:RaisedButton(
        onPressed: () {
          editing = true;
          _imagem_nova = new Imagem(_imagem.description, username,_imagem.photoURL,_imagem.username, List.from(_imagem.animaisIdentificados),_imagem.location, _imagem.dateJson);
          _imagem_nova.date = _imagem.date;
          log(_imagem.toString()+_imagem_nova.toString());
          setState(() {
          });
        },
        color: Colors.lightBlue,
        child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Text(
        'Edit',
        style: TextStyle(fontSize: 10, color: Colors.white),
        ),
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)),
        )
      );
    }
    else{
      log("deu este");
      return Container();
    }
  }

}




Future<dynamic> getImage(String l) async {
  FirebaseStorage _storage = FirebaseStorage.instance;
  StorageReference _ref =  await _storage.getReferenceFromUrl(l);
  return _ref.getDownloadURL();
  }