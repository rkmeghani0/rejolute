import 'package:flutter/widgets.dart';
import 'package:rejolute/http/response/product_response/product_response.dart';

class ProductCartData {
  int? id;
  Product? productObj;
  int? qty;
  dynamic price;
  ProductCartData({
    @required this.id,
    @required this.productObj,
    @required this.qty,
    @required this.price,
  });
  ProductCartData copyWith({
    int? id,
    Product? productObj,
    int? qty,
    dynamic price,
  }) {
    return ProductCartData(
      id: id ?? this.id,
      productObj: productObj ?? this.productObj,
      qty: qty ?? this.qty,
      price: price ?? this.price,
    );
  }

  ProductCartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productObj = json['productObj'] != null
        ? Product.fromJson(json['productObj'])
        : null;
    qty = json['qty'];
    price = json['price'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['qty'] = qty;
    data['price'] = price;
    if (productObj != null) {
      data['productObj'] = productObj!.toJson();
    }
    return data;
    // return {
    //   'id': id,
    //   'productObj': productObj,
    //   'qty': qty,
    //   'price': price,
    // };
  }
}
