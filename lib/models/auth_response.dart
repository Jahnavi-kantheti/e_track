import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  final bool? status;
  final String? message;
  final List<AuthData>? data;

  AuthResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable()
class AuthData {
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'user_code')
  final String? userCode;
  @JsonKey(name: 'user_name')
  final String? userName;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? email;
  final String? password;
  @JsonKey(name: 'mobile_code')
  final String? mobileCode;
  final String? mobile;
  @JsonKey(name: 'profile_image')
  final String? profileImage;
  @JsonKey(name: 'state_id')
  final String? stateId;
  @JsonKey(name: 'district_id')
  final String? districtId;
  @JsonKey(name: 'city_id')
  final String? cityId;
  final String? address1;
  final String? address2;
  final String? areaName;
  final String? zipcode;
  final String? latitude;
  final String? longitude;
  @JsonKey(name: 'user_type')
  final String? userType;
  @JsonKey(name: 'register_date')
  final String? registerDate;
  @JsonKey(name: 'referral_code')
  final String? referralCode;
  @JsonKey(name: 'wallet_balance')
  final String? walletBalance;
  @JsonKey(name: 'notify_pref')
  final String? notifyPref;
  final String? deviceType;
  final String? deviceName;
  final String? appVersion;
  final String? deviceOs;
  final String? status;
  @JsonKey(name: 'dl_number')
  final String? dlNumber;
  @JsonKey(name: 'dl_front')
  final String? dlFront;
  @JsonKey(name: 'dl_back')
  final String? dlBack;
  @JsonKey(name: 'is_corporate')
  final String? isCorporate;
  final String? screenName;
  @JsonKey(name: 'bus_organisation_id')
  final String? busOrganisationId;
  @JsonKey(name: 'bus_organisation_branch_id')
  final String? busOrganisationBranchId;
  @JsonKey(name: 'bus_organisation_role')
  final String? busOrganisationRole;
  @JsonKey(name: 'access_type')
  final String? accessType;
  @JsonKey(name: 'parent_id')
  final String? parentId;
  @JsonKey(name: 'is_slotted_vehicle_analysis')
  final String? isSlottedVehicleAnalysis;
  @JsonKey(name: 'slot_time')
  final String? slotTime;
  @JsonKey(name: 'selected_columns')
  final String? selectedColumns;
  @JsonKey(name: 'trip_selected_columns')
  final String? tripSelectedColumns;
  @JsonKey(name: 'is_tofa_trip_data')
  final String? isTofaTripData;
  @JsonKey(name: 'is_trailer_dashboard')
  final String? isTrailerDashboard;
  @JsonKey(name: 'mobile_launch_mode')
  final String? mobileLaunchMode;
  @JsonKey(name: 'home_tab')
  final String? homeTab;
  @JsonKey(name: 'mobile_list_type')
  final String? mobileListType;
  final String? state;
  @JsonKey(name: 'district_name')
  final String? districtName;
  final String? city;
  @JsonKey(name: 'registered_by_type')
  final String? registeredByType;
  @JsonKey(name: 'registered_by_id')
  final String? registeredById;
  @JsonKey(name: 'company_id')
  final String? companyId;
  @JsonKey(name: 'company_name')
  final String? companyName;
  @JsonKey(name: 'company_logo')
  final String? companyLogo;
  @JsonKey(name: 'company_state_id')
  final String? companyStateId;
  @JsonKey(name: 'company_district_id')
  final String? companyDistrictId;
  @JsonKey(name: 'company_city_id')
  final String? companyCityId;
  @JsonKey(name: 'company_address1')
  final String? companyAddress1;
  @JsonKey(name: 'company_landmark')
  final String? companyLandmark;
  @JsonKey(name: 'company_address2')
  final String? companyAddress2;
  @JsonKey(name: 'company_pincode')
  final String? companyPincode;
  @JsonKey(name: 'company_email')
  final String? companyEmail;
  @JsonKey(name: 'company_mobile')
  final String? companyMobile;
  @JsonKey(name: 'company_state')
  final String? companyState;
  @JsonKey(name: 'company_district_name')
  final String? companyDistrictName;
  @JsonKey(name: 'company_city')
  final String? companyCity;

  AuthData({
    this.userId,
    this.userCode,
    this.userName,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.mobileCode,
    this.mobile,
    this.profileImage,
    this.stateId,
    this.districtId,
    this.cityId,
    this.address1,
    this.address2,
    this.areaName,
    this.zipcode,
    this.latitude,
    this.longitude,
    this.userType,
    this.registerDate,
    this.referralCode,
    this.walletBalance,
    this.notifyPref,
    this.deviceType,
    this.deviceName,
    this.appVersion,
    this.deviceOs,
    this.status,
    this.dlNumber,
    this.dlFront,
    this.dlBack,
    this.isCorporate,
    this.screenName,
    this.busOrganisationId,
    this.busOrganisationBranchId,
    this.busOrganisationRole,
    this.accessType,
    this.parentId,
    this.isSlottedVehicleAnalysis,
    this.slotTime,
    this.selectedColumns,
    this.tripSelectedColumns,
    this.isTofaTripData,
    this.isTrailerDashboard,
    this.mobileLaunchMode,
    this.homeTab,
    this.mobileListType,
    this.state,
    this.districtName,
    this.city,
    this.registeredByType,
    this.registeredById,
    this.companyId,
    this.companyName,
    this.companyLogo,
    this.companyStateId,
    this.companyDistrictId,
    this.companyCityId,
    this.companyAddress1,
    this.companyLandmark,
    this.companyAddress2,
    this.companyPincode,
    this.companyEmail,
    this.companyMobile,
    this.companyState,
    this.companyDistrictName,
    this.companyCity,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) => _$AuthDataFromJson(json);
  Map<String, dynamic> toJson() => _$AuthDataToJson(this);
}
