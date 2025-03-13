class PrayerTimesModel {
  final Timings timings;
  final DateInfo date;
  final Meta meta;

  PrayerTimesModel({
    required this.timings,
    required this.date,
    required this.meta,
  });

  factory PrayerTimesModel.fromJson(Map<String, dynamic> json) {
    return PrayerTimesModel(
      timings: Timings.fromJson(json['data']['timings']),
      date: DateInfo.fromJson(json['data']['date']),
      meta: Meta.fromJson(json['data']['meta']),
    );
  }
}

class Timings {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;
  final String firstthird;
  final String lastthird;

  Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstthird,
    required this.lastthird,
  });

  factory Timings.fromJson(Map<String, dynamic> json) {
    return Timings(
      fajr: json['Fajr'],
      sunrise: json['Sunrise'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      sunset: json['Sunset'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
      imsak: json['Imsak'],
      midnight: json['Midnight'],
      firstthird: json['Firstthird'],
      lastthird: json['Lastthird'],
    );
  }
}

class DateInfo {
  final String readable;
  final String timestamp;
  final Hijri hijri;
  final Gregorian gregorian;

  DateInfo({
    required this.readable,
    required this.timestamp,
    required this.hijri,
    required this.gregorian,
  });

  factory DateInfo.fromJson(Map<String, dynamic> json) {
    return DateInfo(
      readable: json['readable'],
      timestamp: json['timestamp'],
      hijri: Hijri.fromJson(json['hijri']),
      gregorian: Gregorian.fromJson(json['gregorian']),
    );
  }
}

class Hijri {
  final String date;
  final String year;
  final String month;
  final List<String> holidays;

  Hijri({
    required this.date,
    required this.year,
    required this.month,
    required this.holidays,
  });

  factory Hijri.fromJson(Map<String, dynamic> json) {
    return Hijri(
      date: json['date'],
      year: json['year'],
      month: json['month']['en'],
      holidays: List<String>.from(json['holidays']),
    );
  }
}

class Gregorian {
  final String date;
  final String year;
  final String month;

  Gregorian({
    required this.date,
    required this.year,
    required this.month,
  });

  factory Gregorian.fromJson(Map<String, dynamic> json) {
    return Gregorian(
      date: json['date'],
      year: json['year'],
      month: json['month']['en'],
    );
  }
}

class Meta {
  final double latitude;
  final double longitude;
  final String timezone;

  Meta({
    required this.latitude,
    required this.longitude,
    required this.timezone,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      latitude: json['latitude'],
      longitude: json['longitude'],
      timezone: json['timezone'],
    );
  }
}
