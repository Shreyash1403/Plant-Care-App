class Weather {
  final String cityName;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String weatherDescription;
  final String weatherIcon;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.weatherDescription,
    required this.weatherIcon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json['current'] ?? {};
    return Weather(
      cityName: json['location']?['name'] as String? ?? 'Unknown',
      temperature: (current['temperature'] as num?)?.toDouble() ?? 0.0,
      humidity: current['humidity'] as int? ?? 0,
      windSpeed: (current['wind_speed'] as num?)?.toDouble() ?? 0.0,
      weatherDescription:
          (current['weather_descriptions'] as List?)?.firstOrNull as String? ??
              'Unknown',
      weatherIcon:
          (current['weather_icons'] as List?)?.firstOrNull as String? ?? '',
    );
  }
}

extension FirstOrNull<E> on List<E>? {
  E? get firstOrNull => this != null && this!.isNotEmpty ? this![0] : null;
}
