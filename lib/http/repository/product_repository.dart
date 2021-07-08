import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rejolute/http/dio.dart';
import 'package:rejolute/http/http_urls.dart';
import 'package:rejolute/http/response/product_response/product_response.dart';

class ProductRepository {
  static Future<ProductResponse> getProductList({
    int page = 1,
    int perPage = 10,
  }) async {
    ProductResponse accountLabelResponse;

    try {
      Response response = await dio.post(HttpUrls.productList, data: {
        "page": page,
        "perPage": perPage,
      });
      accountLabelResponse = ProductResponse.fromJson(response.data);
    } on DioError catch (error) {
      accountLabelResponse = ProductResponse.fromJson(error.response!.data);
    }

    return accountLabelResponse;
  }
}
