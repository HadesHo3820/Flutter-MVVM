import 'package:counter/data/network/error_handler.dart';

class Failure {
  int code;
  String message;
  Failure({
    required this.code,
    required this.message,
  });
}

class DefaultFailure extends Failure {
  DefaultFailure()
      : super(code: ResponseCode.defaults, message: ResponseMessage.defaults);
}
