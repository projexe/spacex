import 'package:flutter/material.dart';

///
///RightToLeftTransition : Performs a right to left page swipe transition
///
class RightToLeftTransition<T> extends PageRouteBuilder<T> {
  final Widget page;
  @override
  final RouteSettings settings;
  RightToLeftTransition({this.page, this.settings})
      : super(
          transitionDuration: const Duration(milliseconds: 400),
          settings: settings,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            var _begin = Offset(1.0, 0.0);
            var _end = Offset.zero;
            var _curve = Curves.fastOutSlowIn;
            var _tween = Tween<Offset>(begin: _begin, end: _end);
            var _curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: _curve,
            );
            return SlideTransition(
              position: _tween.animate(_curvedAnimation),
              child: child,
            );
          },
        );
}
