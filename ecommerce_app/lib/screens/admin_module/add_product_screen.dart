import 'package:ecommerce_app/widgets/input_textformfield.dart';
import 'package:ecommerce_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  final productDiscountController = TextEditingController();
  // final productNameController = TextEditingController();
  bool isToggled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add product"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputTextFormFIeld(
                controller: productNameController,
                hintText: 'Enter product title',
              ),
              SizedBox(height: 30),
              InputTextFormFIeld(
                controller: productDescriptionController,
                hintText: 'Enter product description',
                maxLines: 4,
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
                  hintText: 'Enter discount amount',
                ),
              ],
              SizedBox(height: 30),
              SubmitButton(buttonText: 'Save product', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
