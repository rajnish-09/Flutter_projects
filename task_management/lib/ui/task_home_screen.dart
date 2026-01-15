import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/auth/bloc/auth_bloc.dart';
import 'package:task_management/auth/bloc/auth_event.dart';
import 'package:task_management/auth/bloc/auth_state.dart';
import 'package:task_management/tasks/model/tasks_model.dart';
import 'package:task_management/tasks/task_service.dart';
import 'package:task_management/ui/task_form_screen.dart';
import 'package:task_management/utils/show_sackbar.dart';
import 'package:task_management/widgets/input_text_form_field.dart';

class TaskHomeScreen extends StatefulWidget {
  const TaskHomeScreen({super.key});

  @override
  State<TaskHomeScreen> createState() => _TaskHomeScreenState();
}

class _TaskHomeScreenState extends State<TaskHomeScreen> {
  final searchController = TextEditingController();
  TaskService taskService = TaskService();

  @override
  void initState() {
    super.initState();
    // context.read<TaskBloc>().add(LoadedTasks(data: data))
  }

  void logout(BuildContext context) {
    context.read<AuthBloc>().add(LogoutUser());
  }

  // void getTasks() {}

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthMessage) {
          return showSnackbar(context, state.message);
        }
      },
      child: Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.only(right: 20, bottom: 20),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TaskFormScreen()),
              );
              // print('presseed');
            },
            shape: CircleBorder(),
            child: Icon(Icons.add, color: Colors.black, size: 25),
          ),
        ),
        appBar: AppBar(
          title: Text("Task manager"),
          actions: [
            IconButton(
              onPressed: () {
                logout(context);
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                // SizedBox(height: 20),
                InputTextFormFIeld(
                  emailController: searchController,
                  icon: Icons.search,
                  hintText: 'Search tasks',
                ),
                SizedBox(height: 20),
                Flexible(
                  child: StreamBuilder<List<TasksModel>>(
                    stream: taskService.getTasksByUser(uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        debugPrint(snapshot.error.toString());
                        return Center(child: Text("Something went wrong."));
                      }

                      final tasks = snapshot.data ?? [];
                      if (tasks.isEmpty) {
                        return Center(child: Text("No data found."));
                      }
                      return ListView.builder(
                        // padding: EdgeInsets.zero,
                        // shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: BoxBorder.all(
                                color: const Color.fromARGB(255, 202, 202, 202),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.taskTitle,
                                  style: TextStyle(fontSize: 18),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  task.taskStatus,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: task.taskStatus == 'completed'
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
