import 'package:latlong2/latlong.dart';

import '../models/address_model.dart';

/// Mock saved addresses (no backend yet), all around Chhatak.
abstract final class AddressData {
  static const List<AddressModel> saved = [
    AddressModel(
      title: 'Puraton Custom, Chhatak',
      address: '216/c East Road',
      phone: '+8801710071000',
      location: LatLng(25.022583, 91.660773),
    ),
    AddressModel(
      title: 'Thana Ghat Road, Chhatak',
      address: '216/c East Road',
      phone: '+8801710071000',
      location: LatLng(25.021419, 91.663286),
    ),
    AddressModel(
      title: 'Bus Stand, Chhatak',
      address: '216/c East Road',
      phone: '+8801710071000',
      location: LatLng(25.030254, 91.661022),
    ),
  ];
}
