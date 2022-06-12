import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:clippy_flutter/triangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
export 'package:nemerg/add.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:nemerg/models/locations.dart';

import 'models/distance.dart';

class Add extends StatefulWidget {
  Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  var url1;
  var res;

  List<Hastane> MyData = [];
  //----------------------------------------------------------------------------------
  Future getPost() async {
    url1 = Uri.parse('https://0ffb-85-108-196-225.eu.ngrok.io/myproject/db.php');

    res = await http.get(url1);
    var r = jsonDecode(res.body);

    var response = json.decode(res.body);
    List<dynamic> hastaneler = response;
    hastaneler.forEach((e) {
      MyData.add(Hastane.fromJson(e));
    });

    print(r);
    return r;
  }

  CameraPosition? _kGooglePlex;

//-------------------------------------------------------------
  Future getMyPosition() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
    }
    print(services);
    var xy = await Geolocator.getCurrentPosition();
    myposition = LatLng(xy.latitude, xy.longitude);
  }

  Set<Marker> mymarker = {};
  bool isLoaded = false;
  var myposition = LatLng(0, 0);

  Future<void> getData() async {
    setState(() {
      isLoaded = false;
    });

    await getPost();

    // await getPosition();
    mymarker = [
      ...MyData.map((e) {
        var lat = double.parse(e.position.split(',')[0]);
        var lng = double.parse(e.position.split(',')[1]);
        return Marker(
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      e.U_NAME,
                                      maxLines: 4,
                                      softWrap: true,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      "Waiting Time: ${e.waitingtime}",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ],
                ),
                LatLng(lat, lng),
              );
            },
            markerId: MarkerId(e.U_NAME),
            position: LatLng(lat, lng),
            draggable: true,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
      })
    ].toSet();

    await getMyPosition();
    _kGooglePlex = CameraPosition(
      target: LatLng(myposition.latitude, myposition.longitude),
      zoom: 14.4746,
    );
    var closestPoint = await calculateDistance();
    await DrawPoly(myposition, mymarker.toList()[closestPoint.index].position);
    var sss = await getRouteCoordinates(myposition, mymarker.toList()[closestPoint.index].position);
    print(sss);
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

//-------------------------------------------------------------
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyDWGDJGxSAUvwWVDMKgdcfiKuzqXDoJSZU";
  Map<PolylineId, Polyline> polylines = {};
  Future DrawPoly(LatLng startLocation, LatLng endLocation) async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }

    addPolyLine(polylineCoordinates);
  }

//-------------------------------------------------------------
  DistanceInfo calculateDistance() {
    List<DistanceInfo> sssss = [];
    for (var i = 0; i < mymarker.length; i++) {
      var e = mymarker.toList()[i];
      var lat2 = e.position.latitude;
      var lon2 = e.position.longitude;
      var lat1 = myposition.latitude;
      var lon1 = myposition.longitude;
      var p = 0.017453292519943295;
      var a = 0.5 - cos((lat2 - lat1) * p) / 2 + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
      var result = 12742 * asin(sqrt(a));
      sssss.add(DistanceInfo(index: i, distance: result));
    }

    sssss.sort((a, b) => a.distance.compareTo(b.distance));
    print("sdsdsdssd" + sssss.first.index.toString());
    return sssss.first;
  }

//-------------------------------------------------------------
  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  //-------------------------------------------------------------
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&mode=driving&key=$googleAPiKey";
    http.Response response = await http.get(Uri.parse(url));
    Map values = jsonDecode(response.body);
    print("====================>>>>>>>>${values}");
    var ssss = values["routes"][0]["legs"][0]["duration"]["text"];
    print(ssss);
    return ssss;
  }

  //-------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Harita "),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          !isLoaded
              ? CircularProgressIndicator()
              : Expanded(
                  child: Container(
                    child: Stack(
                      children: [
                        GoogleMap(
                          polylines: Set<Polyline>.of(polylines.values),
                          myLocationEnabled: true,
                          markers: mymarker,
                          initialCameraPosition: _kGooglePlex!,
                          onTap: (position) {
                            _customInfoWindowController.hideInfoWindow!();
                          },
                          onCameraMove: (position) {
                            _customInfoWindowController.onCameraMove!();
                          },
                          onMapCreated: (GoogleMapController controller) async {
                            _customInfoWindowController.googleMapController = controller;
                          },
                        ),
                        CustomInfoWindow(
                          controller: _customInfoWindowController,
                          height: 75,
                          width: 150,
                          offset: 50,
                        ),
                      ],
                    ),
                    height: 500,
                    width: 400,
                  ),
                ),
        ],
      ),
    );
  }
}
