import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manage_app/Views/RegisterPage.dart';
import 'package:task_manage_app/core/components/CustomAppBarWidget.dart';
import 'package:task_manage_app/core/components/CustomSnackBarWidget.dart';
import 'package:task_manage_app/main.dart';
import 'package:task_manage_app/models/UserModel.dart';
import 'package:task_manage_app/services/UserService.dart';

class LoginPage extends StatelessWidget {
  var tfEmail = TextEditingController();
  var tfPassword = TextEditingController();

  var _fk = GlobalKey<FormState>();
  Future<void> login(BuildContext context) async {
    var auth = await FirebaseAuth.instance;
    var sp =await SharedPreferences.getInstance();
    if (_fk.currentState!.validate()) {
      final result = await UserService().signIn(tfEmail.text, tfPassword.text);
      result.when((success) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));

      }, (error) {
        CustomSnackBar().show(context, error.toString());
      });
    }
  }

  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Login Page",
          actions: [],
        ),
        body: Form(
          key: _fk,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: "Email",
                        hintText: "Email",
                      ),
                      controller: tfEmail,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: "Password",
                        hintText: "Password",
                      ),
                      controller: tfPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }

                        if (value.length <= 8) {
                          return "Password must be greater than 8 characters";
                        }
                      },
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 50,
                // ),
                SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(168, 164, 206, 0.5)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () => login(context),
                      child: Text(
                        "Login",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: GestureDetector(
                        child: Text(
                          "New User? Create account",
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
