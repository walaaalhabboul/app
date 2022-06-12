import 'dart:convert';
import 'dart:async';
import 'package:clippy_flutter/triangle.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
export 'package:nemerg/add.dart';
import 'package:custom_info_window/custom_info_window.dart';

class Add extends StatefulWidget {
  Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  var url1;
  var res;
  var j;
  var k;
  var l;
  List posts = [];

  static var addInfoWindow;
  Future getPost() async {
    url1 = Uri.parse('http://10.0.2.2/myproject/db.php');

    res = await http.get(url1);
    var r = jsonDecode(res.body);
    print(res.body);
    //Posts.addAll();
    setState(() {
      posts.addAll(r);

      for (int x = 0; x < posts.length; x++) {
        if (x == 0) j = Text('${posts[x]['waitingtime']}');
        if (x == 1) {
          k = Text('${posts[x]['waitingtime']}');
        }
        if (x == 2) {
          l = Text('${posts[x]['waitingtime']}');
        }
      }
    });

    print(r);
    return r;
  }

  Future get() async {}
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
  }

  var tarif;
//late final CustomInfoWindowController controller;

  Set<Marker> mymarker = {};

  @override
  void initState() {
    getPost();
    getPosition();
    mymarker = {
      Marker(
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
                            Icon(
                              Icons.account_circle,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "I am here",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            )
                          ],
                        ),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Triangle.isosceles(
                    edge: Edge.BOTTOM,
                    child: Container(
                      color: Colors.blue,
                      width: 20.0,
                      height: 10.0,
                    ),
                  ),
                ],
              ),
              LatLng(41.057893, 28.855637),
            );
          },
          markerId: MarkerId('df'),
          position: LatLng(41.057893, 28.855637),
          draggable: true,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
      Marker(
          onTap: () {
            _customInfoWindowController.addInfoWindow!(
              Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_circle,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "I am here",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            )
                          ],
                        ),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Triangle.isosceles(
                    edge: Edge.BOTTOM,
                    child: Container(
                      color: Colors.blue,
                      width: 20.0,
                      height: 10.0,
                    ),
                  ),
                ],
              ),
              LatLng(41.062398, 28.854964),
            );
          },
          markerId: MarkerId('d'),
          position: LatLng(41.062398, 28.854964),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)),
      Marker(
          markerId: MarkerId('d'),
          position: LatLng(41.055940, 28.869133),
          draggable: true,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)),
      Marker(
          markerId: MarkerId('d'),
          position: LatLng(41.048657, 28.859722),
          draggable: true,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)),
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Harita "),
          backgroundColor: Colors.red,
        ),
        body: Column(children: [
          // ignore: unnecessary_null_comparison
          _kGooglePlex == null
              ? CircularProgressIndicator()
              : Container(
                  child: Stack(
                    children: [
                      GoogleMap(
                        markers: mymarker,
                        // onTap: (LatLng) {
                        //   mymarker.remove(Marker(markerId: MarkerId('df')));
                        //   mymarker.add(
                        //       Marker(markerId: MarkerId('df'), position: LatLng));
                        //   setState(() {});
                        // },
                        initialCameraPosition: _kGooglePlex,
                        // onMapCreated: (GoogleMapController controller) {
                        //   _controller.complete(controller);
                        // },
                        onTap: (position) {
                          _customInfoWindowController.hideInfoWindow!();
                        },
                        onCameraMove: (position) {
                          _customInfoWindowController.onCameraMove!();
                        },
                        onMapCreated: (GoogleMapController controller) async {
                          _customInfoWindowController.googleMapController =
                              controller;
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

          Container(child: Text('bekleme suresi $j')),
        ])

        // Text('$j')
        /*      
 posts == null || posts.isEmpty
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
                }
                )
                )

*/

        );
  }
}
