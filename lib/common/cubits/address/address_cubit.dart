import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/address_model.dart';

class AddressState {
  const AddressState({required this.addresses, this.selected = 0});

  final List<AddressModel> addresses;
  final int selected;

  AddressModel? get current =>
      addresses.isEmpty ? null : addresses[selected.clamp(0, addresses.length - 1)];
}

/// Saved delivery addresses. Checkout, Delivery Address, New Address and
/// Order Tracking all read or change them, so the Cubit is app-wide
/// (provided above `MaterialApp`).
class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(const AddressState(addresses: AddressModel.saved));

  void select(int index) =>
      emit(AddressState(addresses: state.addresses, selected: index));

  void add(AddressModel address, {bool makeDefault = false}) {
    final list = [...state.addresses, address];
    emit(AddressState(
      addresses: list,
      selected: makeDefault ? list.length - 1 : state.selected,
    ));
  }

  void update(int index, AddressModel address) {
    final list = [...state.addresses]..[index] = address;
    emit(AddressState(addresses: list, selected: state.selected));
  }

  void remove(int index) {
    final list = [...state.addresses]..removeAt(index);
    var selected = state.selected;
    if (index < selected || selected >= list.length) selected = (selected - 1).clamp(0, list.length);
    emit(AddressState(addresses: list, selected: selected));
  }
}
