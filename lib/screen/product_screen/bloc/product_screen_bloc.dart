import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/http/repository/product_repository.dart';
import 'package:rejolute/http/response/product_response/product_response.dart';
import 'package:rejolute/model/product_cart_data.dart';
import 'package:rejolute/screen/product_screen/bloc/product_screen_event.dart';
import 'package:rejolute/screen/product_screen/bloc/product_screen_state.dart';
import 'package:rejolute/util/preference_helper.dart';
import 'package:rejolute/util/string_resource.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  int currentPageProduct = 1;
  int lastPageProduct = 1;
  bool isLastPageProduct = false;
  bool isLoadingProduct = false;
  List<Product>? lstProductList = [];
  List<ProductCartData>? lstCartData = [];
  ProductBloc() : super(ProductInitialState());
  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is ProductInitialEvent) {
      List<ProductCartData>? tempCart = await PreferenceHelper.getCartData();
      if (tempCart != null) {
        lstCartData = tempCart;
      }
      this.add(ProductFirstTimeGetEvent());
    }
    if (event is ProductFirstTimeGetEvent) {
      currentPageProduct = 1;
      lastPageProduct = 1;
      isLastPageProduct = false;
      lstProductList!.clear();
      this.add(ProductGetEvent());
    }
    if (event is ProductAddCart) {
      Product objProd = lstProductList![event.index];
      var tempFound = false;
      if (lstCartData!.length > 0) {
        for (var i = 0; i < lstCartData!.length; i++) {
          ProductCartData cartOPbj = lstCartData![i];
          if (cartOPbj.id == objProd.id) {
            final newcartObj = cartOPbj;
            lstCartData![i] = newcartObj.copyWith(qty: newcartObj.qty! + 1);
            tempFound = true;
            break;
          }
        }
        if (!tempFound) {
          lstCartData!.add(ProductCartData(
              id: objProd.id,
              productObj: objProd,
              qty: 1,
              price: objProd.price));
        }
      } else {
        lstCartData!.add(ProductCartData(
            id: objProd.id, productObj: objProd, qty: 1, price: objProd.price));
      }
      //ßß print(jsonEncode(lstCartData));
      await PreferenceHelper.saveCartData(lstCartData);
      // print("Add to cart");
      yield SuccessCartData();
    }
    if (event is ProductGetEvent) {
      isLoadingProduct = true;
      yield ProductUpdateState();
      try {
        ProductResponse productResponse =
            await ProductRepository.getProductList(
          perPage: 10,
          page: currentPageProduct,
        );
        if (productResponse != null) {
          if (productResponse.status == 200) {
            if (productResponse.product != null) {
              if (productResponse.product?.length != 0) {
                lstProductList?.addAll(productResponse.product!.toList());
                if (productResponse.totalPage.toString() ==
                    currentPageProduct.toString()) {
                  isLastPageProduct = true;
                }
                currentPageProduct++;
              } else {
                isLastPageProduct = true;
              }
            } else {
              isLastPageProduct = true;
            }
          } else {
            yield ProductInitialState(
                error: StringResource.SOMETHING_WENT_WRONG);
            isLastPageProduct = true;
          }
        } else {
          isLastPageProduct = true;
        }
      } catch (e) {
        print(e);
        yield ProductInitialState(error: e.toString());
        isLastPageProduct = true;
      }
      isLoadingProduct = false;
      yield ProductUpdateState();
    }
    if (event is CartUpdateEvent) {
      List<ProductCartData>? tempCart = await PreferenceHelper.getCartData();
      if (tempCart != null) {
        lstCartData = tempCart;
      }
      yield ProductInitialState();
    }
  }
}
