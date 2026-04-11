import 'package:flutter/material.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xff005cab);
    const Color surfaceLowest = Color(0xffffffff);
    const Color surfaceLow = Color(0xfff1f3fd);
    const Color surface = Color(0xfff9f9ff);
    const Color onSurface = Color(0xff181c22);
    const Color onSurfaceVariant = Color(0xff404753);

    return Scaffold(
      backgroundColor: surface,
      appBar: AppBar(
        backgroundColor: surface,
        elevation: 0,
        leading: const BackButton(color: onSurface),
        title: const Text(
          "Nepal Services",
          style: TextStyle(
            color: onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What do you need help with today?",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: onSurface,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Icon(Icons.verified, color: primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "1,200+ Verified Professionals",
                    style: TextStyle(
                      fontSize: 14,
                      color: onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "Serving Kathmandu, Lalitpur & Bhaktapur",
                    style: TextStyle(
                      fontSize: 14,
                      color: onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              _buildCategoryGroup(
                "Home Services",
                [
                  _buildCategoryItem("Repair & Maintenance", Icons.handyman, surfaceLowest, onSurface),
                  _buildCategoryItem("Moving & Transport", Icons.local_shipping, surfaceLowest, onSurface),
                  _buildCategoryItem("Domestic Help", Icons.cleaning_services, surfaceLowest, onSurface),
                ],
                onSurface,
                surfaceLow,
              ),

              const SizedBox(height: 32),

              _buildCategoryGroup(
                "Digital & Freelance",
                [
                  _buildDetailedCategoryItem(
                    "Web & App Development",
                    "Scale your business with expert developers from Kathmandu's top tech hub.",
                    Icons.code,
                    surfaceLowest,
                    onSurface,
                    onSurfaceVariant,
                    primary,
                  ),
                ],
                onSurface,
                surfaceLow,
              ),

              const SizedBox(height: 32),
              
              _buildCategoryGroup(
                "Education & Events",
                [
                  _buildCategoryItem("Education", Icons.school, surfaceLowest, onSurface),
                  _buildCategoryItem("Event & Personal", Icons.celebration, surfaceLowest, onSurface),
                ],
                onSurface,
                surfaceLow,
              ),

              const SizedBox(height: 32),

              _buildCategoryGroup(
                "Wellness",
                [
                  _buildCategoryItem("Health & Wellness", Icons.fitness_center, surfaceLowest, onSurface),
                ],
                onSurface,
                surfaceLow,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryGroup(String title, List<Widget> items, Color onSurface, Color bg) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String title, IconData icon, Color bg, Color mainText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xff005cab)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: mainText,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xff404753)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedCategoryItem(String title, String desc, IconData icon, Color bg, Color mainText, Color subText, Color primary) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: primary.withOpacity(0.2), width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xfff1f3fd),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: mainText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 14,
                      color: subText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
