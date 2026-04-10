// This is a generated file - do not edit.
//
// Generated from therapist.proto.

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

@$core.Deprecated('Use therapistProfileDescriptor instead')
const TherapistProfile$json = {
  '1': 'TherapistProfile',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'bio', '3': 3, '4': 1, '5': 9, '10': 'bio'},
    {'1': 'specialty', '3': 4, '4': 1, '5': 9, '10': 'specialty'},
    {'1': 'qualifications', '3': 5, '4': 3, '5': 9, '10': 'qualifications'},
    {
      '1': 'years_of_experience',
      '3': 6,
      '4': 1,
      '5': 5,
      '10': 'yearsOfExperience'
    },
    {'1': 'is_verified', '3': 7, '4': 1, '5': 8, '10': 'isVerified'},
    {'1': 'consultation_fee', '3': 8, '4': 1, '5': 9, '10': 'consultationFee'},
    {'1': 'rating', '3': 9, '4': 1, '5': 5, '10': 'rating'},
    {'1': 'created_at', '3': 10, '4': 1, '5': 9, '10': 'createdAt'},
    {'1': 'updated_at', '3': 11, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `TherapistProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List therapistProfileDescriptor = $convert.base64Decode(
    'ChBUaGVyYXBpc3RQcm9maWxlEg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2'
    'VySWQSEAoDYmlvGAMgASgJUgNiaW8SHAoJc3BlY2lhbHR5GAQgASgJUglzcGVjaWFsdHkSJgoO'
    'cXVhbGlmaWNhdGlvbnMYBSADKAlSDnF1YWxpZmljYXRpb25zEi4KE3llYXJzX29mX2V4cGVyaW'
    'VuY2UYBiABKAVSEXllYXJzT2ZFeHBlcmllbmNlEh8KC2lzX3ZlcmlmaWVkGAcgASgIUgppc1Zl'
    'cmlmaWVkEikKEGNvbnN1bHRhdGlvbl9mZWUYCCABKAlSD2NvbnN1bHRhdGlvbkZlZRIWCgZyYX'
    'RpbmcYCSABKAVSBnJhdGluZxIdCgpjcmVhdGVkX2F0GAogASgJUgljcmVhdGVkQXQSHQoKdXBk'
    'YXRlZF9hdBgLIAEoCVIJdXBkYXRlZEF0');

@$core.Deprecated('Use timeSlotDescriptor instead')
const TimeSlot$json = {
  '1': 'TimeSlot',
  '2': [
    {'1': 'start_time', '3': 1, '4': 1, '5': 9, '10': 'startTime'},
    {'1': 'end_time', '3': 2, '4': 1, '5': 9, '10': 'endTime'},
    {'1': 'is_booked', '3': 3, '4': 1, '5': 8, '10': 'isBooked'},
  ],
};

/// Descriptor for `TimeSlot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeSlotDescriptor = $convert.base64Decode(
    'CghUaW1lU2xvdBIdCgpzdGFydF90aW1lGAEgASgJUglzdGFydFRpbWUSGQoIZW5kX3RpbWUYAi'
    'ABKAlSB2VuZFRpbWUSGwoJaXNfYm9va2VkGAMgASgIUghpc0Jvb2tlZA==');

@$core.Deprecated('Use availabilityDescriptor instead')
const Availability$json = {
  '1': 'Availability',
  '2': [
    {
      '1': 'slots',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.therapist.TimeSlot',
      '10': 'slots'
    },
  ],
};

/// Descriptor for `Availability`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List availabilityDescriptor = $convert.base64Decode(
    'CgxBdmFpbGFiaWxpdHkSMQoFc2xvdHMYASADKAsyGy5yZXNpbGlvLnRoZXJhcGlzdC5UaW1lU2'
    'xvdFIFc2xvdHM=');

