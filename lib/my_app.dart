import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/authentication/authentication_bloc.dart';
import 'package:rejolute/router.dart';
import 'package:rejolute/util/app_utils.dart';
import 'package:rejolute/util/color_resource.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthenticationBloc? authenticationBloc;
  @override
  void initState() {
    super.initState();
    AppUtils.hideKeyBoard(context);
  }

  @override
  Widget build(BuildContext context) {
    //this.initDynamicLinks(this.context);
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return MaterialApp(
      theme: Theme.of(context).copyWith(
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
            brightness: Brightness.light,
            backgroundColor: ColorResource.BACKGROUND_WHITE),
      ),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        routeObserver,
      ],
      onGenerateRoute: getRoute,
      home: addAuthBloc(
        context,
        Container(color: ColorResource.BACKGROUND_WHITE),
      ),
    );
  }
}
