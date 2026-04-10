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

import 'common.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Appointment extends $pb.GeneratedMessage {
  factory Appointment({
    $core.String? id,
    $core.String? patientId,
    $core.String? therapistId,
    $core.String? scheduledTime,
    $core.String? status,
    $core.String? paymentStatus,
    $core.String? paymentTransactionId,
    $core.String? meetingRoomId,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (patientId != null) result.patientId = patientId;
    if (therapistId != null) result.therapistId = therapistId;
    if (scheduledTime != null) result.scheduledTime = scheduledTime;
    if (status != null) result.status = status;
    if (paymentStatus != null) result.paymentStatus = paymentStatus;
    if (paymentTransactionId != null)
      result.paymentTransactionId = paymentTransactionId;
    if (meetingRoomId != null) result.meetingRoomId = meetingRoomId;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  Appointment._();

  factory Appointment.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Appointment.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Appointment',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.appointment'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'patientId')
    ..aOS(3, _omitFieldNames ? '' : 'therapistId')
    ..aOS(4, _omitFieldNames ? '' : 'scheduledTime')
    ..aOS(5, _omitFieldNames ? '' : 'status')
    ..aOS(6, _omitFieldNames ? '' : 'paymentStatus')
    ..aOS(7, _omitFieldNames ? '' : 'paymentTransactionId')
    ..aOS(8, _omitFieldNames ? '' : 'meetingRoomId')
    ..aOS(9, _omitFieldNames ? '' : 'createdAt')
    ..aOS(10, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Appointment clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Appointment copyWith(void Function(Appointment) updates) =>
      super.copyWith((message) => updates(message as Appointment))
          as Appointment;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Appointment create() => Appointment._();
  @$core.override
  Appointment createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Appointment getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Appointment>(create);
  static Appointment? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get patientId => $_getSZ(1);
  @$pb.TagNumber(2)
  set patientId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPatientId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPatientId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get therapistId => $_getSZ(2);
  @$pb.TagNumber(3)
  set therapistId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTherapistId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTherapistId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get scheduledTime => $_getSZ(3);
  @$pb.TagNumber(4)
  set scheduledTime($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasScheduledTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearScheduledTime() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get status => $_getSZ(4);
  @$pb.TagNumber(5)
  set status($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get paymentStatus => $_getSZ(5);
  @$pb.TagNumber(6)
  set paymentStatus($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPaymentStatus() => $_has(5);
  @$pb.TagNumber(6)
  void clearPaymentStatus() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get paymentTransactionId => $_getSZ(6);
  @$pb.TagNumber(7)
  set paymentTransactionId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPaymentTransactionId() => $_has(6);
  @$pb.TagNumber(7)
  void clearPaymentTransactionId() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get meetingRoomId => $_getSZ(7);
  @$pb.TagNumber(8)
  set meetingRoomId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMeetingRoomId() => $_has(7);
  @$pb.TagNumber(8)
  void clearMeetingRoomId() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get createdAt => $_getSZ(8);
  @$pb.TagNumber(9)
  set createdAt($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCreatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreatedAt() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get updatedAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set updatedAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasUpdatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearUpdatedAt() => $_clearField(10);
}

class ScheduleAppointmentRequest extends $pb.GeneratedMessage {
  factory ScheduleAppointmentRequest({
    $core.String? patientId,
    $core.String? therapistId,
    $core.String? scheduledTime,
  }) {
    final result = create();
    if (patientId != null) result.patientId = patientId;
    if (therapistId != null) result.therapistId = therapistId;
    if (scheduledTime != null) result.scheduledTime = scheduledTime;
    return result;
  }

  ScheduleAppointmentRequest._();

  factory ScheduleAppointmentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ScheduleAppointmentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ScheduleAppointmentRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.appointment'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'patientId')
    ..aOS(2, _omitFieldNames ? '' : 'therapistId')
    ..aOS(3, _omitFieldNames ? '' : 'scheduledTime')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScheduleAppointmentRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ScheduleAppointmentRequest copyWith(
          void Function(ScheduleAppointmentRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ScheduleAppointmentRequest))
          as ScheduleAppointmentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ScheduleAppointmentRequest create() => ScheduleAppointmentRequest._();
  @$core.override
  ScheduleAppointmentRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ScheduleAppointmentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ScheduleAppointmentRequest>(create);
  static ScheduleAppointmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get patientId => $_getSZ(0);
  @$pb.TagNumber(1)
  set patientId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPatientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPatientId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get therapistId => $_getSZ(1);
  @$pb.TagNumber(2)
  set therapistId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTherapistId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTherapistId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get scheduledTime => $_getSZ(2);
  @$pb.TagNumber(3)
  set scheduledTime($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasScheduledTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearScheduledTime() => $_clearField(3);
}

class GetAppointmentRequest extends $pb.GeneratedMessage {
  factory GetAppointmentRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetAppointmentRequest._();

  factory GetAppointmentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetAppointmentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetAppointmentRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.appointment'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAppointmentRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetAppointmentRequest copyWith(
          void Function(GetAppointmentRequest) updates) =>
      super.copyWith((message) => updates(message as GetAppointmentRequest))
          as GetAppointmentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetAppointmentRequest create() => GetAppointmentRequest._();
  @$core.override
  GetAppointmentRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetAppointmentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetAppointmentRequest>(create);
  static GetAppointmentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class ListAppointmentsRequest extends $pb.GeneratedMessage {
  factory ListAppointmentsRequest({
    $0.PaginationRequest? pagination,
    $core.String? patientId,
    $core.String? therapistId,
    $core.String? status,
  }) {
    final result = create();
    if (pagination != null) result.pagination = pagination;
    if (patientId != null) result.patientId = patientId;
    if (therapistId != null) result.therapistId = therapistId;
    if (status != null) result.status = status;
    return result;
  }

  ListAppointmentsRequest._();

  factory ListAppointmentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListAppointmentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAppointmentsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.appointment'),
      createEmptyInstance: create)
    ..aOM<$0.PaginationRequest>(1, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginationRequest.create)
    ..aOS(2, _omitFieldNames ? '' : 'patientId')
    ..aOS(3, _omitFieldNames ? '' : 'therapistId')
    ..aOS(4, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAppointmentsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAppointmentsRequest copyWith(
          void Function(ListAppointmentsRequest) updates) =>
      super.copyWith((message) => updates(message as ListAppointmentsRequest))
          as ListAppointmentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAppointmentsRequest create() => ListAppointmentsRequest._();
  @$core.override
  ListAppointmentsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListAppointmentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAppointmentsRequest>(create);
  static ListAppointmentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $0.PaginationRequest get pagination => $_getN(0);
  @$pb.TagNumber(1)
  set pagination($0.PaginationRequest value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPagination() => $_has(0);
  @$pb.TagNumber(1)
  void clearPagination() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.PaginationRequest ensurePagination() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get patientId => $_getSZ(1);
  @$pb.TagNumber(2)
  set patientId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPatientId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPatientId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get therapistId => $_getSZ(2);
  @$pb.TagNumber(3)
  set therapistId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTherapistId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTherapistId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);
}

class ListAppointmentsResponse extends $pb.GeneratedMessage {
  factory ListAppointmentsResponse({
    $core.Iterable<Appointment>? appointments,
    $0.PaginationResponse? pagination,
  }) {
    final result = create();
    if (appointments != null) result.appointments.addAll(appointments);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListAppointmentsResponse._();

  factory ListAppointmentsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListAppointmentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListAppointmentsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.appointment'),
      createEmptyInstance: create)
    ..pPM<Appointment>(1, _omitFieldNames ? '' : 'appointments',
        subBuilder: Appointment.create)
    ..aOM<$0.PaginationResponse>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginationResponse.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAppointmentsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListAppointmentsResponse copyWith(
          void Function(ListAppointmentsResponse) updates) =>
      super.copyWith((message) => updates(message as ListAppointmentsResponse))
          as ListAppointmentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAppointmentsResponse create() => ListAppointmentsResponse._();
  @$core.override
  ListAppointmentsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListAppointmentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListAppointmentsResponse>(create);
  static ListAppointmentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Appointment> get appointments => $_getList(0);

  @$pb.TagNumber(2)
  $0.PaginationResponse get pagination => $_getN(1);
  @$pb.TagNumber(2)
  set pagination($0.PaginationResponse value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPagination() => $_has(1);
  @$pb.TagNumber(2)
  void clearPagination() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.PaginationResponse ensurePagination() => $_ensure(1);
}

class UpdateAppointmentStatusRequest extends $pb.GeneratedMessage {
  factory UpdateAppointmentStatusRequest({
    $core.String? id,
    $core.String? status,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (status != null) result.status = status;
    return result;
  }

  UpdateAppointmentStatusRequest._();

  factory UpdateAppointmentStatusRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateAppointmentStatusRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateAppointmentStatusRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.appointment'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateAppointmentStatusRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateAppointmentStatusRequest copyWith(
          void Function(UpdateAppointmentStatusRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateAppointmentStatusRequest))
          as UpdateAppointmentStatusRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateAppointmentStatusRequest create() =>
      UpdateAppointmentStatusRequest._();
  @$core.override
  UpdateAppointmentStatusRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateAppointmentStatusRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateAppointmentStatusRequest>(create);
  static UpdateAppointmentStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get status => $_getSZ(1);
  @$pb.TagNumber(2)
  set status($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);
}

class VerifyPaymentRequest extends $pb.GeneratedMessage {
  factory VerifyPaymentRequest({
    $core.String? appointmentId,
    $core.String? transactionId,
  }) {
    final result = create();
    if (appointmentId != null) result.appointmentId = appointmentId;
    if (transactionId != null) result.transactionId = transactionId;
    return result;
  }

  VerifyPaymentRequest._();

  factory VerifyPaymentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VerifyPaymentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VerifyPaymentRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.appointment'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'appointmentId')
    ..aOS(2, _omitFieldNames ? '' : 'transactionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyPaymentRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifyPaymentRequest copyWith(void Function(VerifyPaymentRequest) updates) =>
      super.copyWith((message) => updates(message as VerifyPaymentRequest))
          as VerifyPaymentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyPaymentRequest create() => VerifyPaymentRequest._();
  @$core.override
  VerifyPaymentRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VerifyPaymentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VerifyPaymentRequest>(create);
  static VerifyPaymentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get appointmentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set appointmentId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAppointmentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAppointmentId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get transactionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set transactionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTransactionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransactionId() => $_clearField(2);
}

class AppointmentServiceApi {
  final $pb.RpcClient _client;

  AppointmentServiceApi(this._client);

  $async.Future<Appointment> scheduleAppointment(
          $pb.ClientContext? ctx, ScheduleAppointmentRequest request) =>
      _client.invoke<Appointment>(ctx, 'AppointmentService',
          'ScheduleAppointment', request, Appointment());
  $async.Future<Appointment> getAppointment(
          $pb.ClientContext? ctx, GetAppointmentRequest request) =>
      _client.invoke<Appointment>(
          ctx, 'AppointmentService', 'GetAppointment', request, Appointment());
  $async.Future<ListAppointmentsResponse> listAppointments(
          $pb.ClientContext? ctx, ListAppointmentsRequest request) =>
      _client.invoke<ListAppointmentsResponse>(ctx, 'AppointmentService',
          'ListAppointments', request, ListAppointmentsResponse());
  $async.Future<Appointment> updateStatus(
          $pb.ClientContext? ctx, UpdateAppointmentStatusRequest request) =>
      _client.invoke<Appointment>(
          ctx, 'AppointmentService', 'UpdateStatus', request, Appointment());
  $async.Future<Appointment> verifyPayment(
          $pb.ClientContext? ctx, VerifyPaymentRequest request) =>
      _client.invoke<Appointment>(
          ctx, 'AppointmentService', 'VerifyPayment', request, Appointment());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
