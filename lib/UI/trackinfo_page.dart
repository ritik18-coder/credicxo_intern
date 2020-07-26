import 'package:credicxo_intern/bloc/trackinfo_bloc/trackinfo_event.dart';
import 'package:credicxo_intern/bloc/trackinfo_bloc/trackinfo_bloc.dart';
import 'package:credicxo_intern/bloc/trackinfo_bloc/trackinfo_state.dart';
import 'package:credicxo_intern/data/apiCalling/trackInfo_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:credicxo_intern/UI/tracklyrics_page.dart';
class TrackInfo extends StatelessWidget {
  TrackInfo({this.trackId});
  final trackId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track Details"),
      ),
      body:BlocProvider(
        builder:(context)=> TrackInfoBloc(repository: TrackInfoRepositoryImp(trackId)),
        child: TrackBlocInfo(),
      ) ,
    );
  }
}
class TrackBlocInfo extends StatefulWidget {
  TrackBlocInfo({this.trackId});
  final trackId;
  @override
  _TrackBlocInfoState createState() => _TrackBlocInfoState();
}

class _TrackBlocInfoState extends State<TrackBlocInfo> {
  TrackInfoBloc trackInfoBloc;
  @override
  void initState() {
    super.initState();
    trackInfoBloc = BlocProvider.of<TrackInfoBloc>(context);
    trackInfoBloc.add(FetchTrackInfoEvent());
  }
  Widget build(BuildContext context) {
    return Container(
      child: BlocListener<TrackInfoBloc, TrackInfoState>(
        listener: (context, state) {
          if (state is TrackInfoErrorState) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: BlocBuilder<TrackInfoBloc, TrackInfoState>(
          builder: (context, state) {
            if (state is TrackInfoInitialState) {
              return buildLoading();
            } else if (state is TrackInfoLoadingState) {
              return buildLoading();
            } else if (state is TrackInfoLoadedState) {
              return buildArticleList(state.tracks);
            } else if (state is TrackInfoErrorState) {
              return buildErrorUi(state.error);
            }
          },
        ),
      ),
    );
  }


  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(List tracks) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: tracks.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(tracks[pos]),
          ),
        );
      },
    );
  }
}
/*

 */