import 'package:ecommerce_app/bloc/category/category_bloc.dart';
import 'package:ecommerce_app/bloc/category/category_event.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:ecommerce_app/service/image_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void chooseImageUploadOption() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Choose Upload Option"),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    imageService.pickImageFromCamera();
                  },
                  label: Text("Camera"),
                  icon: Icon(Icons.camera),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    imageService.pickImageFromGallery();
                  },
                  label: Text("Gallery"),
                  icon: Icon(Icons.browse_gallery_sharp),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showCategoryBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
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
              ElevatedButton.icon(
                label: Text("Upload image"),
                icon: Icon(Icons.upload),
                onPressed: () {
                  chooseImageUploadOption();
                },
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                ),
                onPressed: () {
                  final category = CategoryModel(
                    code: 'hw13',
                    name: nameController.text.trim(),
                    imagePath: imageController.text.trim(),
                  );
                  context.read<CategoryBloc>().add(
                    AddCategory(category: category),
                  );
                  Navigator.pop(context);
                },
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
