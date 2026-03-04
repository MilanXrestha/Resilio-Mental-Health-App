import 'package:dio/dio.dart';
import 'package:protobuf/protobuf.dart';

class ProtobufInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.data is GeneratedMessage) {
      final message = options.data as GeneratedMessage;

      // Set the message type header for the backend to know what to decode
      options.headers['X-Protobuf-Message-Type'] = _getMessageType(message);
      options.headers['Accept'] = 'application/x-protobuf';
      options.contentType = 'application/x-protobuf';

      // Convert to binary
      options.data = message.writeToBuffer();
    } else {
      // Even if not sending proto, we might want to receive proto
      if (!options.headers.containsKey('Accept')) {
        options.headers['Accept'] = 'application/x-protobuf, application/json';
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  String _getMessageType(GeneratedMessage message) {
    return message.info_.qualifiedMessageName;
  }
}
