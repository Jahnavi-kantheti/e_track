
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserResponse {
    @JsonKey(name: "id")
    int id;
    @JsonKey(name: "name")
    String name;
    @JsonKey(name: "username")
    String username;
    @JsonKey(name: "email")
    String email;
    @JsonKey(name: "address")
    Address address;
    @JsonKey(name: "phone")
    String phone;
    @JsonKey(name: "website")
    String website;
    @JsonKey(name: "company")
    Company company;

    UserResponse({
        required this.id,
        required this.name,
        required this.username,
        required this.email,
        required this.address,
        required this.phone,
        required this.website,
        required this.company,
    });

    factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

    Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class Address {
    @JsonKey(name: "street")
    String street;
    @JsonKey(name: "suite")
    String suite;
    @JsonKey(name: "city")
    String city;
    @JsonKey(name: "zipcode")
    String zipcode;
    @JsonKey(name: "geo")
    Geo geo;

    Address({
        required this.street,
        required this.suite,
        required this.city,
        required this.zipcode,
        required this.geo,
    });

    factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

    Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Geo {
    @JsonKey(name: "lat")
    String lat;
    @JsonKey(name: "lng")
    String lng;

    Geo({
        required this.lat,
        required this.lng,
    });

    factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);

    Map<String, dynamic> toJson() => _$GeoToJson(this);
}

@JsonSerializable()
class Company {
    @JsonKey(name: "name")
    String name;
    @JsonKey(name: "catchPhrase")
    String catchPhrase;
    @JsonKey(name: "bs")
    String bs;

    Company({
        required this.name,
        required this.catchPhrase,
        required this.bs,
    });

    factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);

    Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
