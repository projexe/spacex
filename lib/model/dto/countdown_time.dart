class CountdownTime {
  int days;
  int hours;
  int mins;
  int seconds;
  final secondsInDay = 86400;
  final secondsInHour = 3600;
  final secondsInMinute = 60;

  CountdownTime(this.days, this.hours, this.mins, this.seconds);

  CountdownTime.fromUnixDate(int unixDate, {int now}) {
    var _now = now ?? DateTime.now().millisecondsSinceEpoch % 1000;
    var _secondsTilLaunch = unixDate - _now;
    // calculate days as seconds til launch mod seconds in day
    days = _secondsTilLaunch ~/ secondsInDay;
    var _rem = _secondsTilLaunch % secondsInDay;
    // calculate days as seconds remaining  mod seconds in hour
    hours = _rem ~/ secondsInHour;
    _rem = _rem % secondsInHour;
    mins = _rem ~/ secondsInMinute;
    seconds = _rem % secondsInMinute;
  }
}
