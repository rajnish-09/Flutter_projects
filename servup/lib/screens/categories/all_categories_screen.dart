import 'package:flutter/material.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {"name": "Home & Repair", "icon": Icons.home_repair_service},
    {"name": "Transport", "icon": Icons.local_shipping},
    {"name": "Digital", "icon": Icons.computer},
    {"name": "Education", "icon": Icons.school},
    {"name": "Wellness", "icon": Icons.fitness_center},
    {"name": "Events", "icon": Icons.celebration},
  ];

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xff005cab);
    const Color surfaceLowest = Color(0xffffffff);
    const Color surfaceLow = Color(0xfff1f3fd);
    const Color surface = Color(0xfff9f9ff);
    const Color onSurface = Color(0xff181c22);
    const Color onSurfaceVariant = Color(0xff707785);

    return Scaffold(
      backgroundColor: surfaceLowest,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: primary, size: 20),
                  const SizedBox(width: 4),
                  const Text(
                    "Kathmandu",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: onSurface,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Nepal Services",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: primary,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 24), // Balance the row
                ],
              ),
            ),
            
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: onSurfaceVariant),
                    const SizedBox(width: 8),
                    Text(
                      "Search all services...",
                      style: TextStyle(color: onSurfaceVariant, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, thickness: 1, color: Color(0xffebeef7)),

            // Main Body (Sidebar + Content)
            Expanded(
              child: Row(
                children: [
                  // Sidebar
                  SizedBox(
                    width: 100,
                    child: ListView.builder(
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final isSelected = _selectedIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? surfaceLow : Colors.transparent,
                              border: isSelected ? const Border(
                                right: BorderSide(color: primary, width: 4),
                              ) : null,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _categories[index]['icon'],
                                  color: isSelected ? primary : onSurfaceVariant,
                                  size: 28,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _categories[index]['name'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: isSelected ? primary : onSurfaceVariant,
                                    fontSize: 12,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const VerticalDivider(width: 1, thickness: 1, color: Color(0xffebeef7)),

                  // Right Content Area
                  Expanded(
                    child: Container(
                      color: surfaceLowest,
                      child: _buildRightContent(primary, onSurface, onSurfaceVariant, surfaceLowest, surface),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightContent(Color primary, Color onSurface, Color onSurfaceVariant, Color surfaceLowest, Color surface) {
    if (_selectedIndex != 0) {
      return Center(
        child: Text("Content for ${_categories[_selectedIndex]['name']}"),
      );
    }

    // Home & Repair Content
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          "POPULAR NEAR YOU",
          style: TextStyle(
            color: onSurfaceVariant,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildPopularPill("Electrician", Icons.electrical_services, primary, surface),
            const SizedBox(width: 12),
            _buildPopularPill("Cleaning", Icons.cleaning_services, primary, surface),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              "Home & Repair",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: onSurface,
              ),
            ),
            Text(
              "8 Services",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.85,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            _buildServiceCard("Plumbing", "Leaking, repair", Icons.plumbing, primary, onSurface, onSurfaceVariant, surfaceLowest),
            _buildServiceCard("AC Service", "Install, fix", Icons.ac_unit, primary, onSurface, onSurfaceVariant, surfaceLowest),
            _buildServiceCard("Carpentry", "Furniture, doors", Icons.handyman, primary, onSurface, onSurfaceVariant, surfaceLowest),
            _buildServiceCard("Appliances", "Fridge, TV", Icons.home_repair_service, primary, onSurface, onSurfaceVariant, surfaceLowest),
            _buildServiceCard("Painting", "Walls, decor", Icons.format_paint, primary, onSurface, onSurfaceVariant, surfaceLowest),
            _buildServiceCard("Pest Control", "Deep clean", Icons.bug_report, primary, onSurface, onSurfaceVariant, surfaceLowest),
          ],
        )
      ],
    );
  }

  Widget _buildPopularPill(String title, IconData icon, Color primary, Color surface) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xffebeef7), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xffeef0fa),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: primary, size: 16),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String title, String subtitle, IconData icon, Color primary, Color onSurface, Color onSurfaceVariant, Color surfaceLowest) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surfaceLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffebeef7), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: primary, size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

