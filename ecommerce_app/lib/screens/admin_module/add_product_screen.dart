import 'package:ecommerce_app/bloc/product/product_bloc.dart';
import 'package:ecommerce_app/bloc/product/product_event.dart';
import 'package:ecommerce_app/bloc/product/product_state.dart';
import 'package:ecommerce_app/bloc/uploadImage/upload_bloc.dart';
import 'package:ecommerce_app/bloc/uploadImage/upload_event.dart';
import 'package:ecommerce_app/bloc/uploadImage/upload_state.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/service/firebase_service.dart';
import 'package:ecommerce_app/widgets/input_textformfield.dart';
import 'package:ecommerce_app/widgets/loading_dialog.dart';
import 'package:ecommerce_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  final imageController = TextEditingController();
  final productDiscountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isToggled = false;
  FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is AddProductSuccess) {
          Fluttertoast.showToast(
            backgroundColor: Colors.green,
            msg: "Product Saved!",
          ); // Toasts often work better across screen transitions
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Add product"), centerTitle: true),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputTextFormFIeld(
                      textCapitalization: TextCapitalization.sentences,
                      controller: productNameController,
                      hintText: 'Enter product title',
                      validator: (value) {
                        if (productNameController.text.trim().isEmpty) {
                          return 'Product name is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    InputTextFormFIeld(
                      textCapitalization: TextCapitalization.sentences,
                      controller: productDescriptionController,
                      hintText: 'Enter product description',
                      maxLines: 4,
                      validator: (value) {
                        if (productDescriptionController.text.trim().isEmpty) {
                          return 'Product description is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<UploadBloc>().add(UploadImage());
                      },
                      label: Text('Upload image'),
                      icon: Icon(Icons.upload),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Price (Rs.):"),
                        SizedBox(width: 20),
                        Expanded(
                          child: InputTextFormFIeld(
                            textInputType: TextInputType.number,
                            controller: productPriceController,
                            hintText: 'Enter product price',
                            validator: (value) {
                              if (productPriceController.text.trim().isEmpty) {
                                return 'Product price is required';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text("Discount (If any)"),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: isToggled,
                      onChanged: (_) {
                        setState(() {
                          isToggled = !isToggled;
                        });
                      },
                    ),
                    if (isToggled) ...[
                      SizedBox(height: 20),
                      InputTextFormFIeld(
                        textInputType: TextInputType.number,
                        controller: productDiscountController,
                        hintText: 'Enter discount percent (%)',
                        validator: (value) {
                          if (isToggled &&
                              (value == null || value.trim().isEmpty)) {
                            return 'Discount percent is required';
                          }
                          return null;
                        },
                      ),
                    ],
                    SizedBox(height: 30),
                    BlocListener<UploadBloc, UploadState>(
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
                      child: SubmitButton(
                        buttonText: 'Save product',
                        onPressed: () async {
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
                            double discountValue = 0;
                            if (isToggled &&
                                productDiscountController.text.isNotEmpty) {
                              discountValue =
                                  double.tryParse(
                                    productDiscountController.text,
                                  ) ??
                                  0;
                            }
                            final product = ProductModel(
                              imagePath: imageController.text,
                              title: productNameController.text.trim(),
                              description: productDescriptionController.text
                                  .trim(),
                              price: double.parse(productPriceController.text),
                              discount: discountValue,
                              // rating: rating,
                            );
                            context.read<ProductBloc>().add(
                              AddProduct(product: product),
                            );
                            productNameController.clear();
                            productDescriptionController.clear();
                            productDiscountController.clear();
                            productPriceController.clear();
                            // Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
