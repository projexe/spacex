import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spacex/model/dataservice/data_service.dart';
import 'package:spacex/model/dto/countdown_time.dart';
import 'package:spacex/model/dto/mission.dart';

part 'launches_event.dart';
part 'launches_state.dart';

class LaunchesBloc extends Bloc<LaunchesEvent, LaunchesState> {
  ApiInterface missionApi;

  LaunchesBloc({this.missionApi}) : super(LaunchesInitial());

  @override
  Stream<LaunchesState> mapEventToState(
    LaunchesEvent event,
  ) async* {
    // TODO: implement mapEventToState

    debugPrint('= ${event.toString()}');

    if (event is ShowLaunchList) {
      yield WaitingForDataState();
      var launchesJson = await missionApi.getUpcomingLaunches();

      var list = Mission.makeLaunchList(launchesJson);

      // V4 of the API is broken. Querying doesn't work (as it does on V3) and
      // the 'upcoming' endpoint returns some past missions. Therefore I have
      // added a function to check and clean the list
      list = _cleanList(list);

      // display the list
      yield DisplayLaunchesState(list);
    }
    if (event is ShowLaunchCountdown) {
      // Configure the timer for the launch
      var countdownTime = CountdownTime.fromUnixDate(event.mission.unixDate);
      // display the timer
      yield DisplayCountdownState(event.mission.missionName, countdownTime);
    }
  }
}

List<Mission> _cleanList(List<Mission> list) {
  list.removeWhere((element) =>
      element.unixDate < DateTime.now().millisecondsSinceEpoch ~/ 1000);
  return list;
}
