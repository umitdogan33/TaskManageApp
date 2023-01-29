import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiple_result/multiple_result.dart';
class UserDao {
  Future<void> addUser() async {
     try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: "umit9551@gmail.com",
    password: "Deneme123",
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    throw  Exception('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
     throw Exception('The account already exists for that email.');
  }
}
  throw Exception('unknown error');
  }
}