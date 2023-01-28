import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:task_manage_app/core/components/AppDrawerWidget.dart';
import 'package:task_manage_app/core/guards/AuthGuard.dart';
import 'package:task_manage_app/core/utilities/PlatformDetect.dart';
import 'package:task_manage_app/routers/router.gr.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late Brightness brightness = SchedulerBinding.instance.window.platformBrightness;
  final _appRouter = AppRouter(authGuard: AuthGuard());
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        brightness: brightness,
      ),
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.amber[800],
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        context.pushRoute(PageRouteInfo("AddTaskRoute", path: "/addtask"));
      },
      child: Icon(Icons.add),
      ),
    );
  }
}
