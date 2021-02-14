import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:spacex/model/dataservice/data_service.dart';
import 'dart:convert';
import 'package:spacex/model/dto/mission.dart';



void main() {
  group('Api class tests', () {
    test('TEST Call to Next launches', () async {
      var apiService = LaunchDataService(http.Client(),
          endPoint: 'https://api.spacexdata.com/v4/launches');
      // currently testing live api
      var launchResponse = await apiService.getNextLaunch();
      var jsonMap = json.decode(launchResponse);
      var testLaunch = Mission.fromJson(jsonMap);
      expect(testLaunch.missionName, 'Starlink-19 (v1.0)' );
      expect(testLaunch.missionDateTime, DateTime.utc(2021, 2, 15, 04, 21 ));
    });

    test('TEST Call to Upcoming launches', () async {
      var apiService = LaunchDataService(http.Client(),
          endPoint: 'https://api.spacexdata.com/v4/launches');
      var launchResponse = await apiService.getUpcomingLaunches();
      var launches = Mission.makeLaunchList(launchResponse);
      expect(launches.length, 16 );
      expect(launches[0].missionDateTime, DateTime.utc(2021, 2, 15, 04, 21 ));
    });
  });
}
