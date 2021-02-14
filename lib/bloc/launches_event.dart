part of 'launches_bloc.dart';

abstract class LaunchesEvent extends Equatable {
  const LaunchesEvent();
}

class UpdateFavourites extends LaunchesEvent {
  final Mission mission;
  final bool isAdd;
  UpdateFavourites(this.mission, {this.isAdd});
  @override
  List<Object> get props => [mission, isAdd];
}

class ShareMission extends LaunchesEvent {
  final Mission mission;
  ShareMission(this.mission);
  @override
  List<Object> get props => [mission];
}

class ShowLaunchCountdown extends LaunchesEvent {
  final Mission mission;
  ShowLaunchCountdown(this.mission);
  @override
  List<Object> get props => [mission];
}

class ShowLaunchList extends LaunchesEvent {
  ShowLaunchList();
  @override
  List<Object> get props => [];
}

class ShareToSocialMedia extends LaunchesEvent {
  final String launchNumber;
  ShareToSocialMedia(this.launchNumber);
  @override
  List<Object> get props => [launchNumber];
}
