
abstract class MapStates {
}

class MapInitial extends MapStates {}

class SendReportLoadingState extends MapStates {}
class SendReportSuccessState extends MapStates {}
class SendReportFailureState extends MapStates {
  final String errMessage;
  SendReportFailureState({required this.errMessage});
}



