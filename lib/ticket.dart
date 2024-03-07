import 'package:flutter/material.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  late TextEditingController _departureController;
  late TextEditingController _destinationController;
  late TextEditingController _dateController;
  String _selectedQuota = 'GENERAL'; // Default quota

  @override
  void initState() {
    super.initState();
    _departureController = TextEditingController();
    _destinationController = TextEditingController();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _departureController.dispose();
    _destinationController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: Colors.blue),
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = '${pickedDate.day} ${_getMonthName(pickedDate.month)}, ${_getDayName(pickedDate.weekday)}';
      });
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  String _getDayName(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Your Train Ticket'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Where Are You Travelling?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _departureController,
                decoration: InputDecoration(
                  labelText: 'From',
                  hintText: 'Enter departure station',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.train, color: Colors.blue),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _destinationController,
                decoration: InputDecoration(
                  labelText: 'To',
                  hintText: 'Enter destination station',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.train, color: Colors.blue),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _dateController,
                onTap: () {
                  _selectDate(context);
                },
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Travel Date',
                  hintText: 'Select date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.date_range, color: Colors.blue),
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedQuota,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedQuota = newValue!;
                  });
                },
                items: <String>['GENERAL', 'Tatkal', 'Ladies', 'Senior Citizen', 'Other']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
                decoration: InputDecoration(
                  labelText: 'Quota',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.account_balance_wallet, color: Colors.blue),
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle logic to find trains based on input
                    String departureStation = _departureController.text;
                    String destinationStation = _destinationController.text;
                    String date = _dateController.text;
                    _findTrains(departureStation, destinationStation, date, _selectedQuota);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    'Find Trains',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _findTrains(String departureStation, String destinationStation, String date, String selectedQuota) {
    // Implement logic to find trains based on the input
    print('Departure Station: $departureStation');
    print('Destination Station: $destinationStation');
    print('Date: $date');
    print('Quota: $selectedQuota');
    // You can continue implementing the logic to find trains here
  }
}
