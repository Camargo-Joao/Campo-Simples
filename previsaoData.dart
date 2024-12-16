import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '8f295c182fb12b5a1bde691094a9fd89';
  final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> fetchWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$apiUrl?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Falha ao carregar dados do tempo');
    }
  }
}
