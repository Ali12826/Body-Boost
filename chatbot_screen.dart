import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Gpt3ChatScreen extends StatefulWidget {
  @override
  _Gpt3ChatScreenState createState() => _Gpt3ChatScreenState();
}

class _Gpt3ChatScreenState extends State<Gpt3ChatScreen> {
  TextEditingController _textController = TextEditingController();
  List<String> _chatMessages = [];

  final String gpt3ApiKey = 'YOUR_GPT3_API_KEY';
  final String gpt3ApiUrl = 'https://api.openai.com/v1/engines/davinci/completions';

  Future<void> _sendMessage(String messageText) async {
    if (messageText.trim().isEmpty) return;

    setState(() {
      _chatMessages.add('User: $messageText');
    });

    _textController.clear();

    try {
      final response = await http.post(
        Uri.parse(gpt3ApiUrl),
        headers: {
          'Authorization': 'Bearer $gpt3ApiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'prompt': messageText,
          'max_tokens': 50, // Adjust based on desired output length
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final botResponse = responseData['choices'][0]['text'];

        setState(() {
          _chatMessages.add('Bot: $botResponse');
        });
      } else {
        print('Failed to send message to GPT-3 API');
      }
    } catch (e) {
      print('Error sending message to GPT-3 API: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPT-3 Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_chatMessages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_textController.text.trim());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
