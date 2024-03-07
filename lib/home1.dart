import 'package:flutter/material.dart';
import 'package:hack1/paymentpage.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'api_response_page.dart';
import 'train_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreenTop extends StatefulWidget {
  const HomeScreenTop({Key? key}) : super(key: key);

  @override
  _HomeScreenTopState createState() => _HomeScreenTopState();
}

class _HomeScreenTopState extends State<HomeScreenTop> {
  final TextStyle dropdownMenuLabel =
      const TextStyle(color: Colors.white, fontSize: 16);
  final TextStyle dropdownMenuItem =
      const TextStyle(color: Colors.black, fontSize: 18);
  List<String> locations = ['Mumbai', 'Pune', 'New Delhi', 'Kolkata'];
  var selectedLocationIndex = 0;
  final apiKey =
      'AIzaSyDUB3dXclxEnO8VnaerwBDJbPaGWZKHa3c'; // Replace with your actual API key
  final TextEditingController _textEditingController = TextEditingController();
  String outputText = '';
  late String fromStation = '';
  late String toStation = '';
  String journeyDate = '';
  String trainno = '';
  String formattedReturnDate = '';
  String selectedJourneyType = 'one-way';
  List<String> journeyTypes = ['one-way', 'return'];
  List<TrainInfo> trainList = [];
  stt.SpeechToText speech = stt.SpeechToText();

  Future<void> _makeApiRequest(BuildContext context) async {
    if (selectedJourneyType == 'one-way') {
      _callApi(fromStation, toStation, journeyDate, 'Journey');
    } else if (selectedJourneyType == 'return') {
      _callApi(fromStation, toStation, journeyDate, 'Journey');
      _callApi(toStation, fromStation, formattedReturnDate, 'Return Journey');
    }
    setState(() {});
  }

  Future<void> _callApi(String fromStation, String toStation, String date,
      String sectionTitle) async {
    final String apiUrl =
        'https://irctc1.p.rapidapi.com/api/v3/trainBetweenStations?fromStationCode=$fromStation&toStationCode=$toStation&dateOfJourney=$date';

    final Map<String, String> headers = {
      'X-Rapidapi-Key': '2118c04483msh9d44e9702ece1dfp15d1e0jsnb5fc9fed81fc',
      'X-Rapidapi-Host': 'irctc1.p.rapidapi.com',
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      print('API Response: ${response.statusCode}');
      print('API Data: ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == true) {
        for (var trainData in data['data']) {
          int durationInHours = int.parse(trainData['duration'].split(':')[0]);

          trainList.add(TrainInfo(
            trainNumber: trainno = trainData['train_number'],
            trainName: trainData['train_name'],
            runDays: List<String>.from(trainData['run_days']),
            fromStation: trainData['from'],
            toStation: trainData['to'],
            fromStationName: trainData['from_station_name'],
            toStationName: trainData['to_station_name'],
            departureTime: trainData['from_std'],
            arrivalTime: trainData['to_std'],
            duration: trainData['duration'],
            durationInHours: durationInHours,
          ));
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ApiResponsePage(
              trainList: trainList,
              fromStation: fromStation,
              toStation: toStation,
              journeyDate: journeyDate,
              trainno: trainno,
            ),
          ),
        );
      }
    } catch (error) {
      print('Error making API request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: 550,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(167, 83, 240, 251),
                  Color.fromARGB(222, 29, 89, 185)
                ]),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.location_on, color: Colors.white),
                        const SizedBox(width: 16),
                        PopupMenuButton(
                          onSelected: (dynamic index) {
                            setState(() {
                              selectedLocationIndex = index;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                locations[selectedLocationIndex],
                                style: dropdownMenuLabel,
                              ),
                              const Icon(Icons.keyboard_arrow_down,
                                  color: Colors.white)
                            ],
                          ),
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuItem<int>>[
                            for (int i = 0; i < locations.length; i++)
                              PopupMenuItem(
                                value: i,
                                child:
                                    Text(locations[i], style: dropdownMenuItem),
                              ),
                          ],
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            // Navigate to the settings screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentPage()),
                            );
                          },
                          child: Icon(Icons.settings, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(
                    width: 250,
                    child: Text(
                      "Where do you want to go ?",
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                style: TextStyle(),
                                controller: _textEditingController,
                                decoration: InputDecoration(
                                  labelText: 'Type Here',
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.mic),
                              onPressed: _startListening,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            _generateText(context);
                          },
                          child: Text('Search'),
                        ),
                      ],
                    ),
                  ),
              
                ],
              ),
            ),
          ),
      

Positioned(
  bottom: 0,
  left: 0,
  right: 0,
  child: Padding(
    padding: const EdgeInsetsDirectional.only(),
    child: Padding(
      padding: const EdgeInsets.only(top: 150), // Adjust the top padding as needed
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 150, // Increase the height of the widgets
          ),
          Expanded(
              child: CardWidget(
                  text: 'New Delhi',
                  amount: '\$1000',
                  imagePath: 'assets/delhi.jpg')),
          const SizedBox(width: 20),
          Expanded(
              child: CardWidget(
                  text: 'Kolkata',
                  amount: '\$500',
                  imagePath: 'assets/kolkata.jpg')),
          const SizedBox(width: 20),
          Expanded(
              child: CardWidget(
                  text: 'Kerla',
                  amount: '\$200',
                  imagePath: 'assets/kerla.jpg')),
        ],
      ),
    ),
  ),
),



        ],
      ),
    );
  }

  void _generateText(context) async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final content = [
      Content.text(
          "You are a railway assistant bot. Return the output in key value format . you have to extract the following information from user query : from station code - station code of user's current station,  to station code - station code of user's traveling station, journey date- in YYYY-MM-DD.Its 2024.  User Query : ${_textEditingController.text}")
    ];
    final response = await model.generateContent(content);

    print("Response text: ${response.text}");

    try {
      final Map<String, dynamic> outputJson = json.decode(response.text!);

      if (outputJson != null && outputJson.isNotEmpty) {
        fromStation = outputJson['from_station_code'] ?? '';
        toStation = outputJson['to_station_code'] ?? '';
        journeyDate = outputJson['journey_date'] ?? '';
        print(fromStation);
        print(toStation);
        print(journeyDate);
        _makeApiRequest(context);
      } else {
        print("Empty or invalid JSON format received.");
      }
    } catch (e) {
      print("Error decoding JSON: $e");
    }
  }

  void _startListening() async {
    if (!speech.isListening) {
      bool available = await speech.initialize(onStatus: (status) {
        print('Speech Recognition Status: $status');
      }, onError: (error) {
        print('Speech Recognition Error: $error');
      });

      if (available) {
        speech.listen(onResult: (result) {
          if (result.finalResult) {
            setState(() {
              _textEditingController.text = result.recognizedWords;
            });
          }
        });
      } else {
        print("The user has denied the use of speech recognition.");
      }
    }
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height);

    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    var firstControlPoint = Offset(size.width / 4, size.height - 53);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    var secondEndPoint = Offset(size.width, size.height - 90);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 14);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CardWidget extends StatelessWidget {
  final String text;
  final String amount;
  final String imagePath;

  const CardWidget({
    Key? key,
    required this.text,
    required this.amount,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 48,
              width: 48,
            ),
            const SizedBox(height: 10),
            Text(text, style: TextStyle(fontSize: 18)),
            Text(amount, style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
