import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/ui/carousel_slider.dart';
import 'package:ecommerce_app/ui/category_container.dart';
import 'package:ecommerce_app/ui/search_textformfield_style.dart';
import 'package:ecommerce_app/ui/widgets/input_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final searchController = TextEditingController();

  List<CategoryModel> categories = [
    CategoryModel(
      title: 'Clothing',
      imagePath: [
        'assets/images/Placeholder_01.png',
        'assets/images/Placeholder_01-1.png',
        'assets/images/Placeholder_01-2.png',
        'assets/images/Placeholder_01-3.png',
      ],
    ),
    CategoryModel(
      title: 'Shoes',
      imagePath: [
        'assets/images/Placeholder_02.jpg',
        'assets/images/Placeholder_02-1.jpg',
        'assets/images/Placeholder_02-2.jpg',
        'assets/images/Placeholder_02-3.jpg',
      ],
    ),
    CategoryModel(
      title: 'Bags',
      imagePath: [
        'assets/images/Placeholder_03.jpg',
        'assets/images/Placeholder_03-1.jpg',
        'assets/images/Placeholder_03-2.jpg',
        'assets/images/Placeholder_03-3.jpg',
      ],
    ),
    CategoryModel(
      title: 'Watches',
      imagePath: [
        'assets/images/Placeholder_04.jpg',
        'assets/images/Placeholder_04-1.jpg',
        'assets/images/Placeholder_04-2.jpg',
        'assets/images/Placeholder_04-3.jpg',
      ],
    ),

  ];

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Shop",
                    style: GoogleFonts.raleway(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      style: GoogleFonts.raleway(),
                      controller: searchController,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.camera_alt, size: 30),
                          ),
                        ),
                        isDense: true,
                        hintText: 'Search',
                        enabledBorder: searchTextFormFieldStyle(),
                        filled: true,
                        fillColor: const Color.fromRGBO(255, 255, 255, 1),
                        focusedBorder: searchTextFormFieldStyle(),
                        errorBorder: searchTextFormFieldStyle(),
                        focusedErrorBorder: searchTextFormFieldStyle(),
                      ),
                    ),
                  ),
                ],
              ),
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
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  CategoryContainerCard(category: categories[0]),
                  CategoryContainerCard(category: categories[1]),
                  CategoryContainerCard(category: categories[2]),
                  CategoryContainerCard(category: categories[3]),
                ],
              ),

              // Row(
              //   children: [
              //     CategoryContainerCard(category: categories[0]),
              //     SizedBox(width: 10),
              //     CategoryContainerCard(category: categories[1]),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
