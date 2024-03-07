import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hack1/paymentpage.dart';

class FareResultPage extends StatelessWidget {
  final String fareData;

  FareResultPage({required this.fareData});

  @override
  Widget build(BuildContext context) {
    // Parse the fareData JSON string
    Map<String, dynamic>? fareMap;
    try {
      fareMap = json.decode(fareData);
    } catch (e) {
      print('Error decoding fareData: $e');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Fare Result'),
        backgroundColor: Colors.blue, // Add a primary color to the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: fareMap != null
            ? SingleChildScrollView(
                // Make the content scrollable
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status: ${fareMap['status']}'),
                    Text('Message: ${fareMap['message']}'),
                    Text('Timestamp: ${fareMap['timestamp']}'),
                    SizedBox(height: 20),
                    Text('Fare Data:'),
                    if (fareMap['data'] != null &&
                        fareMap['data']['general'] != null)
                      for (var classData in fareMap['data']['general'])
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Class Type: ${classData['classType']}'),
                            Text('Fare: ${classData['fare']}'),
                            Text('Breakup:'),
                            if (classData['breakup'] != null)
                              for (var breakup in classData['breakup'])
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${breakup['title']}: ${breakup['cost']}'),
                                  ],
                                ),
                            ElevatedButton(
                              onPressed: () {
                                // Add logic for the Pay Now button
                                // You can navigate to a payment page or perform payment-related actions
                                PaymentPage();
                              },
                              child: Text('Pay Now'),
                            ),
                            Divider(
                              color: Colors.blue,
                              thickness: 2.0,
                            ),
                            SizedBox(height: 8.0),
                          ],
                        ),
                  ],
                ),
              )
            : Center(
                child: Text('Error decoding fareData'),
              ),
      ),
    );
  }
}
