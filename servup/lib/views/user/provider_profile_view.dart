import 'package:flutter/material.dart';

class ProviderProfileView extends StatefulWidget {
  const ProviderProfileView({super.key});

  @override
  State<ProviderProfileView> createState() => _ProviderProfileViewState();
}

class _ProviderProfileViewState extends State<ProviderProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffD5E3FC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              onPressed: () {},
              label: Text("Contact"),
              icon: Icon(Icons.message),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff005CAB),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              onPressed: () {},
              label: Text(
                "Book Service",
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(Icons.add_task_sharp, color: Colors.white),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    child: Image.network(
                      'https://i.pinimg.com/736x/24/0c/87/240c87fd1b538f4ddec59755a143132b.jpg',
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 15,
                    left: 15,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.share, color: Colors.black),
                    ),
                  ),
                  Positioned(
                    bottom: 110,
                    left: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffFFDDB8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.verified, size: 18),
                          const SizedBox(width: 5),
                          Text(
                            "VERIFIED",
                            style: TextStyle(
                              color: Color(0xff352109),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 70,
                    left: 20,
                    child: Text(
                      "Rajesh Hamal",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 20,
                    child: Text(
                      "Electrician",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 50,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xffE7EAED),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '4.9',
                            style: TextStyle(
                              color: Color(0xff825100),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "RATING",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff4C535E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 20),
                    const Text(
                      "About the professional",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "Experience: ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 131, 131, 131),
                          ),
                        ),
                        Text(
                          "2 Years",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 131, 131, 131),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0xffF1F3FD),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        "lksdjflksdjfkldsjflksdjflksdjfsdklfjldskjf skdlfjls lksjf klsdfkl sdjflk sj skdj fkllsdjf klsdjflksdj lkdsjlkf dsalkl jflksdjflkdsj",
                        style: TextStyle(
                          color: const Color.fromARGB(255, 113, 113, 113),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.monetization_on_rounded),
                              SizedBox(width: 10),
                              Text(
                                "Service Rates",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Hourly Rate",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 131, 131, 131),
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Rs. ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '500',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Consultation Fee",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 131, 131, 131),
                                ),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: "Rs. ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '100',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          const Text(
                            "Final quote provided after inspection.",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 135, 135, 135),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Recent Reviews",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius:
                                    25, // half of your previous width/height
                                backgroundImage: NetworkImage(
                                  'https://i.pinimg.com/736x/67/d5/de/67d5deb0a676fc6467ec67c51e27d2a1.jpg',
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rakesh stha",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "2 days ago",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: const Color.fromARGB(
                                        255,
                                        121,
                                        121,
                                        121,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Text("****"),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "He is very professional. He fixed the issue with ease and in time.",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 109, 109, 109),
                            ),
                          ),
                        ],
                      ),
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
