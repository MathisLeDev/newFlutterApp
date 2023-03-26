class WeeklyWeatherModel {
  String temperature;
  int weatherCode;
  DateTime date;

  WeeklyWeatherModel({
    required this.temperature,
    required this.weatherCode,
    required this.date,
  });

  factory WeeklyWeatherModel.fromJson(Map<String, dynamic> json, int index) {
    final date = DateTime.parse(json['time'][index]);
    final temp_max = json['temperature_2m_max'][index] as num;
    final temp_min = json['temperature_2m_min'][index] as num;
    
    final temperature = "${temp_max.round()}/${temp_min.round()}";
    final weatherCode = json['weathercode'][index] as int;
    return WeeklyWeatherModel(
        temperature: temperature,
        date: date,
        weatherCode: weatherCode
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'date': date,
      'weatherCode': weatherCode,
    };
  }

}