@$core.Deprecated('Use getTherapistProfileRequestDescriptor instead')
const GetTherapistProfileRequest$json = {
  '1': 'GetTherapistProfileRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetTherapistProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTherapistProfileRequestDescriptor =
    $convert.base64Decode(
        'ChpHZXRUaGVyYXBpc3RQcm9maWxlUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use getTherapistByUserIdRequestDescriptor instead')
const GetTherapistByUserIdRequest$json = {
  '1': 'GetTherapistByUserIdRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetTherapistByUserIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTherapistByUserIdRequestDescriptor =
    $convert.base64Decode(
        'ChtHZXRUaGVyYXBpc3RCeVVzZXJJZFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');

@$core.Deprecated('Use listTherapistsRequestDescriptor instead')
const ListTherapistsRequest$json = {
  '1': 'ListTherapistsRequest',
  '2': [
    {
      '1': 'pagination',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.resilio.common.PaginationRequest',
      '10': 'pagination'
    },
    {'1': 'specialty_tag', '3': 2, '4': 1, '5': 9, '10': 'specialtyTag'},
  ],
};

/// Descriptor for `ListTherapistsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTherapistsRequestDescriptor = $convert.base64Decode(
    'ChVMaXN0VGhlcmFwaXN0c1JlcXVlc3QSQQoKcGFnaW5hdGlvbhgBIAEoCzIhLnJlc2lsaW8uY2'
    '9tbW9uLlBhZ2luYXRpb25SZXF1ZXN0UgpwYWdpbmF0aW9uEiMKDXNwZWNpYWx0eV90YWcYAiAB'
    'KAlSDHNwZWNpYWx0eVRhZw==');

@$core.Deprecated('Use listTherapistsResponseDescriptor instead')
const ListTherapistsResponse$json = {
  '1': 'ListTherapistsResponse',
  '2': [
    {
      '1': 'therapists',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.resilio.therapist.TherapistProfile',
      '10': 'therapists'
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

/// Descriptor for `ListTherapistsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTherapistsResponseDescriptor = $convert.base64Decode(
    'ChZMaXN0VGhlcmFwaXN0c1Jlc3BvbnNlEkMKCnRoZXJhcGlzdHMYASADKAsyIy5yZXNpbGlvLn'
    'RoZXJhcGlzdC5UaGVyYXBpc3RQcm9maWxlUgp0aGVyYXBpc3RzEkIKCnBhZ2luYXRpb24YAiAB'
    'KAsyIi5yZXNpbGlvLmNvbW1vbi5QYWdpbmF0aW9uUmVzcG9uc2VSCnBhZ2luYXRpb24=');

@$core.Deprecated('Use createTherapistProfileRequestDescriptor instead')
const CreateTherapistProfileRequest$json = {
  '1': 'CreateTherapistProfileRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'bio', '3': 2, '4': 1, '5': 9, '10': 'bio'},
    {'1': 'specialty', '3': 3, '4': 1, '5': 9, '10': 'specialty'},
    {'1': 'qualifications', '3': 4, '4': 3, '5': 9, '10': 'qualifications'},
    {
      '1': 'years_of_experience',
      '3': 5,
      '4': 1,
      '5': 5,
      '10': 'yearsOfExperience'
    },
    {'1': 'consultation_fee', '3': 6, '4': 1, '5': 9, '10': 'consultationFee'},
  ],
};

/// Descriptor for `CreateTherapistProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createTherapistProfileRequestDescriptor = $convert.base64Decode(
    'Ch1DcmVhdGVUaGVyYXBpc3RQcm9maWxlUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySW'
    'QSEAoDYmlvGAIgASgJUgNiaW8SHAoJc3BlY2lhbHR5GAMgASgJUglzcGVjaWFsdHkSJgoOcXVh'
    'bGlmaWNhdGlvbnMYBCADKAlSDnF1YWxpZmljYXRpb25zEi4KE3llYXJzX29mX2V4cGVyaWVuY2'
    'UYBSABKAVSEXllYXJzT2ZFeHBlcmllbmNlEikKEGNvbnN1bHRhdGlvbl9mZWUYBiABKAlSD2Nv'
    'bnN1bHRhdGlvbkZlZQ==');

@$core.Deprecated('Use updateTherapistProfileRequestDescriptor instead')
const UpdateTherapistProfileRequest$json = {
  '1': 'UpdateTherapistProfileRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'bio', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'bio', '17': true},
    {
      '1': 'specialty',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'specialty',
      '17': true
    },
    {'1': 'qualifications', '3': 4, '4': 3, '5': 9, '10': 'qualifications'},
    {
      '1': 'years_of_experience',
      '3': 5,
      '4': 1,
      '5': 5,
      '9': 2,
      '10': 'yearsOfExperience',
      '17': true
    },
    {
      '1': 'is_verified',
      '3': 6,
      '4': 1,
      '5': 8,
      '9': 3,
      '10': 'isVerified',
      '17': true
    },
    {
      '1': 'consultation_fee',
      '3': 7,
      '4': 1,
      '5': 9,
      '9': 4,
      '10': 'consultationFee',
      '17': true
    },
  ],
  '8': [
    {'1': '_bio'},
    {'1': '_specialty'},
    {'1': '_years_of_experience'},
    {'1': '_is_verified'},
    {'1': '_consultation_fee'},
  ],
};

