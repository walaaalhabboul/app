/*import 'dart:async';
import 'dart:convert';
import 'package:flutter/painting.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:label_marker/label_marker.dart';
//import 'package:nemerg/add.dart' as wa;

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
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.057893, 28.855637),
    zoom: 14.4746,
  );

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
    }
    print(services);

    print(per);
    return per;
  

  
  var url1;
  var res;
  var j;
  var k;
  var l;

  List posts = [];
  Future getPost() async {
    url1 = Uri.parse('http://10.0.2.2/myproject/db.php');

    res = await http.get(url1);
    var r = jsonDecode(res.body);
    //Posts.addAll();
    setState(() {
      posts.addAll(r);
    });

    print(r);
    return r;
  }


   SetMarker() async {
     
    mymarker.add(Marker(
        markerId: MarkerId('istanbul tip'),
        draggable: true,
         position: LatLng(41.062398, 28.854964),
        icon: await BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, 'assets/images/logo.png')));
            
          mymarker.add(Marker(
        markerId: MarkerId('d'),
        position: LatLng(41.062398, 28.854964),
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure))) ;     
            
            
            
  }  

  @override
  void initstate() {
   // getPosition();
    getPost();

    // SetMarker();
    super.initState();
  }


  Set<Marker> mymarker = {
    Marker(
        markerId: MarkerId('df'),
        position: LatLng(41.057893, 28.855637),
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
    Marker(
        markerId: MarkerId('d'),
        infoWindow: InfoWindow(title: "bekleme suresi  dk"),
        position: LatLng(41.062398, 28.854964),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)),
    Marker(
        markerId: MarkerId('d'),
        position: LatLng(41.055940, 28.869133),
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)),
    Marker(
        markerId: MarkerId('d'),
        position: LatLng(41.048657, 28.859722),
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Harita "),
        backgroundColor: Colors.red,
      ),
      body: posts == null || posts.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: 1,
                itemBuilder: ((context, index) {
                  for (int x = 0; x < posts.length; x++) {
                    if (x == 0) j = Text('${posts[x]['p_num']}');
                    if (x == 1) {
                      k = Text('${posts[x]['p_num']}');
                    }
                    if (x == 2) {
                      l = Text('${posts[x]['p_num']}');
                    }
                  }

                  return k;
                })));
      
      
      
      


      Column(children: [ 
        // ignore: unnecessary_null_comparison
      _kGooglePlex == null
            ? CircularProgressIndicator()
            : Container(
                child: GoogleMap(
                  markers: mymarker,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                height: 500,
                width: 400,
            ),
      
       Container(child: Text('gh')),]
                
                )
      );
    
  }
  }
  */