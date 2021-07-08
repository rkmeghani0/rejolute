import 'package:rejolute/util/base_equatable.dart';

class ProductState extends BaseEquatable {}

class ProductInitialState extends ProductState {
  final String? error;
  ProductInitialState({this.error});
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'ProductInitialState';
  }
}

class ProductLoadingState extends ProductState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'ProductLoadingState';
  }
}

class ProductUpdateState extends ProductState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'ProductUpdateState';
  }
}

class SuccessCartData extends ProductState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'SuccessCartData';
  }
}
