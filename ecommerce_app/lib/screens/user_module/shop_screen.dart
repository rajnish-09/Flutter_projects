import 'package:ecommerce_app/bloc/category/category_bloc.dart';
import 'package:ecommerce_app/bloc/category/category_event.dart';
import 'package:ecommerce_app/bloc/category/category_state.dart';
import 'package:ecommerce_app/bloc/product/product_bloc.dart';
import 'package:ecommerce_app/bloc/product/product_event.dart';
import 'package:ecommerce_app/bloc/product/product_state.dart';
import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/models/top_products_model.dart';
import 'package:ecommerce_app/screens/user_module/cart_screen.dart';
import 'package:ecommerce_app/screens/user_module/product_list_screen.dart';
import 'package:ecommerce_app/widgets/bottom_navigation_bar.dart';
import 'package:ecommerce_app/widgets/carousel_slider.dart';
import 'package:ecommerce_app/widgets/category_container.dart';
import 'package:ecommerce_app/widgets/product_display_container.dart';
import 'package:ecommerce_app/widgets/search_textformfield_style.dart';
// import 'package:ecommerce_app/ui/widgets/input_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(FetchCategories());
    context.read<ProductBloc>().add(FetchProduct());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ShopEase",
                style: GoogleFonts.raleway(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              SizedBox(height: 20),
              CarouselSliderwidget(),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    "Categories",
                    style: GoogleFonts.raleway(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "See all",
                    style: GoogleFonts.raleway(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_right_alt, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0xff004CFF),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    SizedBox(height: 120, child: CircularProgressIndicator());
                  }
                  if (state is CategoryLoaded) {
                    final categories = state.categories;
                    if (categories.isEmpty) return Text("No categories found");
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Just for you",
                    style: GoogleFonts.raleway(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductListScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "View more",
                          style: TextStyle(color: Colors.blue.shade300),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.blue.shade300,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is ProductLoaded) {
                    final products = state.products;
                    final displayCount = products.length > 10
                        ? 10
                        : products.length;
                    if (products.isEmpty) {
                      return Center(child: Text("No products yet."));
                    }
                    return SizedBox(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: displayCount,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // number of items per row
                          crossAxisSpacing:
                              10, // horizontal spacing between items
                          mainAxisSpacing: 10, // vertical spacing between items
                          childAspectRatio:
                              0.6, // width / height ratio of each item
                        ),
                        itemBuilder: (context, index) {
                          final product = products[index];
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
    );
  }
}
