/*import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:label_marker/label_marker.dart';
import 'lib.dart';
import 'package:nemerg/Geribildirme.dart';

import 'package:nemerg/devle.dart';
import 'package:nemerg/devlethastane.dart';
import 'package:nemerg/haritas.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:nemerg/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
export 'package:nemerg/add.dart';
import 'package:custom_info_window/custom_info_window.dart';

class test extends StatefulWidget {
  test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  late Position cl;
  var lat;
  var lang;

  Future getPosition() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();

    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
      return getLat();
    }
    print(services);

    print(per);
    return per;
  }

  Future<Position> getlat() async {
    cl = await Geolocator.getCurrentPosition().then((value) => value);
  }

  @override
  void initState() {
  

    getPosition();
    getlet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: Hrii(),
    );
  }
}

class Hrii extends StatefulWidget {
  @override
  State<Hrii> createState() => HriiState();
}

class HriiState extends State<Hrii> {
  var lat;
  var lang;
  late Position cl;

  Completer<GoogleMapController> _controller = Completer();

  Future getPosition() async {
    bool services;
    LocationPermission per;

    services = await Geolocator.isLocationServiceEnabled();
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
    getLatAndlong();
    print(services);

    print(per);
    return per;
  }

  Future getLatAndlong() async {
    Position cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl.latitude;
    lang = cl.longitude;

    setState(() {});
  }

  @override
  void initstate() {
    getPosition();
    getLatAndlong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
      body: Column(children: [
        RaisedButton(onPressed: () async {
          print('lat ${cl.latitude}');
          print('lat ${cl.longitude}');

          List<Placemark> placemarks =
              await placemarkFromCoordinates(cl.latitude, cl.longitude);
          print(placemarks[0].country);
        })
      ]),
    );
  }
}
*/

import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: Hrii(),
    );
  }
}

class Hrii extends StatefulWidget {
  @override
  State<Hrii> createState() => HriiState();
}

class HriiState extends State<Hrii> {

  var lat;
  var lang;

  Future<Future> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

   
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
    
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
       
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }


    return getLatAndlong();
  }

  Future getLatAndlong() async {
     Position  cl = await Geolocator.getCurrentPosition().then((value) => value);
    lat = cl.latitude;
    lang = cl.longitude;
     print('lat ${lat}');
          print('lat ${lang}');


    setState(() {});
  }

  @override
  void initState() {
   
    getLatAndlong();
    _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
      body: Column(children: [
        RaisedButton(onPressed: () async {
         
          
        })
      ]),
    );
  }
}
