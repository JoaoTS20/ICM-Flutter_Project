import 'package:flutter/material.dart';
import 'package:passadicos_spot/Classes/sign_in.dart';
import 'package:passadicos_spot/Screens/feed_screen.dart';
import 'package:passadicos_spot/Screens/mapa_screen.dart';
import 'package:passadicos_spot/Screens/profile_screen.dart';
import 'package:provider/provider.dart';

final List<String> typeUser= ['Normal','Perito'];


class NavigationScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<BottomNavigationBarProvider>(
        child: BottomNavigationBarExample(),
        create: (BuildContext context) => BottomNavigationBarProvider(), 
      ),
    );
  }
  
}

class BottomNavigationBarExample extends StatefulWidget {
  @override
  _BottomNavigationBarExampleState createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  var currentTab = [
    MapaScreen(),
    FeedScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      body: currentTab[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.currentIndex = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.add_location),
            title: new Text('Mapa'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.article),
            title: new Text('Feed'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
          )
        ],
      ),
    );
  }
}


class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

showSingleChoiceDialog(BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      var _singleNotifier = Provider.of<SingleNotifier>(context);
      return AlertDialog(
          title: Text("Select one country"),
          content: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: typeUser
                    .map((e) => RadioListTile(
                  title: Text(e),
                  value: e,
                  groupValue: _singleNotifier.currentUser,
                  selected: _singleNotifier.currentUser == e,
                  onChanged: (value) {
                    if (value != _singleNotifier.currentUser) {
                      _singleNotifier.updateUser(value);
                      Navigator.of(context).pop();
                    }
                  },
                ))
                    .toList(),
              ),
            ),
          ));
    });
class SingleNotifier extends ChangeNotifier {
  String _typeuser = typeUser[0];
  SingleNotifier();
  String get currentUser => _typeuser;
  updateUser(String value) {
    if (value != _typeuser) {
      _typeuser = value;
      notifyListeners();
    }
  }
}