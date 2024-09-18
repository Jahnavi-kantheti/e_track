// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      userId: json['user_id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      nickName: json['nick_name'] as String?,
      mobile: json['mobile'] as String?,
      profileImage: json['profile_image'] as String?,
      userFriendId: json['user_friend_id'] as String?,
      friendType: json['friend_type'] as String?,
      dlFront: json['dl_front'] as String?,
      dlBack: json['dl_back'] as String?,
      joiningDate: json['joining_date'] as String?,
      birthDate: json['birth_date'] as String?,
      panId: json['pan_id'] as String?,
      drivingLicenceId: json['driving_licence_id'] as String?,
      gender: json['gender'] as String?,
      pFront: json['p_front'] as String?,
      bloodGroup: json['blood_group'] as String?,
      drivingLicenceIssueDate: json['driving_licence_issue_date'] as String?,
      drivingLicenceExpiryDate: json['driving_licence_expiry_date'] as String?,
      drivingLicenceIssuingAuthority:
          json['driving_licence_issuing_authority'] as String?,
      aadharNumber: json['aadhar_number'] as String?,
      aadharFrontImage: json['aadhar_front_image'] as String?,
      aadharBackImage: json['aadhar_back_image'] as String?,
      status: json['status'] as String?,
      stateId: json['state_id'] as String?,
      districtId: json['district_id'] as String?,
      cityId: json['city_id'] as String?,
      area: json['area'] as String?,
      pincode: json['pincode'] as String?,
      landmark: json['landmark'] as String?,
      address: json['address'] as String?,
      state: json['state'] as String?,
      districtName: json['district_name'] as String?,
      city: json['city'] as String?,
      deviceList: json['device_list'] as List<dynamic>?,
      countryId: json['country_id'] as String?,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'user_id': instance.userId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'nick_name': instance.nickName,
      'mobile': instance.mobile,
      'profile_image': instance.profileImage,
      'user_friend_id': instance.userFriendId,
      'friend_type': instance.friendType,
      'dl_front': instance.dlFront,
      'dl_back': instance.dlBack,
      'joining_date': instance.joiningDate,
      'birth_date': instance.birthDate,
      'pan_id': instance.panId,
      'driving_licence_id': instance.drivingLicenceId,
      'gender': instance.gender,
      'p_front': instance.pFront,
      'blood_group': instance.bloodGroup,
      'driving_licence_issue_date': instance.drivingLicenceIssueDate,
      'driving_licence_expiry_date': instance.drivingLicenceExpiryDate,
      'driving_licence_issuing_authority':
          instance.drivingLicenceIssuingAuthority,
      'aadhar_number': instance.aadharNumber,
      'aadhar_front_image': instance.aadharFrontImage,
      'aadhar_back_image': instance.aadharBackImage,
      'status': instance.status,
      'state_id': instance.stateId,
      'district_id': instance.districtId,
      'city_id': instance.cityId,
      'area': instance.area,
      'pincode': instance.pincode,
      'landmark': instance.landmark,
      'address': instance.address,
      'state': instance.state,
      'district_name': instance.districtName,
      'city': instance.city,
      'device_list': instance.deviceList,
      'country_id': instance.countryId,
    };
