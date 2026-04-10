// This is a generated file - do not edit.
//
// Generated from appointment.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import 'common.pbjson.dart' as $0;

@$core.Deprecated('Use appointmentDescriptor instead')
const Appointment$json = {
  '1': 'Appointment',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'patient_id', '3': 2, '4': 1, '5': 9, '10': 'patientId'},
    {'1': 'therapist_id', '3': 3, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'scheduled_time', '3': 4, '4': 1, '5': 9, '10': 'scheduledTime'},
    {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    {'1': 'payment_status', '3': 6, '4': 1, '5': 9, '10': 'paymentStatus'},
    {
      '1': 'payment_transaction_id',
      '3': 7,
      '4': 1,
      '5': 9,
      '10': 'paymentTransactionId'
    },
    {'1': 'meeting_room_id', '3': 8, '4': 1, '5': 9, '10': 'meetingRoomId'},
    {'1': 'created_at', '3': 9, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 10, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Appointment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List appointmentDescriptor = $convert.base64Decode(
    'CgtBcHBvaW50bWVudBIOCgJpZBgBIAEoCVICaWQSHQoKcGF0aWVudF9pZBgCIAEoCVIJcGF0aW'
    'VudElkEiEKDHRoZXJhcGlzdF9pZBgDIAEoCVILdGhlcmFwaXN0SWQSJQoOc2NoZWR1bGVkX3Rp'
    'bWUYBCABKAlSDXNjaGVkdWxlZFRpbWUSFgoGc3RhdHVzGAUgASgJUgZzdGF0dXMSJQoOcGF5bW'
    'VudF9zdGF0dXMYBiABKAlSDXBheW1lbnRTdGF0dXMSNAoWcGF5bWVudF90cmFuc2FjdGlvbl9p'
    'ZBgHIAEoCVIUcGF5bWVudFRyYW5zYWN0aW9uSWQSJgoPbWVldGluZ19yb29tX2lkGAggASgJUg'
    '1tZWV0aW5nUm9vbUlkEh0KCmNyZWF0ZWRfYXQYCSABKAlSCWNyZWF0ZWRBdBIdCgp1cGRhdGVk'
    'X2F0GAogASgJUgl1cGRhdGVkQXQ=');

@$core.Deprecated('Use scheduleAppointmentRequestDescriptor instead')
const ScheduleAppointmentRequest$json = {
  '1': 'ScheduleAppointmentRequest',
  '2': [
    {'1': 'patient_id', '3': 1, '4': 1, '5': 9, '10': 'patientId'},
    {'1': 'therapist_id', '3': 2, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'scheduled_time', '3': 3, '4': 1, '5': 9, '10': 'scheduledTime'},
  ],
};

/// Descriptor for `ScheduleAppointmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List scheduleAppointmentRequestDescriptor =
    $convert.base64Decode(
        'ChpTY2hlZHVsZUFwcG9pbnRtZW50UmVxdWVzdBIdCgpwYXRpZW50X2lkGAEgASgJUglwYXRpZW'
        '50SWQSIQoMdGhlcmFwaXN0X2lkGAIgASgJUgt0aGVyYXBpc3RJZBIlCg5zY2hlZHVsZWRfdGlt'
        'ZRgDIAEoCVINc2NoZWR1bGVkVGltZQ==');

@$core.Deprecated('Use getAppointmentRequestDescriptor instead')
const GetAppointmentRequest$json = {
  '1': 'GetAppointmentRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetAppointmentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getAppointmentRequestDescriptor = $convert
    .base64Decode('ChVHZXRBcHBvaW50bWVudFJlcXVlc3QSDgoCaWQYASABKAlSAmlk');

@$core.Deprecated('Use listAppointmentsRequestDescriptor instead')
const ListAppointmentsRequest$json = {
  '1': 'ListAppointmentsRequest',
  '2': [
    {
      '1': 'pagination',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resilio.common.PaginationRequest',
      '10': 'pagination'
    },
    {'1': 'patient_id', '3': 2, '4': 1, '5': 9, '10': 'patientId'},
    {'1': 'therapist_id', '3': 3, '4': 1, '5': 9, '10': 'therapistId'},
    {'1': 'status', '3': 4, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `ListAppointmentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAppointmentsRequestDescriptor = $convert.base64Decode(
    'ChdMaXN0QXBwb2ludG1lbnRzUmVxdWVzdBJBCgpwYWdpbmF0aW9uGAEgASgLMiEucmVzaWxpby'
    '5jb21tb24uUGFnaW5hdGlvblJlcXVlc3RSCnBhZ2luYXRpb24SHQoKcGF0aWVudF9pZBgCIAEo'
    'CVIJcGF0aWVudElkEiEKDHRoZXJhcGlzdF9pZBgDIAEoCVILdGhlcmFwaXN0SWQSFgoGc3RhdH'
    'VzGAQgASgJUgZzdGF0dXM=');

@$core.Deprecated('Use listAppointmentsResponseDescriptor instead')
const ListAppointmentsResponse$json = {
  '1': 'ListAppointmentsResponse',
  '2': [
    {
      '1': 'appointments',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.appointment.Appointment',
      '10': 'appointments'
    },
    {
      '1': 'pagination',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.resilio.common.PaginationResponse',
      '10': 'pagination'
    },
  ],
};

/// Descriptor for `ListAppointmentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAppointmentsResponseDescriptor = $convert.base64Decode(
    'ChhMaXN0QXBwb2ludG1lbnRzUmVzcG9uc2USRAoMYXBwb2ludG1lbnRzGAEgAygLMiAucmVzaW'
    'xpby5hcHBvaW50bWVudC5BcHBvaW50bWVudFIMYXBwb2ludG1lbnRzEkIKCnBhZ2luYXRpb24Y'
    'AiABKAsyIi5yZXNpbGlvLmNvbW1vbi5QYWdpbmF0aW9uUmVzcG9uc2VSCnBhZ2luYXRpb24=');

@$core.Deprecated('Use updateAppointmentStatusRequestDescriptor instead')
const UpdateAppointmentStatusRequest$json = {
  '1': 'UpdateAppointmentStatusRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `UpdateAppointmentStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateAppointmentStatusRequestDescriptor =
    $convert.base64Decode(
        'Ch5VcGRhdGVBcHBvaW50bWVudFN0YXR1c1JlcXVlc3QSDgoCaWQYASABKAlSAmlkEhYKBnN0YX'
        'R1cxgCIAEoCVIGc3RhdHVz');

@$core.Deprecated('Use verifyPaymentRequestDescriptor instead')
const VerifyPaymentRequest$json = {
  '1': 'VerifyPaymentRequest',
  '2': [
    {'1': 'appointment_id', '3': 1, '4': 1, '5': 9, '10': 'appointmentId'},
    {'1': 'transaction_id', '3': 2, '4': 1, '5': 9, '10': 'transactionId'},
  ],
};

/// Descriptor for `VerifyPaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyPaymentRequestDescriptor = $convert.base64Decode(
    'ChRWZXJpZnlQYXltZW50UmVxdWVzdBIlCg5hcHBvaW50bWVudF9pZBgBIAEoCVINYXBwb2ludG'
    '1lbnRJZBIlCg50cmFuc2FjdGlvbl9pZBgCIAEoCVINdHJhbnNhY3Rpb25JZA==');

const $core.Map<$core.String, $core.dynamic> AppointmentServiceBase$json = {
  '1': 'AppointmentService',
  '2': [
    {
      '1': 'ScheduleAppointment',
      '2': '.resilio.appointment.ScheduleAppointmentRequest',
      '3': '.resilio.appointment.Appointment'
    },
    {
      '1': 'GetAppointment',
      '2': '.resilio.appointment.GetAppointmentRequest',
      '3': '.resilio.appointment.Appointment'
    },
    {
      '1': 'ListAppointments',
      '2': '.resilio.appointment.ListAppointmentsRequest',
      '3': '.resilio.appointment.ListAppointmentsResponse'
    },
    {
      '1': 'UpdateStatus',
      '2': '.resilio.appointment.UpdateAppointmentStatusRequest',
      '3': '.resilio.appointment.Appointment'
    },
    {
      '1': 'VerifyPayment',
      '2': '.resilio.appointment.VerifyPaymentRequest',
      '3': '.resilio.appointment.Appointment'
    },
  ],
};

@$core.Deprecated('Use appointmentServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    AppointmentServiceBase$messageJson = {
  '.resilio.appointment.ScheduleAppointmentRequest':
      ScheduleAppointmentRequest$json,
  '.resilio.appointment.Appointment': Appointment$json,
  '.resilio.appointment.GetAppointmentRequest': GetAppointmentRequest$json,
  '.resilio.appointment.ListAppointmentsRequest': ListAppointmentsRequest$json,
  '.resilio.common.PaginationRequest': $0.PaginationRequest$json,
  '.resilio.appointment.ListAppointmentsResponse':
      ListAppointmentsResponse$json,
  '.resilio.common.PaginationResponse': $0.PaginationResponse$json,
  '.resilio.appointment.UpdateAppointmentStatusRequest':
      UpdateAppointmentStatusRequest$json,
  '.resilio.appointment.VerifyPaymentRequest': VerifyPaymentRequest$json,
};

/// Descriptor for `AppointmentService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List appointmentServiceDescriptor = $convert.base64Decode(
    'ChJBcHBvaW50bWVudFNlcnZpY2USaAoTU2NoZWR1bGVBcHBvaW50bWVudBIvLnJlc2lsaW8uYX'
    'Bwb2ludG1lbnQuU2NoZWR1bGVBcHBvaW50bWVudFJlcXVlc3QaIC5yZXNpbGlvLmFwcG9pbnRt'
    'ZW50LkFwcG9pbnRtZW50El4KDkdldEFwcG9pbnRtZW50EioucmVzaWxpby5hcHBvaW50bWVudC'
    '5HZXRBcHBvaW50bWVudFJlcXVlc3QaIC5yZXNpbGlvLmFwcG9pbnRtZW50LkFwcG9pbnRtZW50'
    'Em8KEExpc3RBcHBvaW50bWVudHMSLC5yZXNpbGlvLmFwcG9pbnRtZW50Lkxpc3RBcHBvaW50bW'
    'VudHNSZXF1ZXN0Gi0ucmVzaWxpby5hcHBvaW50bWVudC5MaXN0QXBwb2ludG1lbnRzUmVzcG9u'
    'c2USZQoMVXBkYXRlU3RhdHVzEjMucmVzaWxpby5hcHBvaW50bWVudC5VcGRhdGVBcHBvaW50bW'
    'VudFN0YXR1c1JlcXVlc3QaIC5yZXNpbGlvLmFwcG9pbnRtZW50LkFwcG9pbnRtZW50ElwKDVZl'
    'cmlmeVBheW1lbnQSKS5yZXNpbGlvLmFwcG9pbnRtZW50LlZlcmlmeVBheW1lbnRSZXF1ZXN0Gi'
    'AucmVzaWxpby5hcHBvaW50bWVudC5BcHBvaW50bWVudA==');
