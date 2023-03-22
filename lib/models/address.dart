import 'enums/geolocation.dart';

class Address {
  String street;
  GeoLocation location;
  String landmark;
  String city;
  String pincode;
  String state;

  Address(
      {required this.street,
      required this.location,
      required this.landmark,
      required this.city,
      required this.pincode,
      required this.state});
}
