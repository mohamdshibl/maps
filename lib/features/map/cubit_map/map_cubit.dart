import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlng/latlng.dart';
import '../../../Model/report_model/report_model.dart';
import 'map_state.dart';

class MapCubit extends Cubit<MapStates> {

  MapCubit() : super(MapInitial());

  static MapCubit get(context) => BlocProvider.of(context);


  Polygon? testPolygon ;
  Future<void> savePolygonAndReportToFirebase(String reportController,testPolygon) async {
    final user = FirebaseAuth.instance.currentUser;
    emit(SendReportLoadingState());
    try {
      final documentReference = FirebaseFirestore.instance.collection('report').doc();
      await documentReference.set({
        'polygon': DateTime.now().toString().trim(),
        'report': reportController,
        'user_id': user!.uid,
      });
      // _polygonReports.add(PolygonReport(testPolygon.points, _reportController.text));
      emit(SendReportSuccessState());
      testPolygon = testPolygon.clear();
      //reportController.clear();
    } catch (e) {
      emit(SendReportFailureState(
          errMessage: 'there error when you send data $e'));
    }
  }



  Future<void> getPolygonReportsFromFirebase() async {
    final collectionReference = FirebaseFirestore.instance.collection('report');
    final snapshot = await collectionReference.get();
    final polygonReports = <PolygonReport>[];

    for (final document in snapshot.docs) {
      polygonReports.add(PolygonReport(
        List<LatLng>.from(document['polygon'].map((point) =>
            LatLng(point['latitude'] as double, point['longitude'] as double))),
        document['report'] as String,
      ));
    }
  }



}