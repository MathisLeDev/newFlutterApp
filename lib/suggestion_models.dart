
class SuggestionModel {
  int id;
  String name;
  double latitude;
  double longitude;
  String timezone;

  SuggestionModel(
      {required this.id,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.timezone,
      });

  factory SuggestionModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final name = json['name'] as String;
    final latitude = json['latitude'] as double;
    final longitude = json['longitude'] as double;
    final timezone = json['timezone'] as String;

    return SuggestionModel(
        id: id,
        name: name,
        latitude: latitude,
        longitude: longitude,
        timezone: timezone,
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'timezone': timezone,
    };
  }

}