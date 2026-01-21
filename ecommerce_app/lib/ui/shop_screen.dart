import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/models/top_products_model.dart';
import 'package:ecommerce_app/widgets/bottom_navigation_bar.dart';
import 'package:ecommerce_app/widgets/carousel_slider.dart';
import 'package:ecommerce_app/widgets/category_container.dart';
import 'package:ecommerce_app/widgets/product_display_container.dart';
import 'package:ecommerce_app/widgets/search_textformfield_style.dart';
// import 'package:ecommerce_app/ui/widgets/input_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final searchController = TextEditingController();
  Product product = Product();

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

  List<TopProductsModel> topProducts = [
    TopProductsModel(
      proudctImagePath: 'assets/images/Placeholder_01-3.png',
      productName: 'Clothes',
    ),
    TopProductsModel(
      proudctImagePath: 'assets/images/Placeholder_02.jpg',
      productName: 'Nike Shoe',
    ),
    TopProductsModel(
      proudctImagePath: 'assets/images/Placeholder_02-2.jpg',
      productName: 'Sandals',
    ),
    TopProductsModel(
      proudctImagePath: 'assets/images/Placeholder_03.jpg',
      productName: 'Casual bag',
    ),
    TopProductsModel(
      proudctImagePath: 'assets/images/Placeholder_03-3.jpg',
      productName: 'Leather bag',
    ),
    TopProductsModel(
      proudctImagePath: 'assets/images/Placeholder_04-1.jpg',
      productName: 'Rolex',
    ),
    TopProductsModel(
      proudctImagePath: 'assets/images/Placeholder_01.png',
      productName: 'Urban',
    ),
    TopProductsModel(
      proudctImagePath: 'assets/images/Placeholder_02-3.jpg',
      productName: 'Street',
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
      extendBody: true,
      bottomNavigationBar: BottomNavigationBarWidget(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Wrap(
                    spacing: 15,
                    runSpacing: 15,
                    children: [
                      CategoryContainerCard(category: categories[0]),
                      CategoryContainerCard(category: categories[1]),
                      CategoryContainerCard(category: categories[2]),
                      CategoryContainerCard(category: categories[3]),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Top products",
                  style: GoogleFonts.raleway(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: topProducts.length,
                    itemBuilder: (context, index) {
                      final product = topProducts[index];
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 75,
                              height: 75,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(255, 255, 255, 255),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(-4, 4),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  product.proudctImagePath,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              product.productName,
                              style: GoogleFonts.nunitoSans(fontSize: 13),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // SizedBox(height: 20),
                Text(
                  "Just for you",
                  style: GoogleFonts.raleway(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: product.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // number of items per row
                      crossAxisSpacing: 10, // horizontal spacing between items
                      mainAxisSpacing: 10, // vertical spacing between items
                      childAspectRatio:
                          0.6, // width / height ratio of each item
                    ),
                    itemBuilder: (context, index) {
                      final prod = product.products[index];
                      return ProductDisplayContainer(prod: prod);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
