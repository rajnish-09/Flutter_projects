import 'package:ecommerce_app/bloc/category/category_bloc.dart';
import 'package:ecommerce_app/bloc/category/category_event.dart';
import 'package:ecommerce_app/bloc/category/category_state.dart';
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

class AddUpdateProductScreen extends StatefulWidget {
  final ProductModel? product;
  const AddUpdateProductScreen({super.key, this.product});

  @override
  State<AddUpdateProductScreen> createState() => _AddUpdateProductScreenState();
}

class _AddUpdateProductScreenState extends State<AddUpdateProductScreen> {
  late TextEditingController productNameController;
  late TextEditingController productDescriptionController;
  late TextEditingController productPriceController;
  late TextEditingController imageController;
  late TextEditingController productDiscountController;
  late TextEditingController categoryController;
  final _formKey = GlobalKey<FormState>();
  late bool isToggled;
  FirebaseService firebaseService = FirebaseService();
  String? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController(
      text: widget.product == null ? '' : widget.product!.title,
    );
    productDescriptionController = TextEditingController(
      text: widget.product == null ? '' : widget.product!.description,
    );
    productPriceController = TextEditingController(
      text: widget.product == null ? '' : widget.product!.price.toString(),
    );
    imageController = TextEditingController(
      text: widget.product?.imagePath ?? '',
    );
    productDiscountController = TextEditingController(
      text: widget.product?.discount.toString() ?? '',
    );
    categoryController = TextEditingController(
      text: widget.product?.categoryId ?? '',
    );
    isToggled = (widget.product?.discount ?? 0) > 0;
    context.read<CategoryBloc>().add(FetchCategories());
  }

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
        if (state is EditProductSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.successMsg)));
          Navigator.pop(context);
        }
        if (state is EditProductFailed) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.product != null ? "Edit product" : "Add product"),
          centerTitle: true,
        ),
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
                    BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) {
                        // if (state is CategoryLoading) {
                        //   return Center(child: CircularProgressIndicator());
                        // }
                        if (state is CategoryLoaded) {
                          final categories = state.categories;
                          return DropdownButtonFormField(
                            hint: Text(
                              state is CategoryLoading
                                  ? "Loading..."
                                  : "Select a category",
                            ),
                            initialValue: widget.product?.categoryId,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: Icon(Icons.category_outlined),
                            ),
                            items: categories
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e.id,
                                    child: Text(e.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                // selectedCategory = value;
                                categoryController.text = value!;
                              });
                            },
                            validator: (value) => value == null
                                ? 'Please select a category'
                                : null,
                          );
                        }
                        return SizedBox();
                      },
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
                        buttonText: widget.product == null
                            ? 'Save product'
                            : 'Update product',
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
                            double discountValue =
                                widget.product?.discount ?? 0.0;
                            if (isToggled &&
                                productDiscountController.text.isNotEmpty) {
                              discountValue =
                                  double.tryParse(
                                    productDiscountController.text,
                                  ) ??
                                  0;
                            }
                            if (isToggled == false) {
                              discountValue = 0;
                            }
                            final product = ProductModel(
                              imagePath: imageController.text,
                              title: productNameController.text.trim(),
                              description: productDescriptionController.text
                                  .trim(),
                              price: double.parse(productPriceController.text),
                              discount: discountValue,
                              categoryId: categoryController.text,
                              id: widget.product?.id,
                              // rating: rating,
                            );
                            widget.product == null
                                ? context.read<ProductBloc>().add(
                                    AddProduct(product: product),
                                  )
                                : context.read<ProductBloc>().add(
                                    EditProduct(product: product),
                                  );
                            // productNameController.clear();
                            // productDescriptionController.clear();
                            // productDiscountController.clear();
                            // productPriceController.clear();
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
