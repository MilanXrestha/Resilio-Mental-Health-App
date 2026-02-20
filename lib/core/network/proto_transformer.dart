import 'package:dio/dio.dart';
import 'package:protobuf/protobuf.dart';

class ProtobufTransformer extends BackgroundTransformer {

  @override
  Future<String> transformRequest(RequestOptions options) async {
    if (options.data is GeneratedMessage) {
      final message = options.data as GeneratedMessage;
      options.contentType = 'application/x-protobuf';
      // Dio will handle the Uint8List correctly if we don't convert it to String
      // However, transformRequest expects a String return for non-binary types.
      // For protobuf, we usually override how the data is sent.
    }
    return super.transformRequest(options);
  }
}
