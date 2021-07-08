import 'package:flutter/material.dart';
import 'package:rejolute/util/debouncer.dart';

class MainUtils {
  static final MainUtils _singleton = MainUtils._internal();
  MainUtils._internal();
  factory MainUtils() {
    return _singleton;
  }
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final Debouncer searchOnDebouncer =
      new Debouncer(delay: new Duration(milliseconds: 1000));
  // FirebaseDynamicLinkHelper dynamicLinkHelper = FirebaseDynamicLinkHelper();
  // FirebaseAnalytics mainFirebaseAnalytics = FirebaseAnalytics();
}
