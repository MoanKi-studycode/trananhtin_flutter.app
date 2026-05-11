import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PageCall extends StatefulWidget {
  const PageCall({super.key});

  @override
  _PageCallState createState() => _PageCallState();
}

class _PageCallState extends State<PageCall> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _makeCall() async {
    final Uri url = Uri.parse('tel:${_controller.text}');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Call App')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration:  InputDecoration(labelText: 'Enter phone number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _makeCall,
              child: Text('Call'),
            ),
          ],
        ),
      ),
    );
  }
}