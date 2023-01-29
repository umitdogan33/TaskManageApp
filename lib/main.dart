import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:task_manage_app/core/components/AppDrawerWidget.dart';
import 'package:task_manage_app/core/components/CustomAppBarWidget.dart';
import 'package:task_manage_app/core/guards/AuthGuard.dart';
import 'package:task_manage_app/core/utilities/ErrorMessageHandle.dart';
import 'package:task_manage_app/repository/UserDao.dart';
import 'package:task_manage_app/routers/router.gr.dart';
import 'package:task_manage_app/services/UserService.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // var refTest = FirebaseDatabase.instance.ref().child("test");
  // var bilgi = HashMap<String,dynamic>();
  // bilgi["isim"] = "Mehmet";
  // refTest.push().set(bilgi);
  
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
   Future<void> deneme() async{
     await UserService().addUser();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Solidev Task App",),
      drawer: AppDrawer(),
      body: FutureBuilder(future: deneme(),builder: (context, snapshot) {
        if(snapshot.hasData){
          return Text("Data");
        }else{
          return Text(ErrorMessageHandle().getiste(snapshot.error.toString()));
        }
        
      },),
      floatingActionButton: FloatingActionButton(onPressed: (){
        context.pushRoute(PageRouteInfo("AddTaskRoute", path: "/addtask"),);
      },
      child: Icon(Icons.add),
      ),
    );
  }
}
