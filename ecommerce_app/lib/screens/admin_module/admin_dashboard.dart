import 'package:ecommerce_app/bloc/auth/auth_bloc.dart';
import 'package:ecommerce_app/bloc/auth/auth_event.dart';
import 'package:ecommerce_app/bloc/auth/auth_state.dart';
import 'package:ecommerce_app/bloc/category/category_bloc.dart';
import 'package:ecommerce_app/bloc/category/category_event.dart';
import 'package:ecommerce_app/bloc/category/category_state.dart';
import 'package:ecommerce_app/bloc/product/product_bloc.dart';
import 'package:ecommerce_app/bloc/product/product_event.dart';
import 'package:ecommerce_app/bloc/product/product_state.dart';
import 'package:ecommerce_app/bloc/uploadImage/upload_bloc.dart';
import 'package:ecommerce_app/bloc/uploadImage/upload_event.dart';
import 'package:ecommerce_app/bloc/uploadImage/upload_state.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/screens/admin_module/add_product_screen.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:ecommerce_app/service/image_service.dart';
import 'package:ecommerce_app/widgets/show_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(FetchCategories());
    context.read<ProductBloc>().add(FetchProduct());
  }

  void deleteDialogBox(BuildContext context, ProductModel product) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Do you want to delete?"),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                context.read<ProductBloc>().add(
                  DeleteProduct(product: product),
                );
                Navigator.pop(context);
              },
              child: Text("Yes", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
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
              if (state is UploadedImage || state is UploadError) {
                Navigator.pop(context);
                if (state is UploadedImage) {
                  imageController.text = state.imgUrl;
                }
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
                      textCapitalization: TextCapitalization.sentences,
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
                    ElevatedButton.icon(
                      label: Text("Upload image"),
                      icon: Icon(Icons.upload),
                      onPressed: () {
                        // chooseImageUploadOption();
                        context.read<UploadBloc>().add(UploadImage());
                      },
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
                            Fluttertoast.showToast(
                              msg: "Please upload an image first",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity
                                  .TOP, // You can put it at the TOP to ensure it's seen
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
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
                          nameController.clear();
                          imageController.clear();
                          Navigator.pop(context);
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
      appBar: AppBar(),
      endDrawer: Drawer(
        child: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              }
            },
            child: Column(
              children: [
                DrawerHeader(child: SizedBox()),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                  onTap: () {
                    context.read<AuthBloc>().add(LogoutEvent());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProductBloc>().add(FetchProduct());
          context.read<CategoryBloc>().add(FetchCategories());
          await Future.delayed(Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
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
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showCategoryBottomSheet();
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryLoading) {
                        SizedBox(
                          height: 120,
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is CategoryLoaded) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text(
                        //       "Category added successfully.",
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //     backgroundColor: Colors.green,
                        //   ),
                        // );
                        final categories = state.categories;
                        if (categories.isEmpty) {
                          return Text("No categories found");
                        }
                        return SizedBox(
                          height: 120,
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 15);
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return Column(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      category.imagePath,
                                    ),
                                    radius: 40,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    category.name,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Products",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddUpdateProductScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductDeletionSuccess) {
                        showToastWidget(
                          'Product deleted successfully',
                          Colors.green,
                        );
                      }
                      if (state is ProductLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is ProductLoaded) {
                        if (state.products.isEmpty) {
                          return Center(child: Text("No products yet."));
                        }
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.5,
                              ),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];

                            return Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(
                                      255,
                                      207,
                                      207,
                                      207,
                                    ),
                                    offset: Offset(0, 2),
                                    spreadRadius: 4,
                                    blurRadius: 8,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      product.imagePath,
                                      width: double.infinity,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    product.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.raleway(fontSize: 16),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Rs ${product.price}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  if (product.discount != null &&
                                      product.discount! > 0) ...[
                                    SizedBox(height: 5),

                                    Text(
                                      '${product.discount} % Off',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                  // SizedBox(height: 5),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.green,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddUpdateProductScreen(
                                                    product:
                                                        state.products[index],
                                                  ),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        style: IconButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: () {
                                          deleteDialogBox(
                                            context,
                                            state.products[index],
                                          );
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
