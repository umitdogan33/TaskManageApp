import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manage_app/Views/LoginPage.dart';
import 'package:task_manage_app/core/components/CustomAppBarWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manage_app/core/components/CustomSnackBarWidget.dart';
import 'package:task_manage_app/main.dart';
import 'package:task_manage_app/services/UserService.dart';
class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

   var tfEmail = TextEditingController();
  var tfPassword = TextEditingController();
  var tfFirstName = TextEditingController();
  var tfLastName = TextEditingController();

  var _fk = GlobalKey<FormState>();

   Future<void> register(BuildContext context) async {
    var auth = await FirebaseAuth.instance;
    if (_fk.currentState!.validate()) {
      final result = await UserService().addUser(tfFirstName.text,tfLastName.text,
          tfEmail.text, tfPassword.text);
      var sp = await SharedPreferences.getInstance();
      sp.setString("username", tfFirstName.text+" " +tfLastName.text);
      result.when((success){ Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));}, (error){
           CustomSnackBar().show(context, error.toString());
          });
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Register Page",actions: []),
      body: Form(
          key: _fk,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: "First Name",
                          hintText: "First Name",
                        ),
                        controller: tfFirstName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "First Name is required";
                          }
                        },
                      ),
                    ),
                     SizedBox(
                      width: 150,
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          labelText: "Last Name",
                          hintText: "Last Name",
                        ),
                        controller: tfLastName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Last Name is required";
                          }
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
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
                      onPressed: () => register(context),
                      child: Text(
                        "Register",
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
                          "Do you have an account? Login",
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }
}