import 'package:credicxo_intern/bloc/tracklyrics_bloc/tracklyrics_event.dart';
import 'package:credicxo_intern/bloc/tracklyrics_bloc/tracklyrics_bloc.dart';
import 'package:credicxo_intern/bloc/tracklyrics_bloc/tracklyrics_state.dart';
import 'package:credicxo_intern/data/apiCalling/trackLyrics_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:credicxo_intern/constants.dart';
class TrackLyrics extends StatelessWidget {
  TrackLyrics({this.trackId});
  final trackId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:BlocProvider(
        builder:(context)=> TrackLyricsBloc(repository: TrackLyricsRepositoryImp(trackId)),
        child: TrackBlocInfo(),
      ) ,
    );
  }
}
class TrackBlocInfo extends StatefulWidget {
  @override
  _TrackBlocInfoState createState() => _TrackBlocInfoState();
}

class _TrackBlocInfoState extends State<TrackBlocInfo> {
  TrackLyricsBloc trackLyricsBloc;
  @override
  void initState() {
    super.initState();
    print("Initilaized");
    trackLyricsBloc = BlocProvider.of<TrackLyricsBloc>(context);
    trackLyricsBloc.add(FetchTrackLyricsEvent());
  }
  Widget build(BuildContext context) {
    return Container(
      child: BlocListener<TrackLyricsBloc, TrackLyricsState>(
        listener: (context, state) {
          if (state is TrackLyricsErrorState) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        child: BlocBuilder<TrackLyricsBloc, TrackLyricsState>(
          builder: (context, state) {
            if (state is TrackLyricsInitialState) {
              return buildLoading();
            } else if (state is TrackLyricsLoadingState) {
              return buildLoading();
            } else if (state is TrackLyricsLoadedState) {
              return buildArticleList(state.lyrics);
            } else if (state is TrackLyricsErrorState) {
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
        padding: const EdgeInsets.all(10.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(String lyrics) {
    return Container(
      decoration: dec2,
      margin: EdgeInsets.symmetric(vertical:10,horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Text(lyrics,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
    );
  }
}
