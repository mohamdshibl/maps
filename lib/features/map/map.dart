import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
import 'package:flutter_map_line_editor/flutter_map_line_editor.dart';
import 'package:latlong2/latlong.dart';
import '../../Model/report_model/report_model.dart';
import 'cubit_map/map_cubit.dart';
import 'cubit_map/map_state.dart';


class PolygonPage extends StatefulWidget {
  const PolygonPage({Key? key}) : super(key: key);

  @override
  State<PolygonPage> createState() => _PolygonPageState();
}

class _PolygonPageState extends State<PolygonPage> {

  final TextEditingController _reportController = TextEditingController();
  final List<PolygonReport> _polygonReports = [];

  late PolyEditor polyEditor;
  final List<Polygon> polygons = [];
  final List<Marker> reportMarkers = [];

  final testPolygon = Polygon(
    color: Colors.deepOrange,
    isFilled: true,
    points: [],
  );

  @override
  void initState() {
    super.initState();

    polyEditor = PolyEditor(
      addClosePathMarker: true,
      points: testPolygon.points,
      pointIcon: const Icon(Icons.map, size: 15),
      intermediateIcon: const Icon(Icons.camera, size: 15, color: Colors.grey),
      callbackRefresh: () => {setState(() {})},
    );

    polygons.add(testPolygon);
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit,MapStates>(
      listener: (context, state) {},
      builder:(context, state) {
        var cubit = MapCubit.get(context);
        return Scaffold(
          appBar: AppBar(title: const Text('Draw Polygon'),
              actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      testPolygon.points.clear();
                      reportMarkers.clear();
                    });
                  },
                  child: const Icon(
                    Icons.delete,
                    size: 26.0,
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      print(testPolygon.points.toList());
                    });
                  },
                  child: const Icon(
                    Icons.edit,
                    size: 26.0,
                  ),
                )),
          ]),
          body: Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  onTap: (_, ll) {
                    polyEditor.add(testPolygon.points, ll);
                  },
                  center: const LatLng(31.21564, 29.95527),
                  zoom: 12,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  PolygonLayer(polygons: polygons),
                  MarkerLayer(markers: reportMarkers),
                  DragMarkers(markers: polyEditor.edit()),
                ],
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Column(
                  children: [
                    TextField(
                      controller: _reportController,
                      decoration: const InputDecoration(
                        hintText: 'Write a report',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await cubit.savePolygonAndReportToFirebase(_reportController.text, testPolygon.points);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
// Positioned(
//   bottom: 200,
//   left: 10,
//   right: 10,
//   child:SizedBox(
//     height: 30.h,
//     child: ConditionalBuilder(
//         condition: list.isNotEmpty,
//         builder: (context) => ListView.separated(
//           physics: const BouncingScrollPhysics(),
//           separatorBuilder: (context, index) =>
//               defaultSeparatorContainer(),
//           itemCount: polygonReports.length,
//           itemBuilder: (context, index) => InkWell(
//             child: ,
//           ),
//         ),
//         fallback: (context) => const Center(
//             child: CircularProgressIndicator())),
//   ),
// ),
            ],
          ),
        );
      },
    );
  }
}



























































































































// void addReportMarker(LatLng point, Report report) {
//   setState(() {
//     reportMarkers.add(
//       Marker(
//         point: point,
//         builder: (_) => Icon(Icons.place, color: Colors.red),
//       ),
//     );
//     print(point);
//   });
// }

