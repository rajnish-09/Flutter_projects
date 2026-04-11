import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProviderDashboardScreen extends StatelessWidget {
  const ProviderDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xff005cab);
    const Color primaryContainer = Color(0xff0075d6);
    const Color surfaceLowest = Color(0xffffffff);
    const Color surface = Color(0xfff9f9ff);
    const Color onSurface = Color(0xff181c22);
    const Color onSurfaceVariant = Color(0xff404753);

    return Scaffold(
      backgroundColor: surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Hello, Rajesh!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "You have 3 new booking requests for today.",
                style: TextStyle(
                  fontSize: 16,
                  color: onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),

              // Stats Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  _buildStatCard("Monthly Earnings", "रू 42,500", surfaceLowest, onSurfaceVariant, onSurface),
                  _buildStatCard("Jobs Completed", "128", surfaceLowest, onSurfaceVariant, onSurface),
                  _buildStatCard("Avg Rating", "4.9(92 reviews)", surfaceLowest, onSurfaceVariant, onSurface),
                  _buildStatCard("Profile Views", "1.2k", surfaceLowest, onSurfaceVariant, onSurface),
                ],
              ),
              const SizedBox(height: 32),

              Text(
                "Manage Business",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: onSurface,
                ),
              ),
              const SizedBox(height: 16),

              // Boost Listing Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [primary, primaryContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Boost Your Listing",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Get more jobs by sponsoring your profile. Sponsored providers receive up to 5x more clicks from clients in Kathmandu.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Sponsor Profile"),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 32),

              Text(
                "Upcoming Bookings",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: onSurface,
                ),
              ),
              const SizedBox(height: 16),

              // Upcoming Bookings List
              _buildBookingCard("Anita Shrestha", "Today, 2:00 PM", surfaceLowest, onSurface, onSurfaceVariant),
              const SizedBox(height: 16),
              _buildBookingCard("Binod Thapa", "Tomorrow, 10:00 AM", surfaceLowest, onSurface, onSurfaceVariant),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 0, surfaceLowest, primary, onSurfaceVariant),
    );
  }

  Widget _buildStatCard(String title, String value, Color surfaceLowest, Color textVariant, Color textMain) {
    return Container(
      decoration: BoxDecoration(
        color: surfaceLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ]
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              color: textVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textMain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(String name, String time, Color surfaceLowest, Color onSurface, Color onSurfaceVariant) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xfff1f3fd),
            radius: 24,
            child: Icon(Icons.person, color: const Color(0xff005cab)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color: onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: onSurfaceVariant),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, int currentIndex, Color bg, Color active, Color inactive) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: bg,
      selectedItemColor: active,
      unselectedItemColor: inactive,
      elevation: 0,
      onTap: (index) {
        if (index == 0) {
          context.push('/provider-dashboard');
        } else if (index == 1) {
          context.push('/provider-booking-history');
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_note),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
