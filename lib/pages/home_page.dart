import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  InputImage? inputImage;
  String recognizedText = '';

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  loadImage() async {
    var bytes = await rootBundle.load('assets/handwrite.jpeg');
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/profile.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    setState(() {
      inputImage = InputImage.fromFile(file);
    });
  }

  recognizeTextHandler() async {
    if (inputImage != null) {
      final recognizedText = await textRecognizer.processImage(inputImage!);
      setState(() {
        this.recognizedText = recognizedText.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Image.asset(
                      'assets/handwrite.jpeg',
                      fit: BoxFit.fitWidth,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Recognized Text',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(recognizedText),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: inputImage != null ? recognizeTextHandler : null,
                child: const Text('Start'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
