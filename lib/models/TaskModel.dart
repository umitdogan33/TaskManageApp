import 'package:task_manage_app/models/UserModel.dart';

class TaskModel {
  late String taskTitle;
  late String taskDescription;
  late DateTime taskDate;
  late bool taskStatus;
  TaskModel({
    required this.taskTitle,
    required this.taskDescription,
    required this.taskDate,
    required this.taskStatus,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["users"] as List;
    List<UserModel> users = jsonArray.map((i) => UserModel.fromJson(i)).toList();
    return TaskModel(
      taskTitle: json['tasktitle'],
      taskDescription: json['taskdescription'],
      taskDate: DateTime.parse(json['taskdate']),
      taskStatus: json['taskstatus'] as bool,
    );
  }


  

}
