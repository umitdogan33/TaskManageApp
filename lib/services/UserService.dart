import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:task_manage_app/repository/UserDao.dart';

class UserService {
  Future<void> addUser() async {
    return await UserDao().addUser();
  }
}
