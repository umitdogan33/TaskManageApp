import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_manage_app/core/components/CustomSnackBarWidget.dart';
import 'package:task_manage_app/main.dart';
import 'package:task_manage_app/services/TaskService.dart';

class AddTaskPage extends StatefulWidget {
  AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  bool isConfirm = false;
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final _fk = GlobalKey<FormState>();

  final userController = TextEditingController();

  final dueDateController = TextEditingController();

  Future<void> add() async {
    if (_fk.currentState!.validate()) {
      final result =await TaskService().add(
          titleController.text, descriptionController.text, selectedDate,true);

      result.when((success){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
      }, (error){
        CustomSnackBar().show(context, error.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
        backgroundColor: Colors.amber[800],
      ),
      body: Form(
        key: _fk,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a title";
                        }
                        return null;
                      },
                      controller: titleController,
                      decoration: InputDecoration(hintText: "Task Title"),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  SizedBox(
                    width: 150,
                    child: TextFormField(
                      controller: descriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a description";
                        }
                        return null;
                      },
                      decoration: InputDecoration(hintText: "Description"),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Icon(Icons.punch_clock),
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
              Row(
                children: [
                  Checkbox(
                    value: isConfirm,
                    onChanged: (value) {
                      setState(() {
                        isConfirm = value!;
                      });
                    },
                  ),
                  Text(
                    "I declare that I will not change the task",
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () =>add(),
                  child: Text(
                    "Add Task",
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
