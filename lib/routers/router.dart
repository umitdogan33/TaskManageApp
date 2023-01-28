import 'package:auto_route/annotations.dart';
import 'package:task_manage_app/Views/AddTaskPage.dart';
import 'package:task_manage_app/Views/LoginPage.dart';
import 'package:task_manage_app/core/guards/AuthGuard.dart';
import 'package:task_manage_app/main.dart';

@MaterialAutoRouter(
    replaceInRouteName: 'Page,Route',
    routes: <AutoRoute>[
      AutoRoute(page: MyHomePage, initial: true,name: "HomeRoute",path: '/'),
      AutoRoute(page: LoginPage,name: "LoginRoute",path: '/login'),
      AutoRoute(page: AddTaskPage,name: "AddTaskRoute",path: '/addtask',guards: [AuthGuard]),
    ],
)
class $AppRouter {}