/// Descriptor for `UpdateTherapistProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateTherapistProfileRequestDescriptor = $convert.base64Decode(
    'Ch1VcGRhdGVUaGVyYXBpc3RQcm9maWxlUmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSFQoDYmlvGA'
    'IgASgJSABSA2Jpb4gBARIhCglzcGVjaWFsdHkYAyABKAlIAVIJc3BlY2lhbHR5iAEBEiYKDnF1'
    'YWxpZmljYXRpb25zGAQgAygJUg5xdWFsaWZpY2F0aW9ucxIzChN5ZWFyc19vZl9leHBlcmllbm'
    'NlGAUgASgFSAJSEXllYXJzT2ZFeHBlcmllbmNliAEBEiQKC2lzX3ZlcmlmaWVkGAYgASgISANS'
    'CmlzVmVyaWZpZWSIAQESLgoQY29uc3VsdGF0aW9uX2ZlZRgHIAEoCUgEUg9jb25zdWx0YXRpb2'
    '5GZWWIAQFCBgoEX2Jpb0IMCgpfc3BlY2lhbHR5QhYKFF95ZWFyc19vZl9leHBlcmllbmNlQg4K'
    'DF9pc192ZXJpZmllZEITChFfY29uc3VsdGF0aW9uX2ZlZQ==');

@$core.Deprecated('Use matchTherapistsRequestDescriptor instead')
const MatchTherapistsRequest$json = {
  '1': 'MatchTherapistsRequest',
  '2': [
    {'1': 'primary_concern', '3': 1, '4': 1, '5': 9, '10': 'primaryConcern'},
    {
      '1': 'preferred_activities',
      '3': 2,
      '4': 3,
      '5': 9,
      '10': 'preferredActivities'
    },
  ],
};

/// Descriptor for `MatchTherapistsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List matchTherapistsRequestDescriptor = $convert.base64Decode(
    'ChZNYXRjaFRoZXJhcGlzdHNSZXF1ZXN0EicKD3ByaW1hcnlfY29uY2VybhgBIAEoCVIOcHJpbW'
    'FyeUNvbmNlcm4SMQoUcHJlZmVycmVkX2FjdGl2aXRpZXMYAiADKAlSE3ByZWZlcnJlZEFjdGl2'
    'aXRpZXM=');

