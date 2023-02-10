import 'dart:collection';
import 'dart:ffi';
import 'package:firebase_admin/testing.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_admin/src/app/app.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:task_manage_app/models/UserModel.dart';

class UserService {
 Future<Result<dynamic, String>> updatePassword(
      String userId, String password) async {
    try {
      var ref = FirebaseDatabase.instance.ref().child("users/$userId");
      var data = HashMap<String, dynamic>();
      data["password"] = password;
      return Success(ref.update(data));
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Result<dynamic, String>> updateUsername(
      String userId, String firstName,String lastName) async {
    try {
      var ref = FirebaseDatabase.instance.ref().child("users/$userId");
      var data = HashMap<String, dynamic>();
      data["firstname"] = firstName;
      data["lastname"] = lastName;
      return Success(ref.update(data));
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Result<UserModel, String>> getUserById(String userId) async {
    try {
      final snapshot =
        await FirebaseDatabase.instance.ref().child("users/$userId").get();
    if (snapshot.exists) {
      if(snapshot.value == null){
        return Error("User not found");
      }
      final data = snapshot.value as dynamic;
      return Success(UserModel.fromJson(data));
    } else {
      return Error("User not found");
    }
    } catch (e) {
      return Error(e.toString());
    }
    
  }
  

  Future<Result<dynamic, String>> addUser( String firstName, String lastName, String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.toString(),
        password: password.toString(),
      );
      ;
      var db = FirebaseDatabase.instance
          .ref()
          .child("users/${credential.user!.uid}/")
          .set({
        "firstname": firstName,
        "lastname": lastName,
        "email": email,
        "password": password,
      });
      return Result.success(Void);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Result.error('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return Result.error('The account already exists for that email.');
      } else {
        return Result.error(e.toString());
      }
    }
  }

  Future<Result<dynamic, String>> signIn(String email, String password) async {
    try {
      var instance = await FirebaseAuth.instance;
      await instance
          .signInWithEmailAndPassword(email: email, password: password);
      final userResult = await getUserById(instance.currentUser!.uid);
     return userResult.when((success){return Success(Void);}, (error){return Error(error.toString());});

    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Result<dynamic, String>> deleteUser(String userId) async {
    try {
      var ref = FirebaseDatabase.instance.ref().child("users/$userId");
      ref.remove();
      return Success(Void);
    } catch (e) {
      return Error(e.toString());
    }
  }

  bool isLogin() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
