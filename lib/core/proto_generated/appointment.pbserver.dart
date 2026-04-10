// This is a generated file - do not edit.
//
// Generated from appointment.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'appointment.pb.dart' as $1;
import 'appointment.pbjson.dart';

export 'appointment.pb.dart';

abstract class AppointmentServiceBase extends $pb.GeneratedService {
  $async.Future<$1.Appointment> scheduleAppointment(
      $pb.ServerContext ctx, $1.ScheduleAppointmentRequest request);
  $async.Future<$1.Appointment> getAppointment(
      $pb.ServerContext ctx, $1.GetAppointmentRequest request);
  $async.Future<$1.ListAppointmentsResponse> listAppointments(
      $pb.ServerContext ctx, $1.ListAppointmentsRequest request);
  $async.Future<$1.Appointment> updateStatus(
      $pb.ServerContext ctx, $1.UpdateAppointmentStatusRequest request);
  $async.Future<$1.Appointment> verifyPayment(
      $pb.ServerContext ctx, $1.VerifyPaymentRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ScheduleAppointment':
        return $1.ScheduleAppointmentRequest();
      case 'GetAppointment':
        return $1.GetAppointmentRequest();
      case 'ListAppointments':
        return $1.ListAppointmentsRequest();
      case 'UpdateStatus':
        return $1.UpdateAppointmentStatusRequest();
      case 'VerifyPayment':
        return $1.VerifyPaymentRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ScheduleAppointment':
        return scheduleAppointment(
            ctx, request as $1.ScheduleAppointmentRequest);
      case 'GetAppointment':
        return getAppointment(ctx, request as $1.GetAppointmentRequest);
      case 'ListAppointments':
        return listAppointments(ctx, request as $1.ListAppointmentsRequest);
      case 'UpdateStatus':
        return updateStatus(ctx, request as $1.UpdateAppointmentStatusRequest);
      case 'VerifyPayment':
        return verifyPayment(ctx, request as $1.VerifyPaymentRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      AppointmentServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => AppointmentServiceBase$messageJson;
}
