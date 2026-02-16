import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                "Chats",
                style: GoogleFonts.raleway(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search chats',
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
              SizedBox(height: 20),
              SizedBox(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                        'assets/images/male_icon.png',
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          "Name",
                          style: GoogleFonts.raleway(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Msgt",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
