import 'package:task_manage_app/models/UserModel.dart';
import 'package:intl/intl.dart';
class TaskModel {
  late String id;
  late String taskTitle;
  late String taskDescription;
  late String taskDate;
  late bool taskStatus;
  TaskModel({
    required this.taskTitle,
    required this.taskDescription,
    required this.taskDate,
    required this.taskStatus,
    required this.id
  });

  factory TaskModel.fromJson(Map<dynamic, dynamic> json, String id) {
    return TaskModel(
      taskTitle: json['tasktitle'],
      taskDescription: json['taskdescription'],
      // taskDate: DateTime.parse(json['taskdate']),
      taskDate:  DateFormat.yMMMEd().format(DateTime.parse(json['taskdate'])),
      taskStatus: json['taskstatus'] as bool,
      id: id
    );
  }


  

}
