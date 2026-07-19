import 'package:flutter/material.dart';
import 'package:restaurants_menu/features/cart/presentation/pages/cart_screen.dart';
import 'package:restaurants_menu/features/cart/presentation/pages/cart_submitted_screen.dart';
import 'package:restaurants_menu/features/chat/presentation/pages/message_screen.dart';
import 'package:restaurants_menu/features/home/presentation/pages/home_screen.dart';
import 'package:restaurants_menu/features/home/presentation/pages/welcome_screen.dart';
import 'package:restaurants_menu/features/product/presentation/page/product_details_screen.dart';
import 'package:restaurants_menu/features/review/presentation/pages/review_screen.dart';
import '../features/auth/presentation/pages/login_screen.dart';
import '../features/splash/page/splash_screen.dart';

class RouteName {
  RouteName._();

  static const splash = "splash";
  static const onBoard = "onBoard";
  static const login = "login";
  static const welcome = "welcome";
  static const home = "home";
  static const rate = "rate";
  static const cart = "cart";
  static const productDetails = "productDetails";
  static const cartSubmitted = "cartSubmitted";
  static const message = "message";
}

class RouteManager {
  RouteManager._();

  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteName.splash:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const SplashScreen(),
        );     case RouteName.message:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const MessageScreen(),
        );
      case RouteName.cart:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) =>
              CartScreen(arg: routeSettings.arguments as CartScreenParams),
        );
      case RouteName.cartSubmitted:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CartSubmittedScreen(
            arg: routeSettings.arguments as CartSubmittedScreenParams,
          ),
        );
      case RouteName.welcome:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const WelcomeScreen(),
        );

      // case RouteName.onBoard:
      //   return MaterialPageRoute(builder: (_) => OnBoardScreen());
      //
      case RouteName.login:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const LoginScreen(),
        );
      case RouteName.home:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const HomeScreen(),
        );
      case RouteName.rate:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const ReviewScreen(),
        );
      case RouteName.productDetails:
        return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailsScreen(
            args: routeSettings.arguments as ProductDetailsScreenParams,
          ),
        );
      // case RouteName.signup:
      //   return MaterialPageRoute(builder: (_) => SignUpScreen());
      //
      // case RouteName.homeNav:
      //   return MaterialPageRoute(builder: (_) => NavBarScreen());
      //
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
