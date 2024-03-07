import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:hack1/history.dart';
import 'package:hack1/home1.dart';
import 'package:hack1/profile.dart';
import 'package:hack1/ticket.dart'; // Import the Ticket feature

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreenTop(),
    TicketPage(), // Changed from TravelHome() to HomeScreenTop()
    TripsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        backgroundColor: Colors.blue.shade100,
        items: [
          Icon(Icons.home, size: 30),
          Icon(Icons.train, size: 30),
          Icon(Icons.history, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
