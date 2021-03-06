import 'package:flutter_test/flutter_test.dart';
import 'package:spacex/model/dto/countdown_time.dart';
import 'dart:convert';

import 'package:spacex/model/dto/mission.dart';

const spacexJson =
    '{"fairings":{"reused":null,"recovery_attempt":null,"recovered":null,"ships":[]},"links":{"patch":'
    '{"small":"https://imgur.com/BrW201S.png","large":"https://imgur.com/573IfGk.png"},"reddit":'
    '{"campaign":"https://www.reddit.com/r/spacex/comments/jhu37i/starlink_general_discussion_and_deployment_thread/","launch":null,'
    '"media":null,"recovery":"https://www.reddit.com/r/spacex/comments/k2ts1q/rspacex_fleet_updates_discussion_thread/"},"flickr":'
    '{"small":[],"original":[]},"presskit":null,"webcast":null,"youtube_id":null,"article":null,"wikipedia":'
    '"https://en.wikipedia.org/wiki/Starlink"},"static_fire_date_utc":null,"static_fire_date_unix":null,"tbd":false,"net":false,"window":null,"rocket":'
    '"5e9d0d95eda69973a809d1ec","success":null,"details":null,"crew":[],"ships":[],"capsules":[],"payloads":["600f9bc08f798e2a4d5f97a4"],'
    '"launchpad":"5e9e4501f509094ba4566f84","auto_update":true,"launch_library_id":"985f1cc1-82c1-4a89-b2cc-e9dc91829a0e","failures":[],'
    '"flight_number":117,"name":"Starlink-19 (v1.0)","date_utc":"2021-02-15T04:20:00.000Z","date_unix":1613362800,"date_local":'
    '"2021-02-14T23:20:00-05:00","date_precision":"hour","upcoming":true,"cores":[{"core":null,"flight":null,"gridfins":null,"legs":null,'
    '"reused":null,"landing_attempt":null,"landing_success":null,"landing_type":null,"landpad":null}],"id":"600f9a5e8f798e2a4d5f979c"}';

void main() {
  group('Data class tests', () {
    test('TEST Create a data object from JSON', () {
      var jsonMap = json.decode(spacexJson);
      var testLaunch = Mission.fromJson(jsonMap);
      expect(testLaunch.missionName, 'Starlink-19 (v1.0)');
      expect(testLaunch.missionDateTime, DateTime.utc(2021, 2, 15, 04, 20));
      expect(testLaunch.flightNumber, 117);
      expect(testLaunch.unixDate, 1613362800);
      expect(testLaunch.formattedDate, '15/02/21');
    });

    test('TEST Countdown time', () {
      var _now = DateTime(2021, 01, 01, 0, 0, 0).millisecondsSinceEpoch ~/ 1000;
      var oneDay =
          DateTime(2021, 01, 02, 0, 0, 0).millisecondsSinceEpoch ~/ 1000;
      var oneHour =
          DateTime(2021, 01, 01, 1, 0, 0).millisecondsSinceEpoch ~/ 1000;
      var oneMin =
          DateTime(2021, 01, 01, 0, 1, 0).millisecondsSinceEpoch ~/ 1000;
      var oneSecond =
          DateTime(2021, 01, 01, 0, 0, 1).millisecondsSinceEpoch ~/ 1000;
      var testAll =
          DateTime(2021, 2, 3, 15, 56, 23).millisecondsSinceEpoch ~/ 1000;

      var countdownTime = CountdownTime.fromUnixDate(oneDay, now: _now);
      expect(countdownTime.days, 1);
      expect(countdownTime.hours, 0);
      expect(countdownTime.mins, 0);
      expect(countdownTime.seconds, 0);

      countdownTime = CountdownTime.fromUnixDate(oneHour, now: _now);
      expect(countdownTime.days, 0);
      expect(countdownTime.hours, 1);
      expect(countdownTime.mins, 0);
      expect(countdownTime.seconds, 0);

      countdownTime = CountdownTime.fromUnixDate(oneMin, now: _now);
      expect(countdownTime.days, 0);
      expect(countdownTime.hours, 0);
      expect(countdownTime.mins, 1);
      expect(countdownTime.seconds, 0);

      countdownTime = CountdownTime.fromUnixDate(oneSecond, now: _now);
      expect(countdownTime.days, 0);
      expect(countdownTime.hours, 0);
      expect(countdownTime.mins, 0);
      expect(countdownTime.seconds, 1);

      countdownTime = CountdownTime.fromUnixDate(testAll, now: _now);
      expect(countdownTime.days, 33);
      expect(countdownTime.hours, 15);
      expect(countdownTime.mins, 56);
      expect(countdownTime.seconds, 23);
    });
  });
}
