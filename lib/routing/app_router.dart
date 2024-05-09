import 'package:homer/common_libs.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
)
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: CleanerRoute.page),
        AutoRoute(page: HomeRoute.page, initial: true),
      ];
}
