import 'package:auto_route/auto_route.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if(false){
      resolver.next();
    }
    else{
      router.push(PageRouteInfo("LoginRoute", path: "/login"));
    }
  }
  
}