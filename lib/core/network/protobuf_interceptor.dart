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
      options.responseType = ResponseType.bytes;

      // Convert to binary
      options.data = message.writeToBuffer();
    } else {
      // Non-protobuf requests: only change behaviour when the caller hasn't
      // already opted into protobuf explicitly.
      final accept = options.headers['Accept']?.toString() ?? '';
      final wantsProto = accept.contains('application/x-protobuf');

      if (!wantsProto) {
        // Request JSON only so endpoints without a protobuf schema don't fail.
        if (!options.headers.containsKey('Accept')) {
          options.headers['Accept'] = 'application/json';
        }
        // Let Dio parse the body automatically instead of returning raw bytes.
        if (options.responseType == ResponseType.bytes) {
          options.responseType = ResponseType.json;
        }
      }

      // Imply JSON content-type for Map/List bodies. Replaces Dio's default
      // ImplyContentTypeInterceptor, which we removed to avoid protobuf warnings.
      if (options.contentType == null &&
          (options.data is Map || options.data is List)) {
        options.contentType = 'application/json';
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
