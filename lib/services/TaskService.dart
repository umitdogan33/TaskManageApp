import 'dart:ffi';
import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:task_manage_app/models/TaskModel.dart';
import 'package:task_manage_app/services/DeviceIdService.dart';

class TaskService {
  Future<Result<dynamic,String>> add(String taskTitle,String taskDescription,String taskDate,bool taskStatus) async{
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

  Future<Result<List<TaskModel>,String>> getAll() async{
    List<TaskModel> datas = [];
    try {
     await FirebaseDatabase.instance.ref("tasks").once().then((value){
      var data = value.snapshot.value as dynamic;
      print(data);
      if(data != null){
        data.forEach((key,nesne){
          datas.add(TaskModel.fromJson(nesne,key));
        });
      }
     });
     
     return Success(datas);
    } catch (e) {
      return Error(e.toString());
    }
    }

    Future<Result<dynamic,String>> delete(String key) async{
      try {
        await FirebaseDatabase.instance.ref("tasks").child(key).remove();
        return Success(Void);
      } catch (e) {
        return Error(e.toString());
      }
    }
  }