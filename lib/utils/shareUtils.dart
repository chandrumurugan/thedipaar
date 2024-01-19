


import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:share_plus/share_plus.dart';

class ShareUtils {
  static Future<void> share(String title, String? imageUrl,String? id) async {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      try {
        final imageFile = await _downloadAndSaveImage(imageUrl);
        if (imageFile != null) {
          await Share.shareFiles([imageFile.path,], text: "${title}\n${id}",);
        } else {
          print('Image not found or could not be downloaded.');
        }
      } catch (e) {
        print('Error sharing image: $e');
      }
    } else {
      print('Image URL is empty or null');
    }
  }

  static Future<File?> _downloadAndSaveImage(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/image.jpg';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } catch (e) {
      print('Error downloading image: $e');
      return null;
    }
  }
}
