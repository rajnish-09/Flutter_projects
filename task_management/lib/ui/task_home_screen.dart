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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // SizedBox(height: 20),
                  InputTextFormFIeld(
                    emailController: searchController,
                    icon: Icons.search,
                    hintText: 'Search tasks',
                  ),
                  SizedBox(height: 15),
                  StreamBuilder<List<TasksModel>>(
                    stream: taskService.getTasksByUser(uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text("Something went wrong."));
                      }

                      final tasks = snapshot.data ?? [];
                      if (tasks.isEmpty) {
                        return Center(child: Text("No data found."));
                      }
                      return ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return ListTile(
                            title: Text(task.taskTitle),
                            subtitle: Text(task.taskStatus),
                            subtitleTextStyle: TextStyle(
                              color: task.taskStatus == 'completed'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
