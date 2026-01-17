import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/tasks/bloc/task_bloc.dart';
import 'package:task_management/tasks/bloc/task_event.dart';
import 'package:task_management/tasks/bloc/task_state.dart';
import 'package:task_management/tasks/model/tasks_model.dart';
import 'package:task_management/utils/show_sackbar.dart';
import 'package:task_management/widgets/input_text_form_field.dart';
import 'package:task_management/widgets/submit_button.dart';

class TaskFormScreen extends StatefulWidget {
  final TasksModel? task;
  const TaskFormScreen({super.key, this.task});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  late TextEditingController taskTitleController;
  late TextEditingController taskContentController;

  @override
  void initState() {
    super.initState();
    taskTitleController = TextEditingController(
      text: widget.task?.taskTitle ?? '',
    );
    taskContentController = TextEditingController(
      text: widget.task?.taskDescription ?? '',
    );
    taskStatus = widget.task == null
        ? TaskStatus.pending
        : widget.task!.taskStatus == 'completed'
        ? TaskStatus.completed
        : TaskStatus.pending;
  }

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
                      textCapitalization: TextCapitalization.sentences,
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
                BlocConsumer<TaskBloc, TaskState>(
                  builder: (context, state) {
                    TaskStatus currentStatus = taskStatus!;
                    if (state is TaskStatusUpdated) {
                      currentStatus = state.status;
                    }
                    return Column(
                      children: [
                        RadioGroup<TaskStatus>(
                          groupValue: currentStatus,
                          onChanged: (value) {
                            // setState(() {
                            //   taskStatus = value;
                            // });
                            if (value != null) {
                              context.read<TaskBloc>().add(
                                TaskStatusChanged(status: value),
                              );
                            }
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
                          buttonText: widget.task == null ? 'Save' : 'Update',
                          onPressed: () async {
                            String taskTitle = taskTitleController.text.trim();
                            String taskDescription = taskContentController.text
                                .trim();
                            String taskString = currentStatus.name;
                            final value = TasksModel(
                              taskId: widget.task == null
                                  ? ''
                                  : widget.task!.taskId,
                              taskTitle: taskTitle,
                              taskDescription: taskDescription,
                              taskStatus: taskString,
                            );
                            if (widget.task == null) {
                              context.read<TaskBloc>().add(
                                SaveTask(tasksModel: value),
                              );
                              Navigator.pop(context);
                            }
                            if (widget.task != null) {
                              context.read<TaskBloc>().add(UpdateTask(value));
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    );
                  },
                  listener: (context, state) {
                    if (state is TaskUpdateSuccess) {
                      showSnackbar(context, state.successMessage);
                    }
                    if (state is TaskUpdateFailed) {
                      showSnackbar(context, state.failedMessage);
                    }
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

  @override
  void dispose() {
    super.dispose();
    taskTitleController.dispose();
    taskContentController.dispose();
  }
}
