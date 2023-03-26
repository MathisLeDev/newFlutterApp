class CurrentWeatherModel {
  double temperature;
  int weatherCode;

  CurrentWeatherModel({
    required this.temperature,
    required this.weatherCode,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    final temperature = json['temperature'] as double;
    final weatherCode = json['weathercode'] as int;
    return CurrentWeatherModel(
        temperature: temperature,
        weatherCode: weatherCode
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'weatherCode': weatherCode,
    };
  }

}