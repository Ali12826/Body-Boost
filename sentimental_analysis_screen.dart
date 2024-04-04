import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';


class SentimentAnalysisScreen extends StatefulWidget {
  @override
  _SentimentAnalysisScreenState createState() => _SentimentAnalysisScreenState();
}

class _SentimentAnalysisScreenState extends State<SentimentAnalysisScreen> {
  TextEditingController _textController = TextEditingController();
  String _predictedSentiment = '';
  bool _modelLoaded = false;

  get Tflite => null;

  get inputText => null;

  @override
  void initState() {
    super.initState();
    // Load the model when the screen is initialized
    loadModel();
  }

  // Method to load the TFLite model
  loadModel() async {
    // Load the model
    var modelFile = 'tflite_model_another2 (1).tflite'; // Replace with the path to your model file
    var labelsFile = 'file.txt'; // Replace with the path to your labels file

    await Tflite.loadModel(
      model: modelFile,
      labels: labelsFile,
    );

    // Perform any additional setup after the model is loaded
    print('Model loaded successfully');
    setState(() {
      _modelLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sentiment Analysis'),
      ),
      body: _modelLoaded
          ? CircularProgressIndicator():
        Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter text',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _predictSentiment();
              },
              child: Text('Predict Sentiment'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Predicted Sentiment: $_predictedSentiment',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )

         // Show loading indicator while model is being loaded
    );
  }

  // Method to predict sentiment using the loaded model
  void _predictSentiment() async {
    var output = await Tflite.runModelOnBinary(
      binary: inputText,
    );

    // Print the output for debugging
    print('Output: $output');

    setState(() {
      _predictedSentiment = output?[0]['label'];
    });
  }


  @override
  void dispose() {
    // Release resources when the screen is disposed
    Tflite.close();
    super.dispose();
  }
}
