import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex/bloc/launches_bloc.dart';
import 'package:spacex/model/dto/countdown_time.dart';
import 'package:spacex/model/dto/mission.dart';

class CountdownPage extends StatefulWidget {
  final CountdownTime time;
  final Mission mission;
  CountdownPage(this.mission, this.time);
  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  Timer timer;
  LaunchesBloc bloc;
  bool isFavourite;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchesBloc, LaunchesState>(
      cubit: BlocProvider.of<LaunchesBloc>(context),
      builder: (context, LaunchesState state) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 100,
          title: Text('${widget.mission.missionName}'),
          actions: [
            IconButton(
                icon: isFavourite
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
                onPressed: () {
                  bloc.add(UpdateFavourites(widget.mission,
                      isAdd: isFavourite ? false : true));
                  setState(() {
                    isFavourite = !isFavourite;
                  });
                }
                 ),
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () => bloc.add(ShareMission(widget.mission)))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CountdownDataWidget(widget.time.days),
              CountdownLabelWidget('DAYS'),
              CountdownDataWidget(widget.time.hours),
              CountdownLabelWidget('HOURS'),
              CountdownDataWidget(widget.time.mins),
              CountdownLabelWidget('MINUTES'),
              CountdownDataWidget(widget.time.seconds),
              CountdownLabelWidget('SECONDS'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<LaunchesBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavourite = widget.mission.isFavourite ?? false;
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

class CountdownLabelWidget extends StatelessWidget {
  final String label;
  const CountdownLabelWidget(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text('$label',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            )),
      ),
    );
  }
}

class CountdownDataWidget extends StatelessWidget {
  final int value;
  CountdownDataWidget(this.value);
  @override
  Widget build(BuildContext context) =>
      Text('$value', style: TextStyle(color: Colors.white, fontSize: 50));
}
