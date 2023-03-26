class DailyWeatherModel {
  double temperature;
  int weatherCode;
  String date;

  DailyWeatherModel({
    required this.temperature,
    required this.weatherCode,
    required this.date,
  });

  factory DailyWeatherModel.fromJson(Map<String, dynamic> json, int index) {
    final temperature = json['temperature_2m'][index] as double;
    final date = DateTime.parse(json['time'][index]);
    final weatherCode = json['weathercode'][index] as int;
    
    return DailyWeatherModel(
        temperature: temperature,
        date: "${date.hour.toString().padLeft(2, '0')}:00",
        weatherCode: weatherCode);
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'date': date,
      'weatherCode': weatherCode,
    };
  }

}