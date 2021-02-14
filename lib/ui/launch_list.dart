import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:spacex/bloc/launches_bloc.dart';
import 'package:spacex/model/dataservice/data_service.dart';
import 'package:spacex/model/dto/mission.dart';
import 'package:spacex/ui/utilities.dart';

import 'countdown_page.dart';

class RouteLaunchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LaunchesBloc>(
      create: ((context) => LaunchesBloc(
          missionApi: LaunchDataService(http.Client(),
              endPoint: 'https://api.spacexdata.com/v4/launches'))),
      //todo take the endpoint out into a config or globals file
      child: LaunchList(),
    );
  }
}

class LaunchList extends StatefulWidget {
  @override
  _LaunchListState createState() => _LaunchListState();
}

class _LaunchListState extends State<LaunchList> {
  LaunchesBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<LaunchesBloc>(context);
    bloc..add(ShowLaunchList());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LaunchesBloc, LaunchesState>(
      cubit: bloc,
      listener: (context, LaunchesState state) async {
        if (state is DisplayCountdownState) {
          await Navigator.push(
            context,
            RightToLeftTransition(
                page: BlocProvider.value(
                    value: bloc,
                    child: CountdownPage(state.mission, state.time)),
                settings: RouteSettings(name: 'Countdown')),
          );
          bloc.add(ShowLaunchList());
        }
      },
      child: BlocBuilder<LaunchesBloc, LaunchesState>(
          cubit: bloc,
          builder: (context, LaunchesState state) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                toolbarHeight: 100,
                title: Text(
                  'Upcoming Launches',
                ),
              ),
              body: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                if (state is WaitingForDataState)
                  Center(child: PlatformCircularProgressIndicator()),
                if (state is DisplayLaunchesState)
                  ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.white,
                      height: 12,
                      thickness: 2,
                    ),
                    itemCount: state.missionList.length + 1,
                    itemBuilder: (BuildContext content, int index) {
                      if (index == 0) {
                        return _headingItem();
                      } else {
                        return _launchItem(state.missionList[index - 1]);
                      }
                    },
                  )
              ]),
            );
          }),
    );
  }

  Widget _launchItem(Mission mission) => InkWell(
    onTap: () => bloc.add(ShowLaunchCountdown(mission)),
    child:
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('${mission.missionName}',
            style: TextStyle(color: Colors.white, fontSize: 18)),
      Text('${mission.formattedDate}',
            style: TextStyle(color: Colors.white, fontSize: 18)),
    ]),
        ),
  );

  Widget _headingItem() => Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Mission', style: TextStyle(color: Colors.white, fontSize: 18)),
          Text('Date (UTC)',
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ]),
      );
}
