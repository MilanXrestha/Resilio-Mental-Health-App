// This is a generated file - do not edit.
//
// Generated from images.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $0;
import 'images.pb.dart' as $1;
import 'images.pbjson.dart';

export 'images.pb.dart';

abstract class ImagesServiceBase extends $pb.GeneratedService {
  $async.Future<$1.GetFeaturedImagesResponse> getFeaturedImages(
      $pb.ServerContext ctx, $1.GetFeaturedImagesRequest request);
  $async.Future<$1.Image> getImageById(
      $pb.ServerContext ctx, $1.GetImageByIdRequest request);
  $async.Future<$1.ListImagesResponse> listImages(
      $pb.ServerContext ctx, $1.ListImagesRequest request);
  $async.Future<$1.GetImagesByTypeResponse> getImagesByType(
      $pb.ServerContext ctx, $1.GetImagesByTypeRequest request);
  $async.Future<$1.Image> createImage(
      $pb.ServerContext ctx, $1.CreateImageRequest request);
  $async.Future<$1.Image> updateImage(
      $pb.ServerContext ctx, $1.UpdateImageRequest request);
  $async.Future<$0.Empty> deleteImage(
      $pb.ServerContext ctx, $1.DeleteImageRequest request);
  $async.Future<$1.Image> incrementDownloadCount(
      $pb.ServerContext ctx, $1.IncrementDownloadCountRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetFeaturedImages':
        return $1.GetFeaturedImagesRequest();
      case 'GetImageById':
        return $1.GetImageByIdRequest();
      case 'ListImages':
        return $1.ListImagesRequest();
      case 'GetImagesByType':
        return $1.GetImagesByTypeRequest();
      case 'CreateImage':
        return $1.CreateImageRequest();
      case 'UpdateImage':
        return $1.UpdateImageRequest();
      case 'DeleteImage':
        return $1.DeleteImageRequest();
      case 'IncrementDownloadCount':
        return $1.IncrementDownloadCountRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetFeaturedImages':
        return getFeaturedImages(ctx, request as $1.GetFeaturedImagesRequest);
      case 'GetImageById':
        return getImageById(ctx, request as $1.GetImageByIdRequest);
      case 'ListImages':
        return listImages(ctx, request as $1.ListImagesRequest);
      case 'GetImagesByType':
        return getImagesByType(ctx, request as $1.GetImagesByTypeRequest);
      case 'CreateImage':
        return createImage(ctx, request as $1.CreateImageRequest);
      case 'UpdateImage':
        return updateImage(ctx, request as $1.UpdateImageRequest);
      case 'DeleteImage':
        return deleteImage(ctx, request as $1.DeleteImageRequest);
      case 'IncrementDownloadCount':
        return incrementDownloadCount(
            ctx, request as $1.IncrementDownloadCountRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => ImagesServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => ImagesServiceBase$messageJson;
}
