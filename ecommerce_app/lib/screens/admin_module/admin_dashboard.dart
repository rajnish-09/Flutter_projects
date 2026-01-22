import 'package:ecommerce_app/service/image_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  ImageService imageService = ImageService();

  void showCategoryBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Text(
                "Add category",
                style: GoogleFonts.raleway(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Category name',
                ),
              ),
              TextFormField(
                controller: imageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Image',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  imageService.pickImageFromGallery();
                },
                child: Row(
                  children: [
                    Icon(Icons.upload),
                    SizedBox(width: 10),
                    Text("Upload image"),
                  ],
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                ),
                onPressed: () {},
                child: Text("Add category"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                ),
                onPressed: () {
                  showCategoryBottomSheet();
                },
                child: Text("Add category"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
