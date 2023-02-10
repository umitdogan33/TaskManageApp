import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_manage_app/Views/AddTaskPage.dart';
import 'package:task_manage_app/Views/ProfilePage.dart';
import 'package:task_manage_app/Views/SettingsPage.dart';
import 'package:task_manage_app/core/utilities/PlatformDetect.dart';
import 'package:task_manage_app/main.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key,required this.username});
  late String username;

  @override
  Widget build(BuildContext context) {
       return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.orangeAccent
          ),
          child: Text(
            "$username",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
          child: ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskPage()));
          },
          child: ListTile(
            leading: Icon(Icons.task),
            title: Text('Add Task'),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilPage()));
          },
          child: ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
          },
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ),
      ],
    ),
  );
  }
}