// class PolygonPage extends StatefulWidget {
//   const PolygonPage({Key? key}) : super(key: key);
//
//   @override
//   State<PolygonPage> createState() => _PolygonPageState();
// }
//
// class _PolygonPageState extends State<PolygonPage> {
//   late PolyEditor polyEditor;
//
//   final polygons = <Polygon>[];
//   final testPolygon = Polygon(
//     color: Colors.deepOrange,
//     isFilled: true,
//     points: [],
//   );
//
//   @override
//   void initState() {
//     super.initState();
//
//     polyEditor = PolyEditor(
//       addClosePathMarker: true,
//       points: testPolygon.points,
//       pointIcon: const Icon(Icons.crop_square, size: 23),
//       intermediateIcon: const Icon(Icons.lens, size: 15, color: Colors.grey),
//       callbackRefresh: () => {setState(() {})},
//     );
//
//     polygons.add(testPolygon);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Polygon example')),
//       body: FlutterMap(
//         options: MapOptions(
//           onTap: (_, ll) {
//             polyEditor.add(testPolygon.points, ll);
//           },
//           // For backwards compatibility with pre v5 don't use const
//           // ignore: prefer_const_constructors
//           center: LatLng(51.509343, -0.127001), // Initial map center
//           zoom: 15, // Initial zoom level
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//             subdomains: ['a', 'b', 'c'],
//           ),
//           PolygonLayer(polygons: polygons),
//           DragMarkers(markers: polyEditor.edit()),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.delete),
//         onPressed: () {
//           setState(() {
//             testPolygon.points.clear();
//           });
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:flutter_map_dragmarker/flutter_map_dragmarker.dart';
// import 'package:flutter_map_line_editor/flutter_map_line_editor.dart';
// //import 'package:flutter_map_example/pages/polygon.dart';
//
// class InteractiveMapScreen extends StatefulWidget {
//   const InteractiveMapScreen({Key? key}) : super(key: key);
//
//   @override
//   _InteractiveMapScreenState createState() => _InteractiveMapScreenState();
// }
//
// class _InteractiveMapScreenState extends State<InteractiveMapScreen> {
//   final List<LatLng> _currentPolygonPoints = [];
//   final Set<Polygon> _polygons = {};
//   final MapController _mapController = MapController();
//   //var testPolyline;
//   @override
//   void initState() {
//     super.initState();
//
//     var polyEditor = PolyEditor(
//       points: _currentPolygonPoints ,
//       pointIcon: Icon(Icons.crop_square, size: 23),
//       intermediateIcon: Icon(Icons.lens, size: 15, color: Colors.grey),
//       callbackRefresh: () => { this.setState(() {
//
//       })},
//       addClosePathMarker: true, // set to true if polygon
//     );
//     // Initialize the map controller
//     _mapController.move(LatLng(51.509343, -0.127001), 15);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Draw Polygons on Map'),
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             GestureDetector(
//               child: FlutterMap(
//                 mapController: _mapController,
//                 options: MapOptions(
//                   onTap: (TapPosition tapPosition, LatLng point) {
//                     _handleMapTap(point);
//                   },
//                   center: LatLng(51.509343, -0.127001), // Initial map center
//                   zoom: 15, // Initial zoom level
//                 ),
//                 children: [
//                   TileLayer(
//                     urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                     subdomains: ['a', 'b', 'c'],
//                   ),
//                   // PolylineLayer(polylines: polyLines),
//                   // DragMarkers(markers: polyEditor.edit()),
//                   PolygonLayer(
//                     polygons: _polygons.toList(),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _clearPolygon,
//         child: Icon(Icons.clear),
//       ),
//     );
//   }
//
//   void _handleMapTap(LatLng tappedPoint) {
//     setState(() {
//       // Get the tapped point from the map controller
//       print("Tapped Point: $tappedPoint");
//
//       if (tappedPoint != null) {
//         _currentPolygonPoints.add(tappedPoint);
//       }
//
//       // Check if there are at least three points to form a polygon
//       if (_currentPolygonPoints.length >= 3) {
//         _polygons.clear();
//         _polygons.add(
//           Polygon(
//             points: _currentPolygonPoints,
//             color: Colors.blue.withOpacity(0.5), // Fill color
//             borderColor: Colors.blue,
//           ),
//         );
//       }
//     });
//   }
//
//   void _clearPolygon() {
//     setState(() {
//       _currentPolygonPoints.clear();
//       _polygons.clear();
//     });
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
//
// class InteractiveMapScreen extends StatefulWidget {
//   const InteractiveMapScreen({super.key});
//
//   @override
//   _InteractiveMapScreenState createState() => _InteractiveMapScreenState();
// }
//
// class _InteractiveMapScreenState extends State<InteractiveMapScreen> {
//   final List<LatLng> _currentPolygonPoints = [];
//   final Set<Polygon> _polygons = {};
//   final MapController _mapController = MapController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Draw Polygons on Map'),
//       ),
//       body:SafeArea(
//         child: Stack(
//           children:[
//             GestureDetector(
//             // onTap:()=> setState(() {
//             //   //_handleMapTap();
//             //   print("shiblllllllllllllllllll");
//             //   final tappedPoint = _mapController.bounds?.center;
//             //   if (tappedPoint != null) {
//             //     _currentPolygonPoints.add(tappedPoint);
//             //   }
//             // }
//             // ),
//             child: FlutterMap(
//               mapController: _mapController,
//               options: MapOptions(
//                 onTap:  (TapPosition tapPosition, LatLng point) {
//                   _handleMapTap(point);
//                 },
//                 center:  LatLng(51.509343, -0.127001), // Initial map center
//                 zoom: 15, // Initial zoom level
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                   subdomains: ['a', 'b', 'c'],
//                 ),
//                 PolygonLayer(
//                   polygons: _polygons.toList(),
//                 ),
//               ],
//             ),
//           ),
//         ],),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _clearPolygon,
//         child: Icon(Icons.clear),
//       ),
//     );
//   }
//
//   void _handleMapTap(LatLng tappedPoint) {
//     setState(() {
//       // Get the tapped point from the map controller
//       print("shiblllllllllllllllllll");
//
//       if (tappedPoint != null) {
//         _currentPolygonPoints.add(tappedPoint);
//       }
//       _polygons.add(
//         Polygon(
//           points: _currentPolygonPoints,
//           color: Colors.blue.withOpacity(0.5), // Fill color
//           borderColor: Colors.blue,
//         ),
//       );
//     });
//   }

// void _handleMapTap(LatLng tappedPoint) {
//   setState(() {
//     print("Tapped at: $tappedPoint");
//
//     if (tappedPoint != null) {
//       _currentPolygonPoints.add(tappedPoint);
//     }
//
//     _polygons.clear();
//     _polygons.add(
//       Polygon(
//         points: _currentPolygonPoints,
//         color: Colors.blue.withOpacity(0.3), // Fill color
//         borderColor: Colors.blue,
//       ),
//     );
//   });
// }

// void _handleMapTap() {
//   setState(() {
//     // Get the tapped point from the map controller
//     print("shiblllllllllllllllllll");
//
//     final tappedPoint = _mapController.bounds?.center;
//     if (tappedPoint != null) {
//       _currentPolygonPoints.add(tappedPoint);
//     }
//     _polygons.clear();
//     _polygons.add(
//         Polygon(
//           points: _currentPolygonPoints,
//           color: Colors.blue.withOpacity(0.5), // Fill color
//           borderColor: Colors.blue,
//         ),
//     );
//
//   });
// }

//   void _clearPolygon() {
//     setState(() {
//       _currentPolygonPoints.clear();
//       //_polygons.clear();
//     });
//   }
// }

//
// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key}) : super(key: key);
//
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   // Create a map controller.
//    MapController mapController = MapController();
//
//   // Create a list to store the polygon points.
//    final polygonPoints = <LatLng>[];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Stack(
//           children: [
//             FlutterMap(
//               options: MapOptions(
//                 center: const LatLng(51.509343, -0.127001),
//                 zoom: 4,
//                 // controller: mapController,
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate:
//                       'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
//                   subdomains: ['a', 'b', 'c'],
//                 ),
//                 PolygonLayer(
//                   polygonCulling: false,
//                   polygons: [
//                     Polygon(
//                       points: [
//                         LatLng(46.95, -9.5),
//                         LatLng(52.25, -10.5),
//                         LatLng(52.25, -6.2),
//                         LatLng(46.95, -7.2),
//                       ],
//                       color: Colors.blue.withOpacity(0.3),
//                       borderStrokeWidth: 7,
//                       borderColor: Colors.lightBlue,
//                       isFilled: false,
//                     ),
//                   ],
//                 )
//                 //You can add other layers like markers, polygons, etc. here
//               ],
//             ),
//           ],
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     mapController.ontap.listen((event) {
//       //       // Add the tap location to the polygon points list.
//       //       polygonPoints.add(event);
//       //
//       //       // If the polygon has at least three points, draw it on the map.
//       //       if (polygonPoints.length >= 3) {
//       //         // Create a new polygon with the polygon points list.
//       //         final polygon = Polygon(
//       //           points: polygonPoints,
//       //           color: Colors.red,
//       //         );
//       //
//       //         // Add the new polygon to the map view.
//       //         mapController.layers.add(polygon);
//       //
//       //         // Clear the polygon points list.
//       //         polygonPoints.clear();
//       //       }
//       //     });
//       //   },
//       //   child: Icon(Icons.add),
//       // ),
//     );
//   }
//    void _handleMapTap(LatLng tappedPoint) {
//      setState(() {
//        _currentPolygonPoints.add(tappedPoint);
//      });
//    }
//
//    void _clearPolygon() {
//      setState(() {
//        _currentPolygonPoints.clear();
//      });
//    }
// }
// }

// void checkStateChanges() {
//   FirebaseAuth.instance.authStateChanges().listen((User? user) {
//     if (user == null) {
//       print('User is currently signed out!');
//     } else {
//       print('User is signed in!');
//     }
//   });
// }
