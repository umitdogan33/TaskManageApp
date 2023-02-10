import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_manage_app/Views/ProfilePage.dart';
import 'package:task_manage_app/core/components/CustomAppBarWidget.dart';
import 'package:task_manage_app/core/components/CustomSnackBarWidget.dart';
import 'package:task_manage_app/models/UserModel.dart';
import 'package:task_manage_app/services/UserService.dart';

class PasswordEditPage extends StatefulWidget {
  const PasswordEditPage({super.key});

  @override
  State<PasswordEditPage> createState() => _PasswordEditPageState();
}

class _PasswordEditPageState extends State<PasswordEditPage> {
  final _fk = GlobalKey<FormState>();
    final _passwordController = TextEditingController();
    final _repeatPasswordController = TextEditingController();

    Future<void> changePassword() async{
      if(_fk.currentState!.validate()){
       final result =await  UserService().updatePassword(FirebaseAuth.instance.currentUser!.uid,_passwordController.text);
       result.when((success) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfilPage()));
        return;
       }, (error){
          CustomSnackBar().show(context, error.toString());
          throw Exception(error.toString());
       });
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Password",actions: [IconButton(onPressed: ()=>changePassword(), icon: Icon(Icons.check))],leading: IconButton(onPressed: () {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ProfilPage()));
      }, icon: Icon(Icons.arrow_back))),
      body: Form(key: _fk,child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:8.0,top: 15.0),
            child: const Text("use at least 8 characters"),
          ),Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your password";
                  } else if (value.length < 8) {
                    return "Password must be at least 8 characters";
                  }
                },
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Enter your new password",
                  labelText: "New Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
              ),
          ), Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your password";
                  } else if (value != _passwordController.text) {
                    return "Passwords do not match";
                  }
                },
                controller: _repeatPasswordController,
                decoration: InputDecoration(
                  hintText: "Enter repeat your new password",
                  labelText: "Repeat new Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
                       ),
             ),
        ],
      )),
    );
  }
}