import 'package:flutter/material.dart';

abstract class Launch {
  DateTime missionDateTime;
  String missionName;
  Launch({this.missionName, this.missionDateTime});
}

class LaunchImp implements Launch {
  @override
  DateTime missionDateTime;

  @override
  String missionName;

  LaunchImp({this.missionName, this.missionDateTime});

  factory LaunchImp.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    try {
      var _launch = LaunchImp(
        missionDateTime: DateTime.tryParse(json['date_utc'] ?? ''),
        missionName: (json['name']?.toString()?.trim()),
      );
      return _launch;
    } catch (e) {
      debugPrint('error creating Launch object: $e');
      rethrow;
    }
  }
}
