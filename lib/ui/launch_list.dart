import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:spacex/bloc/launches_bloc.dart';
import 'package:spacex/model/dataservice/data_service.dart';

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
        if (state is WaitingForDataState) {}
        if (state is DisplayCountdownState) {
          //Navigate
        }
      },
      child: BlocBuilder<LaunchesBloc, LaunchesState>(
          cubit: bloc,
          builder: (context, LaunchesState state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'mission',
                ),
              ),
              body: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                if (state is WaitingForDataState)
                  Center(child: PlatformCircularProgressIndicator()),
                if (state is DisplayLaunchesState)
                  ListView.builder(
                      itemCount: state.missionList.length,
                      itemBuilder: (BuildContext content, int index) {
                        return Row(children: [
                          Text('${state.missionList[index].missionName}'),
                          Text('${state.missionList[index].missionDateTime}'),
                        ]);
                      })
              ]),
            );
          }),
    );
  }
}
