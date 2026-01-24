import 'package:ecommerce_app/bloc/category/category_bloc.dart';
import 'package:ecommerce_app/bloc/category/category_event.dart';
import 'package:ecommerce_app/bloc/uploadImage/upload_bloc.dart';
import 'package:ecommerce_app/bloc/uploadImage/upload_event.dart';
import 'package:ecommerce_app/bloc/uploadImage/upload_state.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    imageController.dispose();
  }

  void chooseImageUploadOption() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Choose Upload Option"),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      imageService.pickImageFromCamera();
                    },
                    label: Text("Camera"),
                    icon: Icon(Icons.camera),
                  ),
                  SizedBox(width: 10),
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
          ),
        );
      },
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Loading..."),
              ],
            ),
          ),
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
          child: BlocListener<UploadBloc, UploadState>(
            listener: (context, state) {
              if (state is UploadingImage) {
                showLoadingDialog(context);
              }
              if (state is UploadedImage) {
                imageController.text = state.imgUrl;
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Image Uploaded Successfully!")),
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Form(
                key: _formKey,
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
                      validator: (value) {
                        if (nameController.text.isEmpty) {
                          return 'Please enter a category name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: imageController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Image',
                            ),
                            readOnly: true,
                          ),
                        ),
                        ElevatedButton.icon(
                          label: Text("Upload image"),
                          icon: Icon(Icons.upload),
                          onPressed: () {
                            // chooseImageUploadOption();
                            context.read<UploadBloc>().add(UploadImage());
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (imageController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please upload an image first"),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom +
                                      20, // Adjust for keyboard
                                  left: 20,
                                  right: 20,
                                ),
                              ),
                            );
                            return; // Stop execution
                          }
                          final category = CategoryModel(
                            code: 'hw13',
                            name: nameController.text.trim(),
                            imagePath: imageController.text.trim(),
                          );
                          context.read<CategoryBloc>().add(
                            AddCategory(category: category),
                          );
                          Navigator.pop(context);
                          nameController.clear();
                          imageController.clear();
                        }
                      },
                      child: Text(
                        "Add category",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //     shape: RoundedRectangleBorder(),
              //   ),
              //   onPressed: () {
              //     showCategoryBottomSheet();
              //   },
              //   child: Text("Add category"),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      showCategoryBottomSheet();
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Products",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
