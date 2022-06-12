import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'dart:async';

import 'package:flutter/material.dart';

class Hari extends StatefulWidget {
  Hari({Key? key}) : super(key: key);

  @override
  State<Hari> createState() => _HariState();
}

class _HariState extends State<Hari> {
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
      
    );
  }
}

/*



import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



class Hak extends StatefulWidget {
  Hak({Key? key}) : super(key: key);

  @override
  State<Hak> createState() => _HakState();
}

class _HakState extends State<Hak> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hakkimizda"),
        backgroundColor: Colors.red,
        ),
       
        
        
        
        
        
        );
  }
}





body: new Container(
        margin: EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Text(descText,
                    maxLines: descTextShowFlag ? 13 : 2,
                    textAlign: TextAlign.start)),
            Expanded(
                child: InkWell(
              onTap: () {
                setState(() {
                  descTextShowFlag = !descTextShowFlag;
                });
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    descTextShowFlag
                        ? Text(
                            "Show Less",
                            style: TextStyle(color: Colors.red),
                          )
                        : Text("Show More",
                            style: TextStyle(color: Colors.red)),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 200,
                      width: 200,
                    )
                  ]),
            ))
          ],
        ),
      ),
    );
  }
}



height: 140,
width: MediaQuery.of(context).size.width,









 getIcons();


  late BitmapDescriptor icon;
  getIcons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 3.2),
        "assets/images/logo.png");
    setState(() {
      this.icon = icon;
    });
  }

*/ 