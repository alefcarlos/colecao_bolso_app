import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './auth_page.dart';

class AuthRoute {
  static String authRoute = '/auth';

  static final authHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return AuthPage();
  });

  static void configureRoutes(Router router) {
    router.define(authRoute, handler: authHandler);
  }
}
