import 'package:rejolute/util/base_equatable.dart';

class CartEvent extends BaseEquatable {}

class CartInitialEvent extends CartEvent {
  @override
  String toString() {
    return "CartInitialEvent";
  }
}

class CartRemoveItem extends CartEvent {
  final int index;
  CartRemoveItem(this.index);
  @override
  String toString() {
    return "CartRemoveItem";
  }
}
