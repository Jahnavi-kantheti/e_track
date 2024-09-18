import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee {
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? email;
  @JsonKey(name: 'nick_name')
  final String? nickName;
  final String? mobile;
  @JsonKey(name: 'profile_image')
  final String? profileImage;
  @JsonKey(name: 'user_friend_id')
  final String? userFriendId;
  @JsonKey(name: 'friend_type')
  final String? friendType;
  @JsonKey(name: 'dl_front')
  final String? dlFront;
  @JsonKey(name: 'dl_back')
  final String? dlBack;
  @JsonKey(name: 'joining_date')
  final String? joiningDate;
  @JsonKey(name: 'birth_date')
  final String? birthDate;
  @JsonKey(name: 'pan_id')
  final String? panId;
  @JsonKey(name: 'driving_licence_id')
  final String? drivingLicenceId;
  final String? gender;
  @JsonKey(name: 'p_front')
  final String? pFront;
  @JsonKey(name: 'blood_group')
  final String? bloodGroup;
  @JsonKey(name: 'driving_licence_issue_date')
  final String? drivingLicenceIssueDate;
  @JsonKey(name: 'driving_licence_expiry_date')
  final String? drivingLicenceExpiryDate;
  @JsonKey(name: 'driving_licence_issuing_authority')
  final String? drivingLicenceIssuingAuthority;
  @JsonKey(name: 'aadhar_number')
  final String? aadharNumber;
  @JsonKey(name: 'aadhar_front_image')
  final String? aadharFrontImage;
  @JsonKey(name: 'aadhar_back_image')
  final String? aadharBackImage;
  final String? status;
  @JsonKey(name: 'state_id')
  final String? stateId;
  @JsonKey(name: 'district_id')
  final String? districtId;
  @JsonKey(name: 'city_id')
  final String? cityId;
  final String? area;
  final String? pincode;
  final String? landmark;
  final String? address;
  final String? state;
  @JsonKey(name: 'district_name')
  final String? districtName;
  final String? city;
  @JsonKey(name: 'device_list')
  final List<dynamic>? deviceList;
  @JsonKey(name: 'country_id')
  final String? countryId;

  Employee({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.nickName,
    this.mobile,
    this.profileImage,
    this.userFriendId,
    this.friendType,
    this.dlFront,
    this.dlBack,
    this.joiningDate,
    this.birthDate,
    this.panId,
    this.drivingLicenceId,
    this.gender,
    this.pFront,
    this.bloodGroup,
    this.drivingLicenceIssueDate,
    this.drivingLicenceExpiryDate,
    this.drivingLicenceIssuingAuthority,
    this.aadharNumber,
    this.aadharFrontImage,
    this.aadharBackImage,
    this.status,
    this.stateId,
    this.districtId,
    this.cityId,
    this.area,
    this.pincode,
    this.landmark,
    this.address,
    this.state,
    this.districtName,
    this.city,
    this.deviceList,
    this.countryId,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
