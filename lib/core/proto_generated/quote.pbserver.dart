// This is a generated file - do not edit.
//
// Generated from quote.proto.

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
import 'quote.pb.dart' as $1;
import 'quote.pbjson.dart';

export 'quote.pb.dart';

abstract class QuoteServiceBase extends $pb.GeneratedService {
  $async.Future<$1.GetFeaturedQuotesResponse> getFeaturedQuotes(
      $pb.ServerContext ctx, $1.GetFeaturedQuotesRequest request);
  $async.Future<$1.Quote> getQuoteById(
      $pb.ServerContext ctx, $1.GetQuoteByIdRequest request);
  $async.Future<$1.ListQuotesResponse> listQuotes(
      $pb.ServerContext ctx, $1.ListQuotesRequest request);
  $async.Future<$1.Quote> createQuote(
      $pb.ServerContext ctx, $1.CreateQuoteRequest request);
  $async.Future<$1.Quote> updateQuote(
      $pb.ServerContext ctx, $1.UpdateQuoteRequest request);
  $async.Future<$0.Empty> deleteQuote(
      $pb.ServerContext ctx, $1.DeleteQuoteRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetFeaturedQuotes':
        return $1.GetFeaturedQuotesRequest();
      case 'GetQuoteById':
        return $1.GetQuoteByIdRequest();
      case 'ListQuotes':
        return $1.ListQuotesRequest();
      case 'CreateQuote':
        return $1.CreateQuoteRequest();
      case 'UpdateQuote':
        return $1.UpdateQuoteRequest();
      case 'DeleteQuote':
        return $1.DeleteQuoteRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetFeaturedQuotes':
        return getFeaturedQuotes(ctx, request as $1.GetFeaturedQuotesRequest);
      case 'GetQuoteById':
        return getQuoteById(ctx, request as $1.GetQuoteByIdRequest);
      case 'ListQuotes':
        return listQuotes(ctx, request as $1.ListQuotesRequest);
      case 'CreateQuote':
        return createQuote(ctx, request as $1.CreateQuoteRequest);
      case 'UpdateQuote':
        return updateQuote(ctx, request as $1.UpdateQuoteRequest);
      case 'DeleteQuote':
        return deleteQuote(ctx, request as $1.DeleteQuoteRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => QuoteServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => QuoteServiceBase$messageJson;
}
