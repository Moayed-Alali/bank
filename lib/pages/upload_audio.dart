import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';

class AudioUploader {
  final String supabaseUrl =
      'https://your-project.supabase.co'; // عدل حسب مشروعك
  final String supabaseKey = 'your-anon-key'; // عدل حسب مشروعك

  Future<void> uploadAudio(String filePath) async {
    final file = File(filePath);
    final storage = Supabase.instance.client.storage.from('audio-files');

    try {
      final response = await storage.upload(
        'audio/${DateTime.now().millisecondsSinceEpoch}.wav',
        file,
        fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
      );
    } catch (e) {
      print('حدث خطأ أثناء رفع الملف: $e');
    }
  }
}
