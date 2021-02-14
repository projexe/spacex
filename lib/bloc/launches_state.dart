part of 'launches_bloc.dart';

abstract class LaunchesState extends Equatable {
  const LaunchesState();
}

class LaunchesInitial extends LaunchesState {
  @override
  List<Object> get props => [];
}

class WaitingForDataState extends LaunchesState {
  @override
  List<Object> get props => [];
}

class DisplayLaunchesState extends LaunchesState {
  final List<Mission> missionList;
  DisplayLaunchesState(this.missionList);
  @override
  List<Object> get props => [missionList];
}

class DisplayCountdownState extends LaunchesState {
  final String missionName;
  final CountdownTime time;
  DisplayCountdownState(this.missionName, this.time);
  @override
  List<Object> get props => [missionName, time];
}




