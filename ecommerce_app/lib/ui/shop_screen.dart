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
                  SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xff)
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
