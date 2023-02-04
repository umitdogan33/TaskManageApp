import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:task_manage_app/core/components/CustomAppBarWidget.dart';
import 'package:task_manage_app/core/components/CustomSnackBarWidget.dart';
import 'package:task_manage_app/models/UserModel.dart';
import 'package:task_manage_app/services/UserService.dart';

class UserNameEditPage extends StatefulWidget {
  UserNameEditPage({super.key});

  @override
  State<UserNameEditPage> createState() => _UserNameEditPageState();
}

class _UserNameEditPageState extends State<UserNameEditPage> {
  final _fk = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _surnameController = TextEditingController();

 Future<UserModel> getUser() async {
      final result =
          await UserService().getUserById("ofoSRoTGWDPv8C4K6sWSaSksYX43");
      return result.when((success) {
        _nameController.text = success.firstName;
        _surnameController.text = success.lastName;
        return success;
      }, (error) {
        CustomSnackBar().show(context, error.toString());
        throw Exception(error.toString());
      });
    }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
        appBar: CustomAppBar(
            title: "Edit Username",
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check))]),
        body: Form(
                key: _fk,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 15.0),
                      child: const Text("this is how we will address you"),
                    ),
                    SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _nameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your name";
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Enter your name",
                              labelText: "Name",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _surnameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your surname";
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Enter your surname",
                              labelText: "Surname",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            )),
                      ),
                    )
                  ],
                )
        )
    );
  }
}
