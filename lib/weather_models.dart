class WeatherModel {
  String ville;
  String region;
  String pays;
  double temperature;
  String description;
  String icon;
  DateTime date;
  int humidite;
  double vent;
  String prevision;

  WeatherModel(
    {
      required this.ville,
      required this.region,
      required this.pays,
      required this.temperature,
      required this.description,
      required this.icon,
      required this.date,
      required this.humidite,
      required this.vent,
      required this.prevision
    }
  );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final ville = json['location']['ville'] as String;
    final region = json['location']['region'] as String;
    final pays = json['location']['pays'] as String;
    final temperature = json['current']['temperature'] as double;
    final description = json['current']['description'] as String;
    final icon = json['current']['icon'] as String;
    final date = DateTime.fromMillisecondsSinceEpoch((json['current']['date'] as int) * 1000);
    final humidite = json['current']['humidite'] as int;
    final vent = json['current']['vent'] as double;
    final prevision = json['current']['prevision'] as String;

    return WeatherModel(
        ville: ville,
        region: region,
        pays: pays,
        temperature: temperature,
        description: description,
        icon: icon,
        date: date,
        humidite: humidite,
        vent: vent,
        prevision: prevision);
  }

  Map<String, dynamic> toJson() {
    return {
      'ville': ville,
      'region': region,
      'pays': pays,
      'temperature': temperature,
      'description': description,
      'icon': icon,
      'date': date.toIso8601String(),
      'humidite': humidite,
      'vent': vent,
      'prevision': prevision,
    };
  }

}