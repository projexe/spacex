part of 'launches_bloc.dart';

abstract class LaunchesEvent extends Equatable {
  const LaunchesEvent();
}

class AddToFavourites extends LaunchesEvent {
  final String launchNumber;
  AddToFavourites(this.launchNumber);
  @override
  List<Object> get props => [launchNumber];
}

class ShowLaunchCountdown extends LaunchesEvent {
  final int flightNumber;
  ShowLaunchCountdown(this.flightNumber);
  @override
  List<Object> get props => [flightNumber];
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
