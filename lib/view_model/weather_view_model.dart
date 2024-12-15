import 'dart:convert';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../model/weather_model.dart';

class WeatherViewModel extends ChangeNotifier {
  Weather? _weather;
  bool _isLoading = false;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    final url =
        'http://api.weatherstack.com/current?access_key=470bd2eee0e5514a0f8d9ff2f701554b&query=$city';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _weather = Weather.fromJson(data);
      } else {
        if (kDebugMode) {
          print(
              'Failed to fetch weather data. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching weather: $e');
      }
    }

    _isLoading = false;
    notifyListeners();
  }
}
