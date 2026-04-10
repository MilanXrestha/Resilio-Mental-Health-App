// This is a generated file - do not edit.
//
// Generated from therapist.proto.

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

class TherapistProfile extends $pb.GeneratedMessage {
  factory TherapistProfile({
    $core.String? id,
    $core.String? userId,
    $core.String? bio,
    $core.String? specialty,
    $core.Iterable<$core.String>? qualifications,
    $core.int? yearsOfExperience,
    $core.bool? isVerified,
    $core.String? consultationFee,
    $core.int? rating,
    $core.String? createdAt,
    $core.String? updatedAt,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (userId != null) result.userId = userId;
    if (bio != null) result.bio = bio;
    if (specialty != null) result.specialty = specialty;
    if (qualifications != null) result.qualifications.addAll(qualifications);
    if (yearsOfExperience != null) result.yearsOfExperience = yearsOfExperience;
    if (isVerified != null) result.isVerified = isVerified;
    if (consultationFee != null) result.consultationFee = consultationFee;
    if (rating != null) result.rating = rating;
    if (createdAt != null) result.createdAt = createdAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  TherapistProfile._();

  factory TherapistProfile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TherapistProfile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TherapistProfile',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'bio')
    ..aOS(4, _omitFieldNames ? '' : 'specialty')
    ..pPS(5, _omitFieldNames ? '' : 'qualifications')
    ..aI(6, _omitFieldNames ? '' : 'yearsOfExperience')
    ..aOB(7, _omitFieldNames ? '' : 'isVerified')
    ..aOS(8, _omitFieldNames ? '' : 'consultationFee')
    ..aI(9, _omitFieldNames ? '' : 'rating')
    ..aOS(10, _omitFieldNames ? '' : 'createdAt')
    ..aOS(11, _omitFieldNames ? '' : 'updatedAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TherapistProfile clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TherapistProfile copyWith(void Function(TherapistProfile) updates) =>
      super.copyWith((message) => updates(message as TherapistProfile))
          as TherapistProfile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TherapistProfile create() => TherapistProfile._();
  @$core.override
  TherapistProfile createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TherapistProfile getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TherapistProfile>(create);
  static TherapistProfile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get bio => $_getSZ(2);
  @$pb.TagNumber(3)
  set bio($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBio() => $_has(2);
  @$pb.TagNumber(3)
  void clearBio() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get specialty => $_getSZ(3);
  @$pb.TagNumber(4)
  set specialty($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSpecialty() => $_has(3);
  @$pb.TagNumber(4)
  void clearSpecialty() => $_clearField(4);

  @$pb.TagNumber(5)
  $pb.PbList<$core.String> get qualifications => $_getList(4);

  @$pb.TagNumber(6)
  $core.int get yearsOfExperience => $_getIZ(5);
  @$pb.TagNumber(6)
  set yearsOfExperience($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasYearsOfExperience() => $_has(5);
  @$pb.TagNumber(6)
  void clearYearsOfExperience() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get isVerified => $_getBF(6);
  @$pb.TagNumber(7)
  set isVerified($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasIsVerified() => $_has(6);
  @$pb.TagNumber(7)
  void clearIsVerified() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get consultationFee => $_getSZ(7);
  @$pb.TagNumber(8)
  set consultationFee($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasConsultationFee() => $_has(7);
  @$pb.TagNumber(8)
  void clearConsultationFee() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.int get rating => $_getIZ(8);
  @$pb.TagNumber(9)
  set rating($core.int value) => $_setSignedInt32(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRating() => $_has(8);
  @$pb.TagNumber(9)
  void clearRating() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get createdAt => $_getSZ(9);
  @$pb.TagNumber(10)
  set createdAt($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get updatedAt => $_getSZ(10);
  @$pb.TagNumber(11)
  set updatedAt($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasUpdatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearUpdatedAt() => $_clearField(11);
}

class TimeSlot extends $pb.GeneratedMessage {
  factory TimeSlot({
    $core.String? startTime,
    $core.String? endTime,
    $core.bool? isBooked,
  }) {
    final result = create();
    if (startTime != null) result.startTime = startTime;
    if (endTime != null) result.endTime = endTime;
    if (isBooked != null) result.isBooked = isBooked;
    return result;
  }

  TimeSlot._();

  factory TimeSlot.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TimeSlot.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TimeSlot',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'startTime')
    ..aOS(2, _omitFieldNames ? '' : 'endTime')
    ..aOB(3, _omitFieldNames ? '' : 'isBooked')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimeSlot clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimeSlot copyWith(void Function(TimeSlot) updates) =>
      super.copyWith((message) => updates(message as TimeSlot)) as TimeSlot;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TimeSlot create() => TimeSlot._();
  @$core.override
  TimeSlot createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TimeSlot getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimeSlot>(create);
  static TimeSlot? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get startTime => $_getSZ(0);
  @$pb.TagNumber(1)
  set startTime($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStartTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartTime() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get endTime => $_getSZ(1);
  @$pb.TagNumber(2)
  set endTime($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEndTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndTime() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isBooked => $_getBF(2);
  @$pb.TagNumber(3)
  set isBooked($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIsBooked() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsBooked() => $_clearField(3);
}

class Availability extends $pb.GeneratedMessage {
  factory Availability({
    $core.Iterable<TimeSlot>? slots,
  }) {
    final result = create();
    if (slots != null) result.slots.addAll(slots);
    return result;
  }

  Availability._();

  factory Availability.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Availability.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Availability',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.therapist'),
      createEmptyInstance: create)
    ..pPM<TimeSlot>(1, _omitFieldNames ? '' : 'slots',
        subBuilder: TimeSlot.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Availability clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Availability copyWith(void Function(Availability) updates) =>
      super.copyWith((message) => updates(message as Availability))
          as Availability;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Availability create() => Availability._();
  @$core.override
  Availability createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Availability getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Availability>(create);
  static Availability? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TimeSlot> get slots => $_getList(0);
}

/// Requests and Responses
class GetTherapistProfileRequest extends $pb.GeneratedMessage {
  factory GetTherapistProfileRequest({
    $core.String? id,
  }) {
    final result = create();
    if (id != null) result.id = id;
    return result;
  }

  GetTherapistProfileRequest._();

  factory GetTherapistProfileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTherapistProfileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTherapistProfileRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTherapistProfileRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTherapistProfileRequest copyWith(
          void Function(GetTherapistProfileRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetTherapistProfileRequest))
          as GetTherapistProfileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTherapistProfileRequest create() => GetTherapistProfileRequest._();
  @$core.override
  GetTherapistProfileRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetTherapistProfileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTherapistProfileRequest>(create);
  static GetTherapistProfileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);
}

class GetTherapistByUserIdRequest extends $pb.GeneratedMessage {
  factory GetTherapistByUserIdRequest({
    $core.String? userId,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetTherapistByUserIdRequest._();

  factory GetTherapistByUserIdRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetTherapistByUserIdRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetTherapistByUserIdRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTherapistByUserIdRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetTherapistByUserIdRequest copyWith(
          void Function(GetTherapistByUserIdRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GetTherapistByUserIdRequest))
          as GetTherapistByUserIdRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTherapistByUserIdRequest create() =>
      GetTherapistByUserIdRequest._();
  @$core.override
  GetTherapistByUserIdRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static GetTherapistByUserIdRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetTherapistByUserIdRequest>(create);
  static GetTherapistByUserIdRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class ListTherapistsRequest extends $pb.GeneratedMessage {
  factory ListTherapistsRequest({
    $0.PaginationRequest? pagination,
    $core.String? specialtyTag,
  }) {
    final result = create();
    if (pagination != null) result.pagination = pagination;
    if (specialtyTag != null) result.specialtyTag = specialtyTag;
    return result;
  }

  ListTherapistsRequest._();

  factory ListTherapistsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTherapistsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTherapistsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.therapist'),
      createEmptyInstance: create)
    ..aOM<$0.PaginationRequest>(1, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginationRequest.create)
    ..aOS(2, _omitFieldNames ? '' : 'specialtyTag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTherapistsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTherapistsRequest copyWith(
          void Function(ListTherapistsRequest) updates) =>
      super.copyWith((message) => updates(message as ListTherapistsRequest))
          as ListTherapistsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTherapistsRequest create() => ListTherapistsRequest._();
  @$core.override
  ListTherapistsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListTherapistsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTherapistsRequest>(create);
  static ListTherapistsRequest? _defaultInstance;

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
  $core.String get specialtyTag => $_getSZ(1);
  @$pb.TagNumber(2)
  set specialtyTag($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSpecialtyTag() => $_has(1);
  @$pb.TagNumber(2)
  void clearSpecialtyTag() => $_clearField(2);
}

class ListTherapistsResponse extends $pb.GeneratedMessage {
  factory ListTherapistsResponse({
    $core.Iterable<TherapistProfile>? therapists,
    $0.PaginationResponse? pagination,
  }) {
    final result = create();
    if (therapists != null) result.therapists.addAll(therapists);
    if (pagination != null) result.pagination = pagination;
    return result;
  }

  ListTherapistsResponse._();

  factory ListTherapistsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListTherapistsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListTherapistsResponse',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.therapist'),
      createEmptyInstance: create)
    ..pPM<TherapistProfile>(1, _omitFieldNames ? '' : 'therapists',
        subBuilder: TherapistProfile.create)
    ..aOM<$0.PaginationResponse>(2, _omitFieldNames ? '' : 'pagination',
        subBuilder: $0.PaginationResponse.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTherapistsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListTherapistsResponse copyWith(
          void Function(ListTherapistsResponse) updates) =>
      super.copyWith((message) => updates(message as ListTherapistsResponse))
          as ListTherapistsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListTherapistsResponse create() => ListTherapistsResponse._();
  @$core.override
  ListTherapistsResponse createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ListTherapistsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListTherapistsResponse>(create);
  static ListTherapistsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TherapistProfile> get therapists => $_getList(0);

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

class CreateTherapistProfileRequest extends $pb.GeneratedMessage {
  factory CreateTherapistProfileRequest({
    $core.String? userId,
    $core.String? bio,
    $core.String? specialty,
    $core.Iterable<$core.String>? qualifications,
    $core.int? yearsOfExperience,
    $core.String? consultationFee,
  }) {
    final result = create();
    if (userId != null) result.userId = userId;
    if (bio != null) result.bio = bio;
    if (specialty != null) result.specialty = specialty;
    if (qualifications != null) result.qualifications.addAll(qualifications);
    if (yearsOfExperience != null) result.yearsOfExperience = yearsOfExperience;
    if (consultationFee != null) result.consultationFee = consultationFee;
    return result;
  }

  CreateTherapistProfileRequest._();

  factory CreateTherapistProfileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CreateTherapistProfileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateTherapistProfileRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'bio')
    ..aOS(3, _omitFieldNames ? '' : 'specialty')
    ..pPS(4, _omitFieldNames ? '' : 'qualifications')
    ..aI(5, _omitFieldNames ? '' : 'yearsOfExperience')
    ..aOS(6, _omitFieldNames ? '' : 'consultationFee')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTherapistProfileRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateTherapistProfileRequest copyWith(
          void Function(CreateTherapistProfileRequest) updates) =>
      super.copyWith(
              (message) => updates(message as CreateTherapistProfileRequest))
          as CreateTherapistProfileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateTherapistProfileRequest create() =>
      CreateTherapistProfileRequest._();
  @$core.override
  CreateTherapistProfileRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static CreateTherapistProfileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateTherapistProfileRequest>(create);
  static CreateTherapistProfileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get bio => $_getSZ(1);
  @$pb.TagNumber(2)
  set bio($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBio() => $_has(1);
  @$pb.TagNumber(2)
  void clearBio() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get specialty => $_getSZ(2);
  @$pb.TagNumber(3)
  set specialty($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSpecialty() => $_has(2);
  @$pb.TagNumber(3)
  void clearSpecialty() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get qualifications => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get yearsOfExperience => $_getIZ(4);
  @$pb.TagNumber(5)
  set yearsOfExperience($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasYearsOfExperience() => $_has(4);
  @$pb.TagNumber(5)
  void clearYearsOfExperience() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get consultationFee => $_getSZ(5);
  @$pb.TagNumber(6)
  set consultationFee($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasConsultationFee() => $_has(5);
  @$pb.TagNumber(6)
  void clearConsultationFee() => $_clearField(6);
}

class UpdateTherapistProfileRequest extends $pb.GeneratedMessage {
  factory UpdateTherapistProfileRequest({
    $core.String? id,
    $core.String? bio,
    $core.String? specialty,
    $core.Iterable<$core.String>? qualifications,
    $core.int? yearsOfExperience,
    $core.bool? isVerified,
    $core.String? consultationFee,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (bio != null) result.bio = bio;
    if (specialty != null) result.specialty = specialty;
    if (qualifications != null) result.qualifications.addAll(qualifications);
    if (yearsOfExperience != null) result.yearsOfExperience = yearsOfExperience;
    if (isVerified != null) result.isVerified = isVerified;
    if (consultationFee != null) result.consultationFee = consultationFee;
    return result;
  }

  UpdateTherapistProfileRequest._();

  factory UpdateTherapistProfileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateTherapistProfileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateTherapistProfileRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'bio')
    ..aOS(3, _omitFieldNames ? '' : 'specialty')
    ..pPS(4, _omitFieldNames ? '' : 'qualifications')
    ..aI(5, _omitFieldNames ? '' : 'yearsOfExperience')
    ..aOB(6, _omitFieldNames ? '' : 'isVerified')
    ..aOS(7, _omitFieldNames ? '' : 'consultationFee')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTherapistProfileRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateTherapistProfileRequest copyWith(
          void Function(UpdateTherapistProfileRequest) updates) =>
      super.copyWith(
              (message) => updates(message as UpdateTherapistProfileRequest))
          as UpdateTherapistProfileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateTherapistProfileRequest create() =>
      UpdateTherapistProfileRequest._();
  @$core.override
  UpdateTherapistProfileRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpdateTherapistProfileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateTherapistProfileRequest>(create);
  static UpdateTherapistProfileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get bio => $_getSZ(1);
  @$pb.TagNumber(2)
  set bio($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBio() => $_has(1);
  @$pb.TagNumber(2)
  void clearBio() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get specialty => $_getSZ(2);
  @$pb.TagNumber(3)
  set specialty($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSpecialty() => $_has(2);
  @$pb.TagNumber(3)
  void clearSpecialty() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get qualifications => $_getList(3);

  @$pb.TagNumber(5)
  $core.int get yearsOfExperience => $_getIZ(4);
  @$pb.TagNumber(5)
  set yearsOfExperience($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasYearsOfExperience() => $_has(4);
  @$pb.TagNumber(5)
  void clearYearsOfExperience() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isVerified => $_getBF(5);
  @$pb.TagNumber(6)
  set isVerified($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsVerified() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsVerified() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get consultationFee => $_getSZ(6);
  @$pb.TagNumber(7)
  set consultationFee($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasConsultationFee() => $_has(6);
  @$pb.TagNumber(7)
  void clearConsultationFee() => $_clearField(7);
}

class MatchTherapistsRequest extends $pb.GeneratedMessage {
  factory MatchTherapistsRequest({
    $core.String? primaryConcern,
    $core.Iterable<$core.String>? preferredActivities,
  }) {
    final result = create();
    if (primaryConcern != null) result.primaryConcern = primaryConcern;
    if (preferredActivities != null)
      result.preferredActivities.addAll(preferredActivities);
    return result;
  }

  MatchTherapistsRequest._();

  factory MatchTherapistsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MatchTherapistsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MatchTherapistsRequest',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'resilio.therapist'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'primaryConcern')
    ..pPS(2, _omitFieldNames ? '' : 'preferredActivities')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MatchTherapistsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MatchTherapistsRequest copyWith(
          void Function(MatchTherapistsRequest) updates) =>
      super.copyWith((message) => updates(message as MatchTherapistsRequest))
          as MatchTherapistsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MatchTherapistsRequest create() => MatchTherapistsRequest._();
  @$core.override
  MatchTherapistsRequest createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MatchTherapistsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MatchTherapistsRequest>(create);
  static MatchTherapistsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get primaryConcern => $_getSZ(0);
  @$pb.TagNumber(1)
  set primaryConcern($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPrimaryConcern() => $_has(0);
  @$pb.TagNumber(1)
  void clearPrimaryConcern() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get preferredActivities => $_getList(1);
}

class TherapistServiceApi {
  final $pb.RpcClient _client;

  TherapistServiceApi(this._client);

  $async.Future<TherapistProfile> getProfile(
          $pb.ClientContext? ctx, GetTherapistProfileRequest request) =>
      _client.invoke<TherapistProfile>(
          ctx, 'TherapistService', 'GetProfile', request, TherapistProfile());
  $async.Future<TherapistProfile> getProfileByUserId(
          $pb.ClientContext? ctx, GetTherapistByUserIdRequest request) =>
      _client.invoke<TherapistProfile>(ctx, 'TherapistService',
          'GetProfileByUserId', request, TherapistProfile());
  $async.Future<ListTherapistsResponse> listProfiles(
          $pb.ClientContext? ctx, ListTherapistsRequest request) =>
      _client.invoke<ListTherapistsResponse>(ctx, 'TherapistService',
          'ListProfiles', request, ListTherapistsResponse());
  $async.Future<TherapistProfile> createProfile(
          $pb.ClientContext? ctx, CreateTherapistProfileRequest request) =>
      _client.invoke<TherapistProfile>(ctx, 'TherapistService', 'CreateProfile',
          request, TherapistProfile());
  $async.Future<TherapistProfile> updateProfile(
          $pb.ClientContext? ctx, UpdateTherapistProfileRequest request) =>
      _client.invoke<TherapistProfile>(ctx, 'TherapistService', 'UpdateProfile',
          request, TherapistProfile());
  $async.Future<ListTherapistsResponse> matchTherapists(
          $pb.ClientContext? ctx, MatchTherapistsRequest request) =>
      _client.invoke<ListTherapistsResponse>(ctx, 'TherapistService',
          'MatchTherapists', request, ListTherapistsResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
