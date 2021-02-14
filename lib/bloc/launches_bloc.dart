import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    debugPrint('= ${event.toString()}');

    if (event is ShowLaunchList) {
      yield WaitingForDataState();
      var launchesJson = await missionApi.getUpcomingLaunches();

      var list = Mission.makeLaunchList(launchesJson);

      // V4 of the API is broken. Querying doesn't work (as it does on V3) and
      // the 'upcoming' endpoint returns some past missions. Therefore I have
      // added a function to check and clean the list
      list = _cleanList(list);

      // update favourites
      await _loadFavourites(list);

      // display the list
      yield DisplayLaunchesState(list);
    }

    if (event is ShowLaunchCountdown) {
      // Configure the timer for the launch
      var countdownTime = CountdownTime.fromUnixDate(event.mission.unixDate);
      // display the timer
      yield DisplayCountdownState(event.mission, countdownTime);
    }

    // Share the mssion to social media
    if (event is ShareMission) {
      _shareMission(event.mission);
    }

    // Update the favourites list in shared preferences
    if (event is UpdateFavourites) {
      if (event.isAdd) {
        // add to favourites
        addItemsToFavourites(
            'favourites', [event.mission.flightNumber.toString()]);
      } else {
        // remove from favourites
        removeItemFromFavourites(
            'favourites', event.mission.flightNumber.toString());
      }
    }
  }

  List<Mission> _cleanList(List<Mission> list) {
    list.removeWhere((element) =>
        element.unixDate < DateTime.now().millisecondsSinceEpoch ~/ 1000);
    return list;
  }

  /// Share mission details
  Future _shareMission(Mission mission) async =>
      await Share.share(mission.toString());

  /// read favourites list from shared preferences and set mission favourite
  /// flag accordingly
  Future<void> _loadFavourites(List<Mission> list) async {
    List<String> favList = await fetchListFromSharedPreference('favourites');
    list.forEach((mission) => mission.isFavourite =
        favList.contains(mission.flightNumber.toString()));
  }
}

/// Add an [item] to a Shared Preference list [listName]
Future<void> addItemsToFavourites(String listName, List<String> items) async {
  assert(listName != null);
  assert(items != null);
  var prefs = await SharedPreferences.getInstance();
  var _list = await fetchListFromSharedPreference(listName);
  _list.addAll(items);
  try {
    await prefs.setStringList(listName, _list);
  } catch (e) {
    debugPrint('Failed to save $items to Shared pref list $listName list : $e');
    rethrow;
  }
}

/// remove an [item] to a Shared Preference list [listName] .
Future<void> removeItemFromFavourites(String listName, String item) async {
  assert(listName != null);
  var prefs = await SharedPreferences.getInstance();
  var _list = await fetchListFromSharedPreference(listName);
  _list.remove(item);
  try {
    await prefs.setStringList(listName, _list);
  } catch (e) {
    debugPrint(
        'Failed to remove $item from Shared pref list $listName list : $e');
    rethrow;
  }
}

/// read the list @listName fron shared preferences
Future<List<String>> fetchListFromSharedPreference(String listName) async {
  assert(listName != null);
  var prefs = await SharedPreferences.getInstance();
  var _list;
  try {
    _list = prefs.getStringList(listName);
  } catch (e) {
    _list = [];
  }
  return _list ?? [];
}
