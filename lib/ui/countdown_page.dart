import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/bloc/launches_bloc.dart';
import 'package:spacex/model/dto/countdown_time.dart';

class CountdownPage extends StatefulWidget {
  final CountdownTime time;
  CountdownPage({this.time});
  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  Timer timer;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchesBloc, LaunchesState>(
      cubit: BlocProvider.of<LaunchesBloc>(context),
      builder: (context, LaunchesState state) => Scaffold(
        appBar: AppBar(
          title: Text('Countdown'),
        ),
        body: Column(
          children: [
            Text('Days'),
            Text('${widget.time.days}'),
            Text('Hours'),
            Text('${widget.time.hours}'),
            Text('Minutes'),
            Text('${widget.time.mins}'),
            Text('Seconds'),
            Text('${widget.time.seconds}'),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    startCountdown();
  }

  @override
  void dispose() {
    super.dispose();
    // cancel timer when disposing the widget
    if (timer.isActive) {
      timer.cancel();
    }
  }

  void startCountdown() {
    // create and start a timer to set local state and display countdown clock
    // every second
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        widget.time.tick();
      });
    });
  }
}
