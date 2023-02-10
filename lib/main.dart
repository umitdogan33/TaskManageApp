import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manage_app/Views/AddTaskPage.dart';
import 'package:task_manage_app/Views/ProfilePage.dart';
import 'package:task_manage_app/Views/RegisterPage.dart';
import 'package:task_manage_app/core/components/AppDrawerWidget.dart';
import 'package:task_manage_app/core/components/CustomAppBarWidget.dart';
import 'package:task_manage_app/core/components/CustomSnackBarWidget.dart';
import 'package:task_manage_app/core/utilities/ErrorMessageHandle.dart';
import 'package:task_manage_app/models/TaskModel.dart';
import 'package:task_manage_app/services/LaunchSettings.dart';
import 'package:task_manage_app/services/TaskService.dart';
import 'package:task_manage_app/services/UserService.dart';
import 'package:url_strategy/url_strategy.dart';
import 'Views/LoginPage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy();
  runApp(MyApp());

  LaunchSettings().Settings();
}

class MyApp extends StatelessWidget {
  late Brightness brightness =
      SchedulerBinding.instance.window.platformBrightness;
  bool isLogin = UserService().isLogin();
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
      home: isLogin ? MyHomePage() : LoginPage(),
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
  bool isAdmin = FirebaseAuth.instance.currentUser!.uid == "GwF9MD0mUaXmyyskOLputrIwNGF3";

  Future<String> getUsername() async {
    var sp = SharedPreferences.getInstance();
    var username = (await sp).getString("username");
    return username ?? "Task manage app";
  }

  Future<List<TaskModel>> getAllTasks() async{
    final result = await TaskService().getAll();
    return result.when((success){
      return success;
    }, (error){
      CustomSnackBar().show(context, error);
      throw Exception(error.toString());
    });
  }

  Future<void> deleteTask(String id) async{
    final result =await  TaskService().delete(id);
    result.when((success){
      CustomSnackBar().show(context, "Task deleted!");
    }, (error) {
      CustomSnackBar().show(context, error);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  final rightDeleteIcon = Container(
  color: Colors.red,
  child: Icon(Icons.delete),
  alignment: Alignment.centerRight,
);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Solidev Task App", actions: [
        IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: ((context) => LoginPage())));
            },
            icon: Icon(Icons.logout))
      ]),
      drawer: FutureBuilder(
        future: getUsername(),
        builder: (context, snapshot) =>
            AppDrawer(username: snapshot.data.toString()),
      ),
      body: FutureBuilder(future: getAllTasks(),builder: (context, snapshot) {
        if(snapshot.hasData){
          return ListView.builder(itemBuilder: (context, index) {
            return Dismissible(
                background: rightDeleteIcon,
              key: ObjectKey(snapshot.data![index]),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                Text(snapshot.data![index].taskTitle,style: GoogleFonts.inter(fontWeight: FontWeight.bold),),
                Text(snapshot.data![index].taskDate.toString(),style: GoogleFonts.inter(fontWeight: FontWeight.bold),),
                        ],
                    ),
                    
                    Text(snapshot.data![index].taskDescription),
                  ],
                ),
              ),
              onDismissed: (direction) {
                deleteTask(snapshot.data![index].id.toString());
              },
            );
          }, itemCount: snapshot.data!.length,);
        }
        else{
          return Center(child: const CircularProgressIndicator());
        }
      },),
      floatingActionButton: Visibility(
        visible: isAdmin,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) => AddTaskPage())));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
