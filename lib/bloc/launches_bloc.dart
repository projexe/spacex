import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'launches_event.dart';
part 'launches_state.dart';

class LaunchesBloc extends Bloc<LaunchesEvent, LaunchesState> {
  LaunchesBloc() : super(LaunchesInitial());

  @override
  Stream<LaunchesState> mapEventToState(
    LaunchesEvent event,
  ) async* {
    // TODO: implement mapEventToState

    debugPrint('= ${event.toString()}');

    if (event is ShowLaunchList) {
      // fetch the launch list from the api
      yield WaitingForDataState();
      // display the list
      yield DisplayLaunchesState();
    }
    if (event is ShowLaunchCountdown) {
      // Configure the timer for the launch

      // display the timer
      yield DisplayCountdownState();
    }
  }
}
