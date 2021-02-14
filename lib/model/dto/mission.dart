import 'package:flutter/material.dart';
import 'dart:convert';

class Mission {
  DateTime missionDateTime;
  String missionName;

  Mission({this.missionName, this.missionDateTime});

  factory Mission.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    try {
      var _launch = Mission(
        missionDateTime: DateTime.tryParse(json['date_utc'] ?? ''),
        missionName: (json['name']?.toString()?.trim()),
      );
      return _launch;
    } catch (e) {
      debugPrint('error creating Launch object: $e');
      rethrow;
    }
  }

  /// Data utility function creates a List<Launch> from a JSON list of
  /// launches..
  static List<Mission> makeLaunchList(String launchListJson) {
    var jsonList = [];
    try {
      jsonList = json.decode(launchListJson) as List;
    } catch (e) {
      jsonList = List(0);
    }

    var _launchList = <Mission>[];

    if (jsonList != null) {
      jsonList.forEach((item) {
        try {
          _launchList.add(Mission.fromJson(item));
        } catch (e) {
          // continue with next Launch
        }
      });
    }

    return _launchList;
  }
}
