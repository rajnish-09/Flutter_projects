import 'package:ecommerce_app/widgets/input_textformfield.dart';
import 'package:ecommerce_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    controller: productDescriptionController,
                    hintText: 'Enter product description',
                    maxLines: 4,
                    validator: (value) {
                      if (productNameController.text.trim().isEmpty) {
                        return 'Product description is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {},
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
                          controller: productPriceController,
                          hintText: 'Enter product price',
                          validator: (value) {
                            if (productNameController.text.trim().isEmpty) {
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
                      controller: productDiscountController,
                      hintText: 'Enter discount percent (%)',
                      validator: (value) {
                        return 'Discount percent is required';
                      },
                    ),
                  ],
                  SizedBox(height: 30),
                  SubmitButton(
                    buttonText: 'Save product',
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
                      }
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
