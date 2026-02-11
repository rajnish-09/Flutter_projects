import 'package:ecommerce_app/bloc/product/product_bloc.dart';
import 'package:ecommerce_app/bloc/product/product_state.dart';
import 'package:ecommerce_app/widgets/product_display_container.dart';
import 'package:ecommerce_app/widgets/search_textformfield_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final searchController = TextEditingController();
  String searchItem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      searchItem = value;
                    });
                  },
                  style: GoogleFonts.raleway(),
                  controller: searchController,
                  decoration: InputDecoration(
                    suffixIcon: Padding(padding: EdgeInsets.only(right: 15)),
                    isDense: true,
                    hintText: 'Search',
                    enabledBorder: searchTextFormFieldStyle(),
                    filled: true,
                    fillColor: Color.fromRGBO(255, 255, 255, 1),
                    focusedBorder: searchTextFormFieldStyle(),
                    errorBorder: searchTextFormFieldStyle(),
                    focusedErrorBorder: searchTextFormFieldStyle(),
                  ),
                ),
                SizedBox(height: 20),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is ProductLoaded) {
                      final filterProduct =
                          (searchItem == '' && searchItem.isEmpty)
                          ? state.products
                          : state.products.where((product) {
                              return product.title.toLowerCase().contains(
                                searchItem.toLowerCase(),
                              );
                            }).toList();
                      // final products = state.products;
                      if (filterProduct.isEmpty) {
                        return Center(child: Text("No products."));
                      }
                      return SizedBox(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filterProduct.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // number of items per row
                                crossAxisSpacing:
                                    10, // horizontal spacing between items
                                mainAxisSpacing:
                                    10, // vertical spacing between items
                                childAspectRatio:
                                    0.55, // width / height ratio of each item
                              ),
                          itemBuilder: (context, index) {
                            final product = filterProduct[index];
                            return ProductDisplayContainer(prod: product);
                          },
                        ),
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
    );
  }
}
