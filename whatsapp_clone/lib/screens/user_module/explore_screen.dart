import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp_clone/bloc/users/user_bloc.dart';
import 'package:whatsapp_clone/bloc/users/user_event.dart';
import 'package:whatsapp_clone/bloc/users/user_state.dart';
import 'package:whatsapp_clone/models/user_model.dart';
import 'package:whatsapp_clone/screens/user_module/chat_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final searchController = TextEditingController();
  String filterSearch = '';

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Find new people",
                style: GoogleFonts.raleway(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    filterSearch = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search people',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),

                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(166, 238, 238, 238),
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is UserLoaded) {
                      List<UserModel> filteredUser = state.users;
                      if (filterSearch.isNotEmpty) {
                        filteredUser = state.users.where((user) {
                          return user.name.toLowerCase().contains(
                            filterSearch.toLowerCase(),
                          );
                        }).toList();
                      }
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 15);
                        },
                        itemCount: filteredUser.length,
                        itemBuilder: (context, index) {
                          final user = state.users[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatDetailScreen(user: user,),
                                ),
                              );
                            },
                            child: SizedBox(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage(
                                      'assets/images/male_icon.png',
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    user.name,
                                    style: GoogleFonts.raleway(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(child: Text("Error"));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
