import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class AudioRecorder {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  String? _currentFilePath;

  Future<void> init() async {
    await _recorder.openRecorder();
  }

  Future<void> requestPermissions(BuildContext context) async {
    var status = await Permission.microphone.request();

    if (status.isDenied) {
      // User denied this time → show a message
      _showPermissionDialog(
        context,
        "Microphone access is required to record audio.",
        openSettings: false,
      );
      throw Exception("Microphone permission denied");
    }

    if (status.isPermanentlyDenied) {
      // User denied forever → must open settings
      _showPermissionDialog(
        context,
        "Please enable microphone access in Settings to record audio.",
        openSettings: true,
      );
      throw Exception("Microphone permission permanently denied");
    }
  }

  void _showPermissionDialog(BuildContext context, String message,
      {required bool openSettings}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Permission Required"),
        content: Text(message),
        actions: [
          if (openSettings)
            TextButton(
              onPressed: () {
                openAppSettings();
                Navigator.pop(ctx);
              },
              child: const Text("Open Settings"),
            ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<String> startRecording(BuildContext context) async {
    await requestPermissions(context);

    final dir = await getApplicationDocumentsDirectory();
    _currentFilePath =
        '${dir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.wav';
    await _recorder.startRecorder(toFile: _currentFilePath);
    return _currentFilePath!;
  }

  Future<String?> stopRecording() async {
    await _recorder.stopRecorder();
    return _currentFilePath;
  }

  Future<void> dispose() async {
    await _recorder.closeRecorder();
  }
}
