import 'response_status.dart';

class ResponseDefault<T> {
  final T object;
  String message;
  final ResponseStatus status;

  bool get success => status == ResponseStatus.rsSuccess;

  bool get failed => status == ResponseStatus.rsFailed;

  ResponseDefault({this.object, this.message, this.status});
}
