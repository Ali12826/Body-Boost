import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../exercise/exercise_view_2.dart';
import '../exercise/negative_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sentiment Analysis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SentimentAnalysisPage(),
    );
  }
}

class SentimentAnalysisPage extends StatefulWidget {
  @override
  _SentimentAnalysisPageState createState() => _SentimentAnalysisPageState();
}

class _SentimentAnalysisPageState extends State<SentimentAnalysisPage> {
  TextEditingController _inputController = TextEditingController();
  String _inputText = '';
  String _sentimentResult = '';

  final String API_URL =
      "https://api-inference.huggingface.co/models/cardiffnlp/twitter-roberta-base-sentiment";
  final String token = "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";

  // Mapping between original labels and sentiment categories
  final Map<String, String> labelMapping = {
    'LABEL_0': 'Negative',
    'LABEL_1': 'Neutral',
    'LABEL_2': 'Positive',
  };

  Future<void> _getSentimentAnalysis(String input) async {
    final Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };

    final response = await http.post(
      Uri.parse(API_URL),
      headers: headers,
      body: jsonEncode({"inputs": input}),
    );

    if (response.statusCode == 200) {
      final dynamic output = jsonDecode(response.body);
      if (output.isNotEmpty) {
        final List<dynamic> results = output[0];
        final Map<String, double> labelScores = {};
        double totalScore = 0;
        results.forEach((result) {
          final label = result['label'];
          final score = result['score'];
          labelScores[label] = score;
          totalScore += score;
        });

        // Calculate sentiment percentages
        double positiveScore = labelScores['LABEL_2'] ?? 0;
        double neutralScore = labelScores['LABEL_1'] ?? 0;
        double negativeScore = labelScores['LABEL_0'] ?? 0;

        if (positiveScore + neutralScore > negativeScore) {
          // More positive or neutral sentiment
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExerciseView2()),
          );
        } else {
          // More negative sentiment
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NegativeView()),
          );
        }
      } else {
        setState(() {
          _sentimentResult = 'Output is empty';
        });
      }
    } else {
      setState(() {
        _sentimentResult = 'Failed to get sentiment analysis';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sentiment Analysis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                hintText: 'How You Are Feeling Today.... ',
              ),
              onChanged: (value) {
                setState(() {
                  _inputText = value;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String input = _inputController.text.trim();
                if (input.isNotEmpty) {
                  await _getSentimentAnalysis(input);
                } else {
                  setState(() {
                    _sentimentResult = 'Input is empty';
                  });
                }
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 16),
            Text(
              'Sentiment Result: $_sentimentResult',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}



