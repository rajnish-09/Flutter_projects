import 'package:flutter/material.dart';
import 'package:servup/utils/app_colors.dart';
import 'package:servup/widgets/custom_button.dart';

class BookNowScreen extends StatefulWidget {
  const BookNowScreen({super.key});

  @override
  State<BookNowScreen> createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  DateTime selectedDateTime = DateTime.now().add(const Duration(days: 1));
  TimeOfDay? selectedTime;
  final problemController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios, color: Color(0xff305DDA)),
        title: const Text(
          "Book Service",
          style: TextStyle(
            color: Color(0xff305DDA),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://i.pinimg.com/736x/84/8f/b0/848fb0fca7b9407a86d4bd598455008d.jpg',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Occupation",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "By Rajnish Shrestha",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff696E78),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Rs. 1000",
                            style: const TextStyle(
                              color: Color(0xff035EAB),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Base Price",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xff696E78),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Select date",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${selectedDateTime.day}/${selectedDateTime.month}/${selectedDateTime.year}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff595F6A),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 30),
                            ),
                          );
                          if (picked != null) {
                            setState(() {
                              selectedDateTime = picked;
                            });
                          }
                        },
                        child: Text("Change"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Problem Description",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: problemController,
                  maxLines: 5,
                  minLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Describe your problem',
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Price Your Offer",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your offer price',
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffF1F3FD),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 5),
                          const Text(
                            "Service Address",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Kirtipur, Panga Buspark",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      TextButton.icon(
                        onPressed: () {},
                        label: Text("Change location"),
                        icon: Icon(Icons.location_on),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Payment method",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/money_icon.png',
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Cash after direct service",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Pay directly to service provider",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff595F6A),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/wallet_icon.png',
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Esewa",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "Secure digital wallet payment",
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff595F6A),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(buttonText: "Request Service"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTimeContainer extends StatelessWidget {
  const CustomTimeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        "09:00 AM",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
