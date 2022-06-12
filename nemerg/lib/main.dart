// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:nemerg/Geribildirme.dart';
import 'package:http/http.dart' as http;
import 'package:nemerg/add.dart';
import 'package:nemerg/devle.dart';
import 'package:nemerg/devlethastane.dart';
import 'package:nemerg/haritas.dart';
import 'package:nemerg/test.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:nemerg/main.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyStatefulWidget());
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String StateUrl = 'View App';
  String url = 'https://www.istanbulhastaneleri.net/devlet-hastaneleri.html';
  String url1 = 'https://www.istanbulhastaneleri.net/ozel-hastaneler.html';
  String url2 = 'https://www.sondakika.com/saglik';
  String url3 =
      'https://play.google.com/store/apps/details?id=tr.gov.turkiye.edevlet.kapisi';
  String url4 =
      'https://play.google.com/store/apps/details?id=tr.gov.saglik.enabiz';
  int _selebectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Ana Sayfa',
      style: optionStyle,
    ),
    Text(
      'Index 1: Geri bildirim',
      style: optionStyle,
    ),
    Text(
      'Index 2:Geri bildirim',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selebectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ACIL SERVIS"),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.access_time),
            onPressed: () {},
          )
        ],
        centerTitle: true,
      ),
      drawer: Drawer(
          child: ListView(children: [
        DrawerHeader(
          child: Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.png',
                    height: 70,
                    width: 100,
                  ),
                  Text('Acil Servis')
                ],
              )),
        ),
        ElevatedButton.icon(
          icon: Icon(
            Icons.home,
            color: Colors.red,
            size: 24.0,
          ),
          label: Text('Ana Sayfa', style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Hrii();
            }));
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            side: BorderSide(color: Color.fromRGBO(204, 74, 64, 1), width: 2),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
          ),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.health_and_safety,
              color: Colors.red, size: 24.0),
          label: Text("Hakkimizda", style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Hak();
            }));
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            side: BorderSide(color: Color.fromARGB(255, 238, 99, 89), width: 2),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
          ),
        ),
        ElevatedButton.icon(
          icon: const Icon(
            Icons.web_asset_off_sharp,
            color: Colors.red,
            size: 24.0,
          ),
          label: Text("e-Devlet ", style: TextStyle(color: Colors.black)),
          onPressed: () async {
            try {
              if (await canLaunch(url3)) await launch(url3);
            } catch (e) {
              setState(() {
                StateUrl = e.toString();
              });
              throw e;
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            side: BorderSide(color: Color.fromARGB(255, 238, 99, 89), width: 2),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
          ),
        ),
        ElevatedButton.icon(
          icon: const Icon(
            Icons.heart_broken_rounded,
            color: Colors.red,
            size: 24.0,
          ),
          label: Text("e-Nabiz", style: TextStyle(color: Colors.black)),
          onPressed: () async {
            try {
              if (await canLaunch(url4)) await launch(url4);
            } catch (e) {
              setState(() {
                StateUrl = e.toString();
              });
              throw e;
            }
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            side: BorderSide(color: Color.fromARGB(255, 238, 99, 89), width: 2),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
          ),
        ),
      ])),
      // ignore: prefer_const_constructors

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selebectedIndex,
        onTap: (index) {
          setState(() {
            _selebectedIndex = index;
          });
        },
        selectedItemColor: Colors.red,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Geri bildirim',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Acil',
            backgroundColor: Colors.pink,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 350,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red,
            ),
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.location_on_outlined,
                color: Colors.red,
                size: 50.0,
              ),
              label: Text('Haritada Acil Arama ',
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Add();
                }));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                side: BorderSide(color: Colors.red, width: 2),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Container(
              height: 110,
              width: double.maxFinite,
              margin: const EdgeInsets.only(left: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 50),
                    width: 170,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.newspaper,
                        color: Colors.red,
                        size: 50.0,
                      ),
                      label: Text('Haberler',
                          style: TextStyle(color: Colors.black)),
                      onPressed: () async {
                        try {
                          if (await canLaunch(url2)) await launch(url2);
                        } catch (e) {
                          setState(() {
                            StateUrl = e.toString();
                          });
                          throw e;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(color: Colors.red, width: 2),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 50),
                    width: 170,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.health_and_safety,
                        color: Colors.red,
                        size: 50.0,
                      ),
                      label: Text('Özel Hastanler',
                          style: TextStyle(color: Colors.black)),
                      onPressed: () async {
                        try {
                          if (await canLaunch(url1)) await launch(url1);
                        } catch (e) {
                          setState(() {
                            StateUrl = e.toString();
                          });
                          throw e;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(color: Colors.red, width: 2),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 50),
                    width: 170,
                    height: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.health_and_safety,
                        color: Colors.red,
                        size: 50.0,
                      ),
                      label: Text('Devlet Hastanler',
                          style: TextStyle(color: Colors.black)),
                      onPressed: () async {
                        try {
                          if (await canLaunch(url)) await launch(url);
                        } catch (e) {
                          setState(() {
                            StateUrl = e.toString();
                          });
                          throw e;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(color: Colors.red, width: 2),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ]),
      ),
    );
  }
}

Launch(String url) {}








/* Container(
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(13)),
              child: Column(children: <Widget>[
                Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.emergency,
                        color: Colors.white, size: 24.0)),
                Text("Acil servis", style: TextStyle(color: Colors.white)),
                Spacer(),
              ]),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(13)),
              child: Column(children: <Widget>[
                Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.emergency)),
                Text("Acil servis", style: TextStyle(color: Colors.white)),
                Spacer(),
              ]),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(13)),
              child: Column(children: <Widget>[
                Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.emergency)),
                Text("Acil servis", style: TextStyle(color: Colors.white)),
                Spacer(),
              ]),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(13)),
              child: Column(children: <Widget>[
                Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.emergency)),
                Text("Acil servis", style: TextStyle(color: Colors.white)),
                Spacer(),
              ]),
            ),*.
  */