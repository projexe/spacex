import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Mission {
  DateTime missionDateTime;
  String missionName;
  int flightNumber;
  int unixDate;

  Mission(
      {this.missionName,
      this.missionDateTime,
      this.flightNumber,
      this.unixDate});

  factory Mission.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    try {
      var _launch = Mission(
        missionDateTime: DateTime.tryParse(json['date_utc'] ?? ''),
        missionName: (json['name']?.toString()?.trim()),
        flightNumber: (json['flight_number'] ?? 0),
        unixDate: (json['date_unix'] ?? 0),
      );
      return _launch;
    } catch (e) {
      debugPrint('error creating Launch object: $e');
      rethrow;
    }
  }

  String get formattedDate =>
      formatDate(missionDateTime, [dd, '/', mm, '/', yy]);

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
