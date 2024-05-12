import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sentiment Analysis App',
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
        final List<String> sentiments = [];
        labelMapping.forEach((label, sentiment) {
          final score = labelScores[label] ?? 0;
          final percentage = totalScore > 0 ? (score / totalScore) * 100 : 0;
          sentiments.add('$sentiment (${percentage.toStringAsFixed(2)}%)');
        });
        final String sentimentText = sentiments.join(', ');

        // Determine sentiment category
        String sentimentCategory = '';
        labelMapping.forEach((label, sentiment) {
          final score = labelScores[label] ?? 0;
          if (score > 0.5) {
            sentimentCategory = sentiment;
          }
        });

        // Update sentiment result
        setState(() {
          _sentimentResult = sentimentText;

          // Navigate to respective screens based on sentiment category
          if (sentimentCategory == 'Negative') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NegativeScreen()),
            );
          } else if (sentimentCategory == 'Positive') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PositiveScreen()),
            );
          }
        });
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
        title: Text('Sentiment Analysis App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                hintText: 'Enter your input...',
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

class NegativeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Negative Sentiment'),
        backgroundColor: Colors.red, // Match your app's color scheme
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Try exercises like Yoga, Push Up, or Weight Lifting:',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              padding: EdgeInsets.all(20),
              children: [
                _buildExerciseCard(
                  context,
                  title: 'Yoga',
                  image: 'assets/yoga.jpg',
                  videoUrl: 'assets:videos/yoga_video.mp4',
                ),
                _buildExerciseCard(
                  context,
                  title: 'Push Up',
                  image: 'assets/push_up.jpg',
                  videoUrl: 'assets:videos/push_up_video.mp4',
                ),
                _buildExerciseCard(
                  context,
                  title: 'Weight Lifting',
                  image: 'assets/weight_lifting.jpg',
                  isVideo: false, // No video for Weight Lifting
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(BuildContext context,
      {required String title, required String image, String? videoUrl, bool isVideo = true}) {
    return GestureDetector(
      onTap: () {
        // Handle tap, e.g., navigate to exercise detail screen
        if (isVideo && videoUrl != null) {
          // Open video URL
        } else {
          // Handle image tap, if needed
        }
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isVideo
                ? Icon(Icons.play_circle_filled, size: 50, color: Colors.red) // Video play icon
                : Image.asset(image, width: 100, height: 100, fit: BoxFit.cover),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class PositiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Positive Sentiment'),
      ),
      body: Center(
        child: Text(
          'Try exercises like Running, Weight Lifting, or High Intensity Workout.',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
