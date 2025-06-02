import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ObjectDetectionService {
  static const String _apiUrl = 'https://api.api-ninjas.com/v1/objectdetection';
  static const String _apiKey = 'R/FKli0AaFWkSP0r/mYq4g==GiMi2XENvYAgyZDH'; 

  Future<List<Map<String, dynamic>>> detectObjects(String imagePath) async {
    var request = http.MultipartRequest('POST', Uri.parse(_apiUrl));
    request.headers['X-Api-Key'] = _apiKey;
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      return List<Map<String, dynamic>>.from(json.decode(responseBody));
    } else {
      throw Exception('Error al detectar objetos: ${response.statusCode}');
    }
  }
}
