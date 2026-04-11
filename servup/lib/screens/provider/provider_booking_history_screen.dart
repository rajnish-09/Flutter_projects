import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProviderBookingHistoryScreen extends StatelessWidget {
  const ProviderBookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xff005cab);
    const Color surfaceLowest = Color(0xffffffff);
    const Color surface = Color(0xfff9f9ff);
    const Color onSurface = Color(0xff181c22);
    const Color onSurfaceVariant = Color(0xff404753);
    const Color primaryContainer = Color(0xffd4e3ff);

    return Scaffold(
      backgroundColor: surface,
      appBar: AppBar(
        backgroundColor: surface,
        elevation: 0,
        title: Text(
          "Booking History",
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
                "History Highlights",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.star, color: primary),
                          const SizedBox(height: 8),
                          Text(
                            "Avg. Rating",
                            style: TextStyle(color: onSurfaceVariant),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "4.9",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: surfaceLowest,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xffc0c7d6), width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          const SizedBox(height: 8),
                          Text(
                            "Completed",
                            style: TextStyle(color: onSurfaceVariant),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "128",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              Text(
                "Recent Bookings",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: onSurface,
                ),
              ),
              const SizedBox(height: 16),

              _buildHistoryCard(
                "Anil K. Shrestha",
                "Client since 2023",
                "Full Wiring Check",
                "Deep inspection of circuit breakers and outlets",
                surfaceLowest,
                onSurface,
                onSurfaceVariant,
                primary,
              ),
              const SizedBox(height: 16),
              _buildHistoryCard(
                "Sita Gurung",
                "Recurring Client",
                "Kitchen Sink Repair",
                "Leaking pipe and faucet replacement",
                surfaceLowest,
                onSurface,
                onSurfaceVariant,
                primary,
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 1, surfaceLowest, primary, onSurfaceVariant),
    );
  }

  Widget _buildHistoryCard(String name, String subtitle, String service, String desc, Color bg, Color mainText, Color subText, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xfff1f3fd),
                child: Icon(Icons.person, color: primaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: mainText,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xffe8f5e9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Completed",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          const Divider(height: 24, thickness: 1, color: Color(0xfff1f3fd)),
          Text(
            service,
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