const $core.Map<$core.String, $core.dynamic> TherapistServiceBase$json = {
  '1': 'TherapistService',
  '2': [
    {
      '1': 'GetProfile',
      '2': '.resilio.therapist.GetTherapistProfileRequest',
      '3': '.resilio.therapist.TherapistProfile'
    },
    {
      '1': 'GetProfileByUserId',
      '2': '.resilio.therapist.GetTherapistByUserIdRequest',
      '3': '.resilio.therapist.TherapistProfile'
    },
    {
      '1': 'ListProfiles',
      '2': '.resilio.therapist.ListTherapistsRequest',
      '3': '.resilio.therapist.ListTherapistsResponse'
    },
    {
      '1': 'CreateProfile',
      '2': '.resilio.therapist.CreateTherapistProfileRequest',
      '3': '.resilio.therapist.TherapistProfile'
    },
    {
      '1': 'UpdateProfile',
      '2': '.resilio.therapist.UpdateTherapistProfileRequest',
      '3': '.resilio.therapist.TherapistProfile'
    },
    {
      '1': 'MatchTherapists',
      '2': '.resilio.therapist.MatchTherapistsRequest',
      '3': '.resilio.therapist.ListTherapistsResponse'
    },
  ],
};

@$core.Deprecated('Use therapistServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    TherapistServiceBase$messageJson = {
  '.resilio.therapist.GetTherapistProfileRequest':
      GetTherapistProfileRequest$json,
  '.resilio.therapist.TherapistProfile': TherapistProfile$json,
  '.resilio.therapist.GetTherapistByUserIdRequest':
      GetTherapistByUserIdRequest$json,
  '.resilio.therapist.ListTherapistsRequest': ListTherapistsRequest$json,
  '.resilio.common.PaginationRequest': $0.PaginationRequest$json,
  '.resilio.therapist.ListTherapistsResponse': ListTherapistsResponse$json,
  '.resilio.common.PaginationResponse': $0.PaginationResponse$json,
  '.resilio.therapist.CreateTherapistProfileRequest':
      CreateTherapistProfileRequest$json,
  '.resilio.therapist.UpdateTherapistProfileRequest':
      UpdateTherapistProfileRequest$json,
  '.resilio.therapist.MatchTherapistsRequest': MatchTherapistsRequest$json,
};

/// Descriptor for `TherapistService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List therapistServiceDescriptor = $convert.base64Decode(
    'ChBUaGVyYXBpc3RTZXJ2aWNlEmAKCkdldFByb2ZpbGUSLS5yZXNpbGlvLnRoZXJhcGlzdC5HZX'
    'RUaGVyYXBpc3RQcm9maWxlUmVxdWVzdBojLnJlc2lsaW8udGhlcmFwaXN0LlRoZXJhcGlzdFBy'
    'b2ZpbGUSaQoSR2V0UHJvZmlsZUJ5VXNlcklkEi4ucmVzaWxpby50aGVyYXBpc3QuR2V0VGhlcm'
    'FwaXN0QnlVc2VySWRSZXF1ZXN0GiMucmVzaWxpby50aGVyYXBpc3QuVGhlcmFwaXN0UHJvZmls'
    'ZRJjCgxMaXN0UHJvZmlsZXMSKC5yZXNpbGlvLnRoZXJhcGlzdC5MaXN0VGhlcmFwaXN0c1JlcX'
    'Vlc3QaKS5yZXNpbGlvLnRoZXJhcGlzdC5MaXN0VGhlcmFwaXN0c1Jlc3BvbnNlEmYKDUNyZWF0'
    'ZVByb2ZpbGUSMC5yZXNpbGlvLnRoZXJhcGlzdC5DcmVhdGVUaGVyYXBpc3RQcm9maWxlUmVxdW'
    'VzdBojLnJlc2lsaW8udGhlcmFwaXN0LlRoZXJhcGlzdFByb2ZpbGUSZgoNVXBkYXRlUHJvZmls'
    'ZRIwLnJlc2lsaW8udGhlcmFwaXN0LlVwZGF0ZVRoZXJhcGlzdFByb2ZpbGVSZXF1ZXN0GiMucm'
    'VzaWxpby50aGVyYXBpc3QuVGhlcmFwaXN0UHJvZmlsZRJnCg9NYXRjaFRoZXJhcGlzdHMSKS5y'
    'ZXNpbGlvLnRoZXJhcGlzdC5NYXRjaFRoZXJhcGlzdHNSZXF1ZXN0GikucmVzaWxpby50aGVyYX'
    'Bpc3QuTGlzdFRoZXJhcGlzdHNSZXNwb25zZQ==');
