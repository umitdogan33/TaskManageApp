import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manage_app/Views/PasswordEditPage.dart';
import 'package:task_manage_app/Views/UserNameEditPage.dart';
import 'package:task_manage_app/core/components/CustomAppBarWidget.dart';
import 'package:task_manage_app/core/components/CustomSnackBarWidget.dart';
import 'package:task_manage_app/models/UserModel.dart';
import 'package:task_manage_app/services/UserService.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile", actions: []),
      body: Column(
        children: [
          Expanded(
            flex: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserNameEditPage()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 12, left: 8, right: 8, top: 12),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 238, 238, 238)),
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
                            "Ümit Doğan",
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
                      BoxDecoration(color: Color.fromARGB(255, 238, 238, 238)),
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
                          "Ümit Doğan",
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PasswordEditPage()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 12, left: 8, right: 8, top: 12),
                child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 238, 238, 238)),
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
                            "Ümit Doğan",
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
              child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Delete account",
              style: GoogleFonts.inter(
                  fontSize: 15, fontWeight: FontWeight.w500, color: Colors.red),
            ),
          ))
        ],
      ),
    );
  }
}
