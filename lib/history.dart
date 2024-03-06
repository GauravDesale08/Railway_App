import 'package:flutter/material.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({Key? key}) : super(key: key);

  @override
  _TripsPageState createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trips'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Upcoming'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          UpcomingTripsTab(),
          PastTripsTab(),
        ],
      ),
    );
  }
}

class UpcomingTripsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: upcomingTrips.length,
      itemBuilder: (context, index) => UpcomingTripCard(tripDetails: upcomingTrips[index]),
    );
  }
}

class PastTripsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pastTrips.length,
      itemBuilder: (context, index) => PastTripCard(tripDetails: pastTrips[index]),
    );
  }
}

class UpcomingTripCard extends StatelessWidget {
  final Map<String, dynamic> tripDetails;

  const UpcomingTripCard({Key? key, required this.tripDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tripDetails['destination'],
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            Text(
              'Departure: ${tripDetails['departureDate']}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}

class PastTripCard extends StatelessWidget {
  final Map<String, dynamic> tripDetails;

  const PastTripCard({Key? key, required this.tripDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tripDetails['destination'],
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            Text(
              'Dates: ${tripDetails['startDate']} - ${tripDetails['endDate']}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                Text(
                  tripDetails['rating'] != null ? tripDetails['rating'].toString() : 'N/A',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> upcomingTrips = [
  {
    'destination': 'Upcoming Trip 1',
    'departureDate': '2022-12-31',
  },
  {
    'destination': 'Upcoming Trip 2',
    'departureDate': '2023-01-15',
  },
  // Add more upcoming trips as needed
];

List<Map<String, dynamic>> pastTrips = [
  {
    'destination': 'Past Trip 1',
    'startDate': '2022-09-15',
    'endDate': '2022-09-20',
    'rating': 4.5,
  },
  {
    'destination': 'Past Trip 2',
    'startDate': '2022-08-20',
    'endDate': '2022-08-25',
    'rating': 5.0,
  },
  // Add more past trips as needed
];
