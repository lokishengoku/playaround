import 'dart:io';

import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String? filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner'),
      ),
      body: ListView(
        children: [
          if (filePath != null)
            Image.file(
              File(filePath!),
              fit: BoxFit.contain,
            ),
          ElevatedButton(
            onPressed: () async {
              // Check permissions and request its
              bool isCameraGranted =
                  await Permission.camera.request().isGranted;
              if (!isCameraGranted) {
                isCameraGranted = await Permission.camera.request() ==
                    PermissionStatus.granted;
              }

              if (!isCameraGranted) {
                // Have not permission to camera
                return;
              }

// Generate filepath for saving
              String imagePath = join(
                  (await getApplicationSupportDirectory()).path,
                  "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

// Use below code for live camera detection with option to select from gallery in the camera feed.

              try {
                //Make sure to await the call to detectEdge.
                bool success = await EdgeDetection.detectEdge(
                  imagePath,
                  canUseGallery: true,
                  androidScanTitle:
                      'Scanning', // use custom localizations for android
                  androidCropTitle: 'Crop',
                  androidCropBlackWhiteTitle: 'Black White',
                  androidCropReset: 'Reset',
                );
                if (success) setState(() => filePath = imagePath);
              } catch (e) {
                print(e);
              }
            },
            child: const Text('Test'),
          ),
        ],
      ),
    );
  }
}
