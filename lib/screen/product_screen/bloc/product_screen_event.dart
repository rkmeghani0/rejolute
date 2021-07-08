import 'package:rejolute/util/base_equatable.dart';

class ProductEvent extends BaseEquatable {}

class ProductInitialEvent extends ProductEvent {
  @override
  String toString() {
    return "ProductInitialEvent";
  }
}

class ProductFirstTimeGetEvent extends ProductEvent {
  @override
  String toString() {
    return "ProductFirstTimeGetEvent";
  }
}

class ProductGetEvent extends ProductEvent {
  @override
  String toString() {
    return "ProductGetEvent";
  }
}

class ProductAddCart extends ProductEvent {
  final int index;
  ProductAddCart(this.index);
  @override
  String toString() {
    return "ProductAddCart";
  }
}

class CartUpdateEvent extends ProductEvent {
  @override
  String toString() {
    return "CartUpdateEvent";
  }
}
