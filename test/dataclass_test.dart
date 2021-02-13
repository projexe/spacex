import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

const spacexJson = '{"fairings":{"reused":null,"recovery_attempt":null,"recovered":null,"ships":[]},"links":{"patch":'
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
      //var testLaunch = LaunchImp.fromJson(jsonMap);
      //expect(testlaunch.missionName, 'Starlink-19 (v1.0)' );
      //expect(testLaunch.missionDate, DateTime(2021, 2, 14, 04, 20 ));
    });
  });
}
