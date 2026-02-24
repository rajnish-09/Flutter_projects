import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_clone/bloc/group/group_bloc.dart';
import 'package:whatsapp_clone/bloc/group/group_event.dart';
import 'package:whatsapp_clone/bloc/group/group_state.dart';
import 'package:whatsapp_clone/models/group_model.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/screens/user_module/chat_list_screen.dart';
import 'package:whatsapp_clone/screens/user_module/main_navigation_screen.dart';
import 'package:whatsapp_clone/services/firebase_service.dart';
import 'package:whatsapp_clone/widgets/show_toast.dart';

class GroupDetailScreen extends StatefulWidget {
  final GroupModel group;

  const GroupDetailScreen({super.key, required this.group});

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: BlocListener<GroupBloc, GroupState>(
          listener: (context, state) {
            if (state is Groupleaved) {
              showToastWidget('Group leaved successfully.', Colors.green);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/male_icon.png'),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  widget.group.groupName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              FutureBuilder<UserModel>(
                future: FirebaseService().getChatUser(widget.group.createdBy),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Creator",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(snapshot.data!.name),
                      ],
                    );
                  }
                  return SizedBox(child: Text("Error"));
                },
              ),
              SizedBox(height: 30),
              Text(
                "Members",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final userId = widget.group.members[index];
                    return FutureBuilder<UserModel>(
                      future: FirebaseService().getChatUser(userId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data!.name);
                        }
                        return SizedBox();
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: widget.group.members.length,
                ),
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    context.read<GroupBloc>().add(
                      LeaveGroup(groupId: widget.group.groupId!),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainNavigationScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Leave group",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
