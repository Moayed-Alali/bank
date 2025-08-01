import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pulsator/pulsator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:voice_ai_app/pages/audio_recorder.dart';
import 'package:uuid/uuid.dart';
import 'package:mime/mime.dart';

class AiAssistent extends StatefulWidget {
  const AiAssistent({super.key});

  @override
  State<AiAssistent> createState() => _AiAssistentState();
}

class _AiAssistentState extends State<AiAssistent> {
  late AudioRecorder _recorder;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();
    _recorder = AudioRecorder();
    _recorder.init();
  }

  /// Request microphone permission before recording
  Future<bool> _requestMicPermission() async {
    var status = await Permission.microphone.status;

    if (status.isDenied) {
      status = await Permission.microphone.request();
    }

    if (status.isPermanentlyDenied) {
      // Open iOS Settings if permanently denied
      await openAppSettings();
      return false;
    }

    return status.isGranted;
  }

  Future<void> _startRecording() async {
    try {
      // 🔹 Ensure permission request happens first
      bool granted = await _requestMicPermission();
      if (!granted) {
        print("❌ Microphone permission not granted.");
        setState(() => isRecording = false);
        return;
      }

      setState(() => isRecording = true);
      await _recorder.startRecording(context);
      print("🎙 Started recording...");
    } catch (e) {
      print("❌ $e");
      setState(() => isRecording = false);
    }
  }

  Future<void> _stopAndUpload() async {
    setState(() => isRecording = false);
    final filePath = await _recorder.stopRecording();
    print("⏹ Stopped recording.");

    if (filePath != null && filePath.isNotEmpty) {
      await _storeInDatabase(filePath);
    }
  }

  Future<void> _storeInDatabase(String filePath) async {
    try {
      final supabase = Supabase.instance.client;
      final fileBytes = await File(filePath).readAsBytes();

      // Detect MIME type
      final mimeType = lookupMimeType(filePath) ?? 'application/octet-stream';

      // Generate a unique file name (UUID) with proper extension
      final extension = mimeType.split('/').last; // e.g., wav, mpeg
      final uniqueFileName = const Uuid().v4(); // random unique id
      final finalPath = 'user123/$uniqueFileName.$extension';

      await supabase.storage
          .from('audios') // <-- Your Supabase bucket name
          .uploadBinary(
            finalPath,
            fileBytes,
            fileOptions: FileOptions(
              upsert: true,
              contentType: mimeType,
            ),
          );

      print("✅ Audio uploaded to bucket: $finalPath with type: $mimeType");
    } catch (e) {
      print("❌ Error uploading audio to bucket: $e");
    }
  }

  @override
  void dispose() {
    if (isRecording) _recorder.stopRecording();
    _recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: const Text(
          'المساعد أُفُق',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1B263B),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () async {
            if (isRecording) {
              // If already recording → stop and upload
              await _stopAndUpload();
            } else {
              // If not recording → start
              await _startRecording();
            }
          },
          child: Pulsator(
            style: PulseStyle(
              color: Colors.blue.withOpacity(isRecording ? 0.6 : 0.2),
            ),
            count: 7,
            duration: const Duration(seconds: 1),
            repeat: isRecording ? 0 : 1,
            autoStart: isRecording,
            fit: PulseFit.cover,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isRecording ? Icons.mic : Icons.mic_none,
                    color: Colors.black,
                    size: 40,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    isRecording ? "جارٍ التسجيل..." : "اضغط مع الاستمرار",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
