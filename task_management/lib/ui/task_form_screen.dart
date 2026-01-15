
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/tasks/bloc/task_bloc.dart';
import 'package:task_management/tasks/bloc/task_event.dart';
import 'package:task_management/tasks/bloc/task_state.dart';
import 'package:task_management/tasks/model/tasks_model.dart';
import 'package:task_management/utils/show_sackbar.dart';
import 'package:task_management/widgets/input_text_form_field.dart';
import 'package:task_management/widgets/submit_button.dart';

enum TaskStatus { completed, pending }

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final taskTitleController = TextEditingController();
  final taskContentController = TextEditingController();
  TaskStatus? taskStatus;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskBloc, TaskState>(
      listener: (context, state) {
        if (state is TaskSaveSuccess) {
          showSnackbar(context, 'Task saved successfully');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(height: 20),
                InputTextFormFIeld(
                  emailController: taskTitleController,
                  icon: Icons.task,
                  hintText: 'Enter task title',
                ),
                SizedBox(height: 15),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(117, 0, 0, 0),
                          offset: Offset(-4, 4),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.top,
                      controller: taskContentController,
                      decoration: InputDecoration(
                        hintText: 'Enter task description',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        fillColor: const Color.fromRGBO(255, 255, 255, 1),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                ),
                RadioGroup<TaskStatus>(
                  groupValue: taskStatus,
                  onChanged: (value) {
                    setState(() {
                      taskStatus = value;
                    });
                  },
                  child: Column(
                    children: [
                      RadioListTile(
                        value: TaskStatus.completed,
                        title: Text(
                          "Completed",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      RadioListTile(
                        value: TaskStatus.pending,
                        title: Text("Pending"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                SubmitButton(
                  buttonText: 'Save',
                  onPressed: () async {
                    String taskTitle = taskTitleController.text.trim();
                    String taskDescription = taskContentController.text.trim();
                    String taskString = taskStatus?.name ?? 'pending';
                    // final uid = FirebaseAuth.instance.currentUser!.uid;
                    final value = TasksModel(
                      taskTitle: taskTitle,
                      taskDescription: taskDescription,
                      taskStatus: taskString,
                      // creatorId: uid,
                    );
                    context.read<TaskBloc>().add(SaveTask(tasksModel: value));
                    Navigator.pop(context);
                  },
                ),
                // BlocListener<TaskBloc, TaskState>(
                //   listener: (context, state) {
                //     if (state is TaskSaveSuccess) {
                //       showSnackbar(context, 'Task saved successfully');
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
