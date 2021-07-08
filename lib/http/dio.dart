import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rejolute/util/app_utils.dart';
import 'package:rejolute/util/constant.dart';
import 'package:rejolute/util/preference_helper.dart';
import 'package:rejolute/util/string_resource.dart';
// import 'package:simple_connectivity/simple_connectivity.dart';

class DioHelper {
  Dio dio = Dio();

  DioHelper() {
    print("Initialize Dio");
    dio.options.baseUrl = Constants.BASE_URL;
    dio.options.followRedirects = true;
    dio.options.headers[HttpHeaders.acceptHeader] = "application/json";
    dio.options.headers["token"] =
        "eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz";
    dio.options.validateStatus = (status) => status! < 400;
    dio.transformer = JsonTransformer();
    //setup auth interceptor
    _setupAuthInterceptor();
    //setup log interceptor
    _setupLogInterceptor();
  }

  _setupAuthInterceptor() {
    // print("Initialize Dio Setup Interceptor");
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // check if token exists
          // String? token = await PreferenceHelper.getToken();
          // if (token == null) {
          //   //no token proceed with request
          //   return handler.next(options);
          //   // return options;
          // } else {
          //   options.headers[HttpHeaders.authorizationHeader] =
          //       "Bearer " + token;
          //   //return options;
          //
          // }
          return handler.next(options);
        },
        onError: (DioError error, handler) async {
          if (error.type == DioErrorType.response) {
            switch (error.response!.statusCode) {
              //case 400:
              //AppUtils.showToast(StringResource.CODE_400_ERROR);
              //break;
              case 401:
                //eventBus.fire(UnAuthenticatedEvent());
                break;
              case 402:
                AppUtils.showToast(StringResource.CODE_402_ERROR);
                break;
              case 403:
                AppUtils.showToast(StringResource.CODE_403_ERROR);
                break;
              case 404:
                AppUtils.showToast(StringResource.CODE_404_ERROR);
                break;
              case 405:
                AppUtils.showToast(StringResource.CODE_404_ERROR);
                break;
              case 413:
                AppUtils.showToast(StringResource.ERROR_413);
                break;
              case 419:
                AppUtils.showToast(StringResource.CODE_419_ERROR);
                break;
              case 429:
                AppUtils.showToast(StringResource.CODE_429_ERROR);
                break;
              case 500:
                AppUtils.showToast(StringResource.CODE_500_ERROR);
                break;
              case 502:
                AppUtils.showToast(StringResource.ERROR_502);
                break;
              case 503:
                AppUtils.showToast(StringResource.CODE_503_ERROR);
                break;
              case 504:
                AppUtils.showToast(error.error);
                break;
            }
          } else if (error.type == DioErrorType.other) {
            if (!await isNetworkAvailable()) {
              AppUtils.showToast(StringResource.CHECK_INTERNET_CONNECTION);
            }
          } else if (error.type == DioErrorType.connectTimeout) {
            AppUtils.showToast(StringResource.CONNECTION_TIME_OUT);
          } else {
            AppUtils.showToast(error.message);
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<bool> isNetworkAvailable() async {
    var connectionResult = await (Connectivity().checkConnectivity());
    if (connectionResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
    // return true;
  }

  _setupLogInterceptor() {
    // print("Initialize Dio log interceptor");
    if (DebugMode.isInDebugMode) {
      dio.interceptors.add(LogInterceptor(responseBody: true));
    }
  }
}

class JsonTransformer extends DefaultTransformer {
  JsonTransformer() : super(jsonDecodeCallback: _parseJson);
}

Map<String, dynamic> _parseAndDecode(String response) {
  if (response.startsWith('[') && response.endsWith(']')) {
    response = "{\"data\":" + response + "}";
  }
  return jsonDecode(response);
}

Future<Map<String, dynamic>> _parseJson(String text) {
  return compute(_parseAndDecode, text);
}

final Dio dio = DioHelper().dio;
