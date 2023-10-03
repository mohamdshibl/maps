import 'package:flutter_map/flutter_map.dart';
import 'package:latlng/latlng.dart';


class PolygonReport {
  final List<LatLng> polygon;
  final String report;

  PolygonReport(this.polygon, this.report);
}
















// class Report {
//   final String id;
//   final String description;
//
//   Report({
//     required this.id,
//     required this.description,
//   });
// }

// class PolygonWithReport {
//   final Polygon polygon;
//   Report? report;
//
//   PolygonWithReport({
//     required this.polygon,
//     this.report,
//   });
// }