import 'package:auto_route/auto_route.dart';
import 'package:luggage_organizer/global/presentation/routing/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/', page: SplashRoute.page),
  ];
}    