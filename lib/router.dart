import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/authentication/authentication_bloc.dart';
import 'package:rejolute/screen/cart_screen/bloc/cart_screen_bloc.dart';
import 'package:rejolute/screen/cart_screen/bloc/cart_screen_event.dart';
import 'package:rejolute/screen/cart_screen/cart_screen.dart';
import 'package:rejolute/screen/product_screen/bloc/product_screen_bloc.dart';
import 'package:rejolute/screen/product_screen/bloc/product_screen_event.dart';
import 'package:rejolute/screen/product_screen/product_screen.dart';
import 'package:rejolute/screen/splash_screen.dart';
import 'package:rejolute/util/color_resource.dart';
import 'package:rejolute/util/route_aware_widget.dart';
import 'authentication/authentication_state.dart';

class AppRoutes {
  static const String SPLASH_SCREEN = "splash_screen";
  static const String PRODUCT_SCREEN = "product_screen";
  static const String CART_SCREEN = "cart_screen";
}

Route<dynamic>? getRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.SPLASH_SCREEN:
      return buildSplashScreen(settings);
    case AppRoutes.PRODUCT_SCREEN:
      return buildProductScreen(settings);
    case AppRoutes.CART_SCREEN:
      return buildCartScreen(settings);
  }
  return null;
}

Route buildSplashScreen(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildSplashScreen(settings)),
  );
}

Route buildProductScreen(RouteSettings settings) {
  return MaterialPageRoute(
    settings: RouteSettings(name: AppRoutes.PRODUCT_SCREEN),
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildProductScreen(settings)),
  );
}

Route buildCartScreen(RouteSettings settings) {
  return MaterialPageRoute(
    settings: RouteSettings(name: AppRoutes.CART_SCREEN),
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildCartScreen(settings)),
  );
}

class PageBuilder {
  static Widget buildSplashScreen(RouteSettings settings) {
    return SplashScreen();
  }

  static Widget buildProductScreen(RouteSettings settings) {
    return BlocProvider<ProductBloc>(
      create: (context) {
        return ProductBloc()..add(ProductInitialEvent());
      },
      child: RouteAwareWidget(AppRoutes.PRODUCT_SCREEN, child: ProductScreen()),
    );
  }

  static Widget buildCartScreen(RouteSettings settings) {
    return BlocProvider<CartBloc>(
      create: (context) {
        return CartBloc()..add(CartInitialEvent());
      },
      child: RouteAwareWidget(AppRoutes.CART_SCREEN, child: CartScreen()),
    );
  }
}

addAuthBloc(BuildContext context, Widget widget) {
  return BlocListener<AuthenticationBloc, AuthenticationState>(
    bloc: BlocProvider.of<AuthenticationBloc>(context),
    listener: (BuildContext context, AuthenticationState state) {
      if (state is AuthenticationSplashScreen) {
        Navigator.pushReplacementNamed(context, AppRoutes.SPLASH_SCREEN);
      }
      if (state is AuthenticationMedicalScreenSate) {
        Navigator.pushReplacementNamed(context, AppRoutes.PRODUCT_SCREEN);
      }
    },
    child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      builder: (context, state) {
        if (state is AuthenticationUninitializedState ||
            state is AuthenticationLoadingState) {
          return Container(color: ColorResource.BACKGROUND_WHITE);
        } else {
          return widget;
        }
      },
    ),
  );
}
