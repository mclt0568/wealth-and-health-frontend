import 'package:flutter/widgets.dart';
import 'package:wealth_and_health_frontend/page_login/login_page.dart';

import 'page_home/home_page.dart';

class AppRouter {
  static const initialRoute = "/";
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Uri uri = Uri.parse(settings.name ?? '/');

    // Home Page (Static)
    if (uri.path == '/') {
      return PageRouteBuilder(pageBuilder: (_, __, ___) => HomePage());
    }

    // Login Page (Static)
    if (uri.path == '/login') {
      return PageRouteBuilder(pageBuilder: (_, __, ___) => LoginPage());
    }

    // // Details Page (Dynamic with query parameters)
    // if (uri.path == '/details') {
    //   final queryParams = uri.queryParameters;
    //   String name = queryParams['name'] ?? 'Guest';
    //   int age = int.tryParse(queryParams['age'] ?? '0') ?? 0;

    //   return PageRouteBuilder(
    //     pageBuilder: (_, __, ___) => DetailsPage(name: name, age: age),
    //   );
    // }

    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => HomePage(),
    ); // Unknown route
  }
}
