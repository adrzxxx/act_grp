import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:odds_social_media/screens/aboutus.dart';
import 'package:rxdart/rxdart.dart';
import 'package:location/location.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';

class Mapscreen extends StatelessWidget {
  const Mapscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        title: const Text('SOS'),
        backgroundColor: const Color(0xff1da1f2),
      ),
      body: FireMap(),
    );
  }
}

class FireMap extends StatefulWidget {
  const FireMap({Key? key}) : super(key: key);

  @override
  State<FireMap> createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {
  late GoogleMapController mapController;
  Location location = new Location();
  List<Marker> markers = [];

  final firestore = FirebaseFirestore.instance;
  Geoflutterfire geo = Geoflutterfire();

  // Stateful Data
  var radius = BehaviorSubject.seeded(100.0);
  late Stream<dynamic> query;

  // Subscription
  late StreamSubscription subscription, subscription2, subscription3;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SpinCircleBottomBarHolder(
        bottomNavigationBar: SCBottomBarDetails(
            circleColors: [
              Color(0xfff4f5f0), //008c45
              Color(0xff0055A4),
              Color(0xffEF4135),
            ],
            iconTheme:
                const IconThemeData(color: Color.fromARGB(254, 255, 255, 255)),
            activeIconTheme:
                const IconThemeData(color: Color.fromARGB(255, 96, 231, 18)),
            backgroundColor:
                const Color(0xff1da1f2), //Color.fromARGB(255, 66, 103, 78),
            titleStyle: const TextStyle(color: Colors.black45, fontSize: 12),
            activeTitleStyle: const TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
            actionButtonDetails: SCActionButtonDetails(
                color: Color.fromARGB(255, 255, 255, 255),
                icon: const Icon(
                  Icons.add_alert_outlined,
                  color: Color.fromARGB(255, 232, 29, 29),
                ),
                elevation: 5),
            elevation: 2.0,
            items: [
              // Suggested count : 4
              SCBottomBarItem(
                  icon: Icons.home, title: "Home", onPressed: () {}),
              SCBottomBarItem(
                  icon: Icons.supervised_user_circle,
                  title: "About us",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const MyAppp())));
                  }),
              SCBottomBarItem(
                  icon: Icons.info_outline, title: "Info", onPressed: () {}),
              SCBottomBarItem(
                  icon: Icons.call, title: "call help", onPressed: () {}),
            ],
            circleItems: [
              //Suggested Count: 3
              SCItem(
                  icon: const Icon(Icons.medical_services,
                      color: Color(0xff16C2D5)),
                  onPressed: addGeoPoint),
              SCItem(
                  icon: const Icon(Icons.local_fire_department_sharp,
                      color: Color(0xffe25822)),
                  onPressed: addGeoPoint),
              SCItem(
                  icon: const Icon(
                    Icons.local_police,
                    color: Color.fromARGB(255, 112, 104, 26),
                  ),
                  onPressed: addGeoPoint),
            ],
            bnbHeight: 150 // Suggested Height 80
            ),
        child: Container(
          color: Colors.orangeAccent.withAlpha(55),
          child: Center(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                  target: LatLng(24.142, -110.321), zoom: 15),
              onMapCreated: onMapCreated,
              myLocationEnabled: true,
              mapType: MapType.hybrid,
              compassEnabled: true,
              markers: markers.toSet(),
            ),
          ),
        ),
      ),
      // GoogleMap(
      //   initialCameraPosition:
      //       CameraPosition(target: LatLng(24.142, -110.321), zoom: 15),
      //   onMapCreated: onMapCreated,
      //   myLocationEnabled: true,
      //   mapType: MapType.hybrid,
      //   compassEnabled: true,
      //   markers: markers.toSet(),
      // ),

      // Positioned(
      //     bottom: 50,
      //     right: 10,
      //     child: TextButton(
      //         child: Icon(Icons.pin_drop, color: Colors.green),
      //         onPressed: addGeoPoint)),
      Positioned(
          bottom: 650,
          left: 10,
          child: Slider(
            min: 100.0,
            max: 500.0,
            divisions: 4,
            value: radius.value,
            label: 'Radius ${radius.value}km',
            activeColor: Colors.black,
            inactiveColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.88),
            onChanged: updateQuery,
          ))
    ]);
  }

  // Map Created Lifecycle Hook
  onMapCreated(GoogleMapController controller) {
    _startQuery();
    setState(() {
      mapController = controller;
    });
  }

  _animateToUser(double lat, double lang) async {
    LocationData pos = await location.getLocation();

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(pos.latitude!, pos.longitude!),
      zoom: 17.0,
    )));
  }

  // Set GeoLocation Data
  Future<DocumentReference> addGeoPoint() async {
    var pos = await location.getLocation();

    GeoFirePoint point =
        geo.point(latitude: pos.latitude!, longitude: pos.longitude!);
    return firestore
        .collection('medical emergency')
        .add({'position': point.data, 'name': 'need medical help'});
  }

  Future<DocumentReference> addGeoPoint1() async {
    var pos = await location.getLocation();

    GeoFirePoint point1 =
        geo.point(latitude: pos.latitude!, longitude: pos.longitude!);
    return firestore
        .collection('fire help')
        .add({'position': point1.data, 'name': 'need help building on fire '});
  }

  Future<DocumentReference> addGeoPoint2() async {
    var pos = await location.getLocation();

    GeoFirePoint point2 =
        geo.point(latitude: pos.latitude!, longitude: pos.longitude!);
    return firestore
        .collection('crime alert')
        .add({'position': point2.data, 'name': 'in trouble need police'});
  }

  void updateMarkers(List<DocumentSnapshot> documentList) {
    for (var document in documentList) {
      GeoPoint point = document['position']['geopoint'];
      GeoPoint point1 = document['position']['geopoint'];
      GeoPoint point2 = document['position']['geopoint'];
      addMarker(point.latitude, point.longitude);
      addMarker(point1.latitude, point.longitude);
      addMarker(point2.latitude, point.longitude);
    }
  }

  void addMarker(double lat, double lng) {
    var marker = Marker(
      markerId: MarkerId(UniqueKey().toString()),
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
    setState(() {
      markers.add(marker);
    });
  }

  @override
  void initState() {
    super.initState();
    geo = Geoflutterfire();
    _startQuery();
  }

  _startQuery() async {
    // Get users location
    LocationData pos = await location.getLocation();
    double lat = pos.latitude!;
    double lng = pos.longitude!;

    // Make a referece to firestore
    var collectionReference = firestore.collection('medical emergency');
    var collectionReference1 = firestore.collection('medical emergency');
    var collectionReference2 = firestore.collection('medical emergency');
    GeoFirePoint center = geo.point(latitude: lat, longitude: lng);

    // subscribe to query
    subscription = radius.switchMap((rad) {
      return geo.collection(collectionRef: collectionReference).within(
          center: center, radius: rad, field: 'position', strictMode: true);
    }).listen(updateMarkers);

    subscription2 = radius.switchMap((rad) {
      return geo.collection(collectionRef: collectionReference1).within(
          center: center, radius: rad, field: 'position', strictMode: true);
    }).listen(updateMarkers);

    subscription3 = radius.switchMap((rad) {
      return geo.collection(collectionRef: collectionReference2).within(
          center: center, radius: rad, field: 'position', strictMode: true);
    }).listen(updateMarkers);
  }

  updateQuery(value) {
    final zoomMap = {
      100.0: 12.0,
      200.0: 10.0,
      300.0: 7.0,
      400.0: 6.0,
      500.0: 5.0
    };
    final zoom = zoomMap[value];
    mapController.moveCamera(CameraUpdate.zoomTo(zoom!));

    setState(() {
      radius.add(value);
    });
  }

  @override
  dispose() {
    subscription.cancel();
    subscription2.cancel();
    subscription3.cancel();
    super.dispose();
  }
}
