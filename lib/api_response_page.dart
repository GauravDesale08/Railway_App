// Inside ApiResponsePage class

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hack1/FareResultPage.dart';
import 'package:hack1/train_info.dart';

class ApiResponsePage extends StatefulWidget {
  final List<TrainInfo> trainList;
  final String fromStation;
  final String toStation;
  final String journeyDate;
  final String trainno;
  ApiResponsePage(
      {required this.trainList,
      required this.fromStation,
      required this.toStation,
      required this.journeyDate,
      required this.trainno});

  @override
  _ApiResponsePageState createState() => _ApiResponsePageState();
}

class _ApiResponsePageState extends State<ApiResponsePage> {
  List<TrainInfo> _trainList = [];
  String _fromStation = '';
  String _toStation = '';
  String trainno = '';

  @override
  void initState() {
    super.initState();
    // Copy initial data from widget to local variables
    _trainList = widget.trainList;
    _fromStation = widget.fromStation;
    _toStation = widget.toStation;
  }

  // Function to update data
  void updateData(List<TrainInfo> trainList, String fromStation,
      String toStation, String journeyDate) {
    setState(() {
      _trainList = trainList;
      _fromStation = fromStation;
      _toStation = toStation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Response'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < _trainList.length; i++)
              Column(
                children: [
                  ListTile(
                    title: Text(
                      _trainList[i].trainName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Run Days: ${_trainList[i].runDays.join(', ')}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${_trainList[i].fromStationName} to ${_trainList[i].toStationName}\nDeparture: ${_trainList[i].departureTime}\nArrival: ${_trainList[i].arrivalTime}\nDuration: ${_trainList[i].durationInHours} hours',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.blue,
                    thickness: 2.0,
                  ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      trainno = _trainList[i].trainNumber;
                      _getFare(context, trainno);
                    },
                    child: Text('Get Fare'),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _getFare(BuildContext context, String trainno) async {
    final String apiUrl =
        'https://irctc1.p.rapidapi.com/api/v2/getFare?trainNo=$trainno&fromStationCode=$_fromStation&toStationCode=$_toStation';

    final Map<String, String> headers = {
      'X-Rapidapi-Key': '2118c04483msh9d44e9702ece1dfp15d1e0jsnb5fc9fed81fc',
      'X-Rapidapi-Host': 'irctc1.p.rapidapi.com',
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      print('Fare API Response: ${response.statusCode}');
      print('Fare API Data: ${response.body}');

      // Show the output in a new page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FareResultPage(fareData: response.body),
        ),
      );
    } catch (error) {
      print('Error making Fare API request: $error');
    }
  }
}
