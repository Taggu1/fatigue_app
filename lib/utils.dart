import 'dart:convert';
import 'package:fatigue_predictor_website/domain/fatiuge_data.dart';
import 'package:http/http.dart' as http;

Future<String> getFatigueRecommendation(FatigueData data) async {
  // Use the URL from your Hugging Face Space
  final url = Uri.parse(
    'https://hisham13-fatigue-predictor.hf.space/recommend',
  );

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data.toJson()),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> result = jsonDecode(response.body);
      return result['recommendation'];
    } else {
      return 'Error: ${response.statusCode}';
    }
  } catch (e) {
    return 'Failed to connect: $e';
  }
}
