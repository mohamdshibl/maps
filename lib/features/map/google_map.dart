
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapGoogle extends StatefulWidget {
  const MapGoogle({Key? key}) : super(key: key);

  @override
  State<MapGoogle> createState() => _MapGoogleState();
}

class _MapGoogleState extends State<MapGoogle> {

  final Completer<GoogleMapController> _googleMapController = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Set<Polygon> _polygons = {};
  List<LatLng> _currentPolygonPoints = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          polygons: _polygons,
          onTap: _handleMapTap, // Handle map tap events
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _clearPolygon,
          child: Icon(Icons.clear),
        ),
      ),
    );
  }

  void _handleMapTap(LatLng tappedPoint) {
    setState(() {
      // Add the tapped point to the current polygon being drawn.
      _currentPolygonPoints.add(tappedPoint);

      // Update the polygons set with the updated polygon.
      _polygons.clear(); // Clear previous polygons.
      _polygons.add(
        Polygon(
          polygonId: PolygonId('1'),
          points: _currentPolygonPoints,
          geodesic: true,
          strokeWidth: 5,
          strokeColor: Colors.deepOrange,
          fillColor: Colors.blueGrey,
        ),
      );
    });
  }

  void _clearPolygon() {
    setState(() {
      _currentPolygonPoints.clear();
      _polygons.clear();
    });
  }
}
































// import 'dart:async';
// import 'dart:collection';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
//
//
// class MapGoogle extends StatefulWidget {
//   const MapGoogle({Key? key}) : super(key: key);
//
//   @override
//   State<MapGoogle> createState() => _MapGoogleState();
// }
//
// class _MapGoogleState extends State<MapGoogle> {
//
//   final Completer<GoogleMapController> _googleMapController = Completer();
//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//   final Set<Marker> _marker = {};
//   Set<Polygon> _polygon = HashSet<Polygon>();
//
//   List<LatLng> points = [
//     LatLng(33.654235, 73.073000),
//     LatLng(33.647326, 73.820175),
//     LatLng(33.689531 , 73.763160),
//     LatLng(33.689531 , 73.662334),
//     LatLng(33.654235 , 73.0730000),
//     //LatLng(33.654235, 73.073000),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//
//     _polygon.add(Polygon(polygonId:PolygonId('1'),points: points,
//     geodesic: true,
//     strokeWidth: 5,
//     strokeColor: Colors.deepOrange,
//     fillColor: Colors.blueGrey,
//     ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  SafeArea(
//       child:  Scaffold(
//         body: GoogleMap(
//           initialCameraPosition: _kGooglePlex,
//           myLocationEnabled: true,
//           myLocationButtonEnabled: true,
//           polygons: _polygon,
//         ),
//       ),
//     );
//   }
// }