import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarouselSliderwidget extends StatefulWidget {
  const CarouselSliderwidget({super.key});

  @override
  State<CarouselSliderwidget> createState() => _CarouselSliderwidgetState();
}

class _CarouselSliderwidgetState extends State<CarouselSliderwidget> {
  List<Map<String, dynamic>> carouselItems = [
    {
      'imagePath': 'assets/images/slider_image1.png',
      'titleText': 'Big Sale',
      'discount': 'Up to 50%',
    },
    {
      'imagePath': 'assets/images/slider_image2.png',
      'titleText': "Men's Sale",
      'discount': 'Up to 30%',
    },
    {
      'imagePath': 'assets/images/slider_image3.png',
      'titleText': "Watch Sale",
      'discount': 'Up to 20%',
    },
  ];

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          CarouselSlider.builder(
            itemCount: carouselItems.length,
            options: CarouselOptions(
              // scrollPhysics: BouncingScrollPhysics(),
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
              viewportFraction: 1,
              // aspectRatio: 2,
            ),
            itemBuilder: (context, index, realIndex) {
              final item = carouselItems[index];
              return Container(
                width: double.infinity,
                // height: 100,
                decoration: BoxDecoration(
                  color: Color(0xffF1B11C),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        item['imagePath'],
                        fit: BoxFit.contain,
                        height: 180,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['titleText'],
                            style: GoogleFonts.raleway(
                              fontSize: 29,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            item['discount'],
                            style: GoogleFonts.nunitoSans(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Happening\nNow",
                            style: GoogleFonts.raleway(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 10,
            right: 0,
            left: 0,
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: carouselItems.asMap().entries.map((entry) {
                  final active = currentIndex == entry.key;
                  return GestureDetector(
                    onTap: () => {}, // optional: jump to that slide
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: active ? 30 : 10,
                      height: 10,
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        // shape: active ? BoxShape.rectangle : BoxShape.circle,
                        color: active ? Colors.black : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
