import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manage_app/core/components/CustomAppBarWidget.dart';

class LoginPage extends StatelessWidget {
  final tfEmail = TextEditingController();
  final tfPassword = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _fk = GlobalKey<FormState>();
    return Scaffold(
        appBar: CustomAppBar(
          title: "Login Page",
        ),
        body: Form(
          key: _fk,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: "Email",
                        hintText: "Email",
                        border: OutlineInputBorder(),
                      ),
                      controller: tfEmail,
                      validator: (value) {
                        if (value == null) {
                          return "Email is required";
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        labelText: "Password",
                        hintText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      controller: tfPassword,
                      validator: (value) {
                        if (value == null) {
                          return "Password is required";
                        }

                        if (value.length <= 8) {
                          return "Password must be greater than 8 characters";
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
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
                      onPressed: () {},
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
                      padding: const EdgeInsets.only(top:25.0),
                      child: GestureDetector(child: Text("New User? Create account",),onTap: (){
                        context.pushRoute(PageRouteInfo("RegisterRoute", path: "/register"));
                      },),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
