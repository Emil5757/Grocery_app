import 'package:latlong2/latlong.dart';

/// A delivery address. Used by checkout, Delivery Address, New Address and
/// Order Tracking, so it lives in `common/`. Mock addresses: `AddressData`.
class AddressModel {
  const AddressModel({
    required this.title,
    required this.address,
    required this.phone,
    this.fullName = '',
    this.city = '',
    this.state = '',
    this.zipCode = '',
    this.location = chhatak,
  });

  /// First line: "Puraton Custom, Chhatak".
  final String title;

  /// Second line: "216/c East Road".
  final String address;
  final String phone;
  final String fullName;
  final String city;
  final String state;
  final String zipCode;

  /// Map position (OpenStreetMap). Demo addresses sit around Chhatak.
  final LatLng location;

  static const LatLng chhatak = LatLng(25.0287, 91.6566);
}
