import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rejolute/model/product_cart_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  // get a current user token
  static Future<String?> getToken() async {
    String? value;
    SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.get("token") as String?;
    if (value?.isEmpty ?? true) {
      return null;
    } else {
      return value;
    }
  }

  // save current user token
  static saveToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (token == null) return;
    pref.setString("token", token);
  }

  // save Cart Value
  static saveCartData(List<ProductCartData>? user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (user != null) {
      //String userObj = jsonEncode(user).toString();
      pref.setStringList(
          "cartData", _mapTodoData(user)); //.setString("cartData", userObj);
    }
  }

  static List<String> _mapTodoData(List<ProductCartData> todos) {
    try {
      var res = todos.map((v) => json.encode(v)).toList();
      return res;
    } catch (err) {
      // Just in case
      return [];
    }
  }

  //Get Cart Valiue
  static Future<List<ProductCartData>> getCartData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // print(pref.getStringList("cartData"));
    return _decodeTodoData(pref.getStringList("cartData"));
  }

  static List<ProductCartData> _decodeTodoData(List<String>? todos) {
    // try {
    //Transforming List<String> to Json
    var result = todos!.map((v) => json.decode(v)).toList();
    // print(result);
    //Transforming the Json into Array<Todo>
    var todObjects = result.map((v) => ProductCartData.fromJson(v)).toList();
    // print(todObjects);
    return todObjects;
    // } catch (error) {
    //   return [];
    // }
  }

  // Clear a storage
  static clearStorage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.clear();
  }

  // Clear previous user history
  static clearPreviousUserHistory() async {
    //SharedPreferences pref = await SharedPreferences.getInstance();
    //await pref.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("previousUserToken", "");
    pref.setString("previousUser", "");
  }

  static Map<String, dynamic> _parseAndDecode(String response) {
    return jsonDecode(response);
  }

  static Future<Map<String, dynamic>> _parseJson(String text) {
    return compute(_parseAndDecode, text);
  }

  static Future prefSetInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static Future<int?> prefGetInt(String key, int intDef) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getInt(key) != null) {
      return prefs.getInt(key);
    } else {
      return intDef;
    }
  }

  //bool
  static Future prefSetBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool?> prefGetBool(String key, bool boolDef) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(key) != null) {
      return prefs.getBool(key);
    } else {
      return boolDef;
    }
  }

  //String
  static Future prefSetString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String?> prefGetString(String key, String strDef) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) != null) {
      return prefs.getString(key);
    } else {
      return strDef;
    }
  }

  //Double
  static Future prefSetDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  static Future<double?> prefGetDouble(String key, double douDef) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getDouble(key) != null) {
      return prefs.getDouble(key);
    } else {
      return douDef;
    }
  }
}
