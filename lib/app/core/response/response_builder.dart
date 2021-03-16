import 'package:easydrink/app/interfaces/response_error_handler_interface.dart';

import 'response_default.dart';
import 'response_status.dart';

class ResponseBuilder {
  static ResponseDefault failed<T>(
      {T object, String message, IErrorHandler errorInterceptor}) {
    if (errorInterceptor != null) {
      message = errorInterceptor.handleError(message);
    }
    return ResponseDefault<T>(
        object: object, message: message, status: ResponseStatus.rsFailed);
  }

  static ResponseDefault success<T>(
      {T object, String message, IErrorHandler errorInterceptor}) {
    if (errorInterceptor != null) {
      message = errorInterceptor.handleError(message);
    }
    return ResponseDefault<T>(
        object: object, message: message, status: ResponseStatus.rsSuccess);
  }
}
