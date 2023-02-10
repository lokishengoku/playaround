import 'dart:io';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? file;
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            if (file != null)
              Image.file(
                file!,
                fit: BoxFit.contain,
              ),
            if (filePath != null)
              Image.file(
                File(filePath!),
                fit: BoxFit.contain,
              ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // final scannedDoc =
                  //     await DocumentScannerFlutter.launch(context);
                  // if (scannedDoc != null) setState(() => file = scannedDoc);
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Test'),
            ),
          ],
        ),
      ),
    );
  }
}
