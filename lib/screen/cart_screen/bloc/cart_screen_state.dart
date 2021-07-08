import 'package:rejolute/util/base_equatable.dart';

class CartState extends BaseEquatable {}

class CartInitialState extends CartState {
  final String? error;
  CartInitialState({this.error});
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'CartInitialState';
  }
}

class CartLoadingState extends CartState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'CartLoadingState';
  }
}
