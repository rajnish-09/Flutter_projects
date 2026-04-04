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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(height: 20),
                const Text(
                  "Browse categories",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xffF1F3FD),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Icon(
                          Icons.plumbing,
                          size: 50,
                          color: Color(0xff2554D8),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Plumbing",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 102, 102, 102),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xffF1F3FD),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Icon(
                          Icons.cleaning_services,
                          size: 50,
                          color: Color(0xff2554D8),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          "Cleaner",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 102, 102, 102),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  "Top Rated Nearby",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Expert professionals in your neighbourhood",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 152, 152, 152),
                  ),
                ),
                const SizedBox(height: 15),
                Stack(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://i.pinimg.com/736x/d4/f2/11/d4f21135ef0e52046309c324c8986df8.jpg',
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rajnish stha",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Occupation",
                              style: TextStyle(
                                fontSize: 12,
                                color: const Color.fromARGB(255, 125, 125, 125),
                              ),
                            ),
                            Text(
                              "Experience",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 125, 125, 125),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 15,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff005CAB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Book",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Stack(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://i.pinimg.com/736x/d4/f2/11/d4f21135ef0e52046309c324c8986df8.jpg',
                            width: 100,
                            height: 100,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Rajnish stha",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Occupation",
                              style: TextStyle(
                                fontSize: 12,
                                color: const Color.fromARGB(255, 125, 125, 125),
                              ),
                            ),
                            Text(
                              "Experience",
                              style: TextStyle(
                                color: const Color.fromARGB(255, 125, 125, 125),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      right: 0,
                      top: 15,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff005CAB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Book",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
