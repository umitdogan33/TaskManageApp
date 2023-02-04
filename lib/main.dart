import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manage_app/Views/AddTaskPage.dart';
import 'package:task_manage_app/Views/ProfilePage.dart';
import 'package:task_manage_app/Views/RegisterPage.dart';
import 'package:task_manage_app/core/components/AppDrawerWidget.dart';
import 'package:task_manage_app/core/components/CustomAppBarWidget.dart';
import 'package:task_manage_app/core/utilities/ErrorMessageHandle.dart';
import 'package:task_manage_app/services/LaunchSettings.dart';
import 'package:task_manage_app/services/UserService.dart';
import 'package:url_strategy/url_strategy.dart';
import 'Views/LoginPage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // var refTest = FirebaseDatabase.instance.ref().child("test");
  // var bilgi = HashMap<String,dynamic>();
  // bilgi["isim"] = "Ahmet";
  // refTest.push().set(bilgi);
  
  setPathUrlStrategy();
  runApp(MyApp());

  LaunchSettings().Settings();
}

class MyApp extends StatelessWidget{
  late Brightness brightness = SchedulerBinding.instance.window.platformBrightness;
  bool isLogin =UserService().isLogin();
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.amber,
        brightness: brightness,
      ),
      home:LoginPage(),
      //isLogin ? MyHomePage() : LoginPage()    
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var username = FirebaseAuth.instance.currentUser!.displayName;
   Future<String> getUsername() async{
    var sp = SharedPreferences.getInstance();
    var username = (await sp).getString("username");
    return username!;
  }

  
Future<void> deneme2() async{
  await OneSignal.shared.postNotification(OSCreateNotification(
    playerIds: ["9bd117de-12e4-4491-ae22-fe20e11618a6"],
    content: "Hello, this is a test notification",
    heading: "Test Notification",
));
   }
   @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: CustomAppBar(title: "Solidev Task App",actions: [IconButton(onPressed: (){}, icon: Icon(Icons.logout))]),
      drawer: FutureBuilder(future: getUsername(),builder: (context, snapshot) => AppDrawer(username: snapshot.data.toString()),),
      body: Center(),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => AddTaskPage())));
      },
      child: Icon(Icons.add),
      ),
    );
  }
}
