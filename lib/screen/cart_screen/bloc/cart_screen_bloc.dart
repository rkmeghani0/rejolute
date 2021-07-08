import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/event_bus/event_bus.dart';
import 'package:rejolute/model/product_cart_data.dart';
import 'package:rejolute/screen/cart_screen/bloc/cart_screen_event.dart';
import 'package:rejolute/screen/cart_screen/bloc/cart_screen_state.dart';
import 'package:rejolute/util/preference_helper.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<ProductCartData>? lstCartData = [];
  double grnadTotal = 0;
  CartBloc() : super(CartInitialState());
  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is CartInitialEvent) {
      yield CartLoadingState();
      List<ProductCartData>? tempCart = await PreferenceHelper.getCartData();
      if (tempCart != null) {
        lstCartData = tempCart;
      }
      for (var i = 0; i < lstCartData!.length; i++) {
        ProductCartData obj = lstCartData![i];
        var total = double.parse(obj.productObj!.price.toString()) * obj.qty!;
        grnadTotal = grnadTotal + total;
      }
      print(tempCart);
      yield CartInitialState();
    }
    if (event is CartRemoveItem) {
      lstCartData!.removeAt(event.index);
      grnadTotal = 0;
      for (var i = 0; i < lstCartData!.length; i++) {
        ProductCartData obj = lstCartData![i];
        var total = double.parse(obj.productObj!.price.toString()) * obj.qty!;
        grnadTotal = grnadTotal + total;
      }
      await PreferenceHelper.saveCartData(lstCartData);
      eventBus.fire(CartDataUpdateEvent());
      yield CartInitialState();
    }
  }
}
