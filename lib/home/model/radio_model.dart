import 'dart:convert';

class RadioStation {
  final int? id;
  final String? name;
  final String? url;
  final String? recentDate;

  RadioStation({
    this.id,
    this.name,
    this.url,
    this.recentDate,
  });

  // Convert JSON to Dart object
  factory RadioStation.fromJson(Map<String, dynamic> json) {
    return RadioStation(
      id: json['id'] as int?, // Nullable int
      name: json['name'] as String?, // Nullable String
      url: json['url'] as String?,
      recentDate: json['recent_date'] as String?,
    );
  }

  // Convert Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'recent_date': recentDate,
    };
  }
}
