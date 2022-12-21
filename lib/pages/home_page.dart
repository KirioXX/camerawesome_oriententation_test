import 'package:auto_route/auto_route.dart';
import 'package:camerawesome_test/pages/camera/camera_page.dart';
import 'package:camerawesome_test/router.gr.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _captureInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_captureInfo != null) Text(_captureInfo.toString()),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final response = await context.router
                    .push<CameraPageResponse?>(CameraRoute());
                setState(() {
                  _captureInfo = response?.filePath;
                });
              },
              child: const Text('Open camera (picture)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final response = await context.router.push<CameraPageResponse?>(
                  CameraRoute(
                    captureMode: CaptureMode.video,
                    maxVideoDuration: const Duration(seconds: 5),
                  ),
                );
                setState(() {
                  _captureInfo = response?.filePath;
                });
              },
              child: const Text('Open camera (video)'),
            ),
          ],
        ),
      ),
    );
  }
}
