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
  @override
  List<Object> get props => [];
}

class DisplayCountdownState extends LaunchesState {
  @override
  List<Object> get props => [];
}




