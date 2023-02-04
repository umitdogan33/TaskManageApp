import 'dart:ffi';
import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiple_result/multiple_result.dart';

class TaskService {
  Future<Result<dynamic,String>> add(String taskTitle,String taskDescription,DateTime taskDate,bool taskStatus) async{
    try {
      var ref =FirebaseDatabase.instance.ref("tasks");
    var data = HashMap<String,dynamic>();
    data["tasktitle"] = taskTitle;
    data["taskdescription"] = taskDescription;
    data["taskdate"] = taskDate.toString();
    data["taskstatus"] = taskStatus;
    ref.push().set(data);

    return Success(Void);
    } catch (e) {
      return Error(e.toString());
    }
  }
}