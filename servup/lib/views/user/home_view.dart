import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Color(0xff2554D8)),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            const Text(
                              "Current location",
                              style: TextStyle(
                                color: Color.fromARGB(255, 115, 115, 115),
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "KATHMANDU",
                              style: TextStyle(
                                color: const Color(0xff2554D8),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://i.pinimg.com/1200x/65/a6/b1/65a6b1e427ebd1602eb779d40cb371cd.jpg',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: const Color.fromARGB(255, 136, 136, 136),
                    ),
                    hintText: "Search for 'Plumber', 'Electrician' ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color(0xffF1F3FD),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 20,),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
