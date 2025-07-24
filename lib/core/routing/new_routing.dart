import 'package:auto_route/auto_route.dart';
import 'package:user_profile/core/routing/new_routing.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
   AutoRoute(page: HomeRoute.page,),
   AutoRoute(page: ProfileRoute.page,  initial: true ,children: [
    //  AutoRoute(page: PersonalInfoFormRoute.page, initial: true),
    //  AutoRoute(page: UserImageRoute.page),
   ]),
   
  ];
}