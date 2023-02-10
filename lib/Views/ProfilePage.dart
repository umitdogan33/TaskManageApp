import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manage_app/Views/LoginPage.dart';
import 'package:task_manage_app/Views/PasswordEditPage.dart';
import 'package:task_manage_app/Views/UserNameEditPage.dart';
import 'package:task_manage_app/core/components/CustomAppBarWidget.dart';
import 'package:task_manage_app/core/components/CustomSnackBarWidget.dart';
import 'package:task_manage_app/main.dart';
import 'package:task_manage_app/models/UserModel.dart';
import 'package:task_manage_app/services/UserService.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late Brightness brightness = SchedulerBinding.instance.window.platformBrightness;
  late bool isDark = brightness == Brightness.dark;
  Future<UserModel> getUser() async{
    final result =await UserService().getUserById(FirebaseAuth.instance.currentUser!.uid);
    return result.when((success){
      return success;
    }, (error){
      CustomSnackBar().show(context, error.toString());
      throw Exception(error.toString());
    });
  }

  Future<void> deleteAccount() async{
    final result = await UserService().deleteUser(FirebaseAuth.instance.currentUser!.uid);
    result.when((success){
      CustomSnackBar().show(context, "Account deleted");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }, (error){
      CustomSnackBar().show(context, error.toString());
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile", actions: [],leading: IconButton(onPressed: () {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MyHomePage()));
      }, icon: Icon(Icons.arrow_back))),
      body:FutureBuilder(builder: (context, snapshot) {
        if(snapshot.hasData){
          return Column(
        children: [
          Expanded(
            flex: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserNameEditPage()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 12, left: 8, right: 8, top: 12),
                child: Container(
                    decoration: BoxDecoration(
                        color:isDark ?Color.fromARGB(255, 53, 53, 53) : Color.fromARGB(255, 238, 238, 238)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("Ad Soyad"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.edit),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            snapshot.data!.firstName + " " + snapshot.data!.lastName,
                            style:
                                GoogleFonts.inter(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 12, left: 8, right: 8, top: 12),
              child: Container(
                  decoration:
                      BoxDecoration(color: isDark ?Color.fromARGB(255, 53, 53, 53) : Color.fromARGB(255, 238, 238, 238)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("E posta"),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          snapshot.data!.email,
                          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Expanded(
            flex: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PasswordEditPage()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 12, left: 8, right: 8, top: 12),
                child: Container(
                    decoration: BoxDecoration(
                        color: isDark ?Color.fromARGB(255, 53, 53, 53) : Color.fromARGB(255, 238, 238, 238)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("Password"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.edit),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            snapshot.data!.password,
                            style:
                                GoogleFonts.inter(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => deleteAccount(),
              child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Delete account",
              style: GoogleFonts.inter(
                  fontSize: 15, fontWeight: FontWeight.w500, color: Colors.red),
            ),
          ))
        ],
      );
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      }, future: getUser(),),
       
    );
  }
}
