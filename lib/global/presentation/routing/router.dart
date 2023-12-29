import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/', page: SplashRoute.page),
    AutoRoute(path: '/signIn', page: SignInRoute.page),
    AutoRoute(
        path: '/authorized',
        page: AuthorizedRoute.page,
        children: [
          RedirectRoute(path: '', redirectTo: 'tripsOverview'),
          AutoRoute(path: 'tripsOverview', page: TripsOverviewRoute.page),
          AutoRoute(path: 'tripEdit', page: TripEditRoute.page),
          AutoRoute(path: 'wizard', page: WizardStartRoute.page),
          AutoRoute(path: 'menu', page: MenuRoute.page),
        ]
    )
  ];
}    