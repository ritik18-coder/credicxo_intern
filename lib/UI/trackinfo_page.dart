import 'file:///C:/Users/aditya/AndroidStudioProjects/credicxo_intern/lib/constants.dart';
import 'package:credicxo_intern/bloc/trackinfo_bloc/trackinfo_event.dart';
import 'package:credicxo_intern/bloc/trackinfo_bloc/trackinfo_bloc.dart';
import 'package:credicxo_intern/bloc/trackinfo_bloc/trackinfo_state.dart';
import 'package:credicxo_intern/data/apiCalling/trackInfo_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:credicxo_intern/UI/tracklyrics_page.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:io';
import 'file:///C:/Users/aditya/AndroidStudioProjects/credicxo_intern/lib/checkConnection.dart';
class TrackInfo extends StatelessWidget {
  TrackInfo({this.trackId});
  final trackId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[900],
        title: Text("Track Details"),
      ),
      body:BlocProvider(
        builder:(context)=> TrackInfoBloc(repository: TrackInfoRepositoryImp(trackId)),
        child: TrackBlocInfo(trackId: trackId,),
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
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  @override
  void initState() {
    super.initState();
    trackInfoBloc = BlocProvider.of<TrackInfoBloc>(context);
    trackInfoBloc.add(FetchTrackInfoEvent());
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }
  Widget build(BuildContext context) {
    String string;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        string = "Offline";
        print(string);
        break;
      case ConnectivityResult.mobile:
        string = "Mobile: Online";
        print(string);
        break;
      case ConnectivityResult.wifi:
        print(string);
        string = "WiFi: Online";
    }

    return string=="Offline"?Container(
      child: Center(
        child: Text("No Internet"),
      ),
    ):Container(
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
    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          decoration: dec,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ReUsable(title: "TRACK NAME",value: tracks[0],),
              ReUsable(title: "ALBUM NAME",value: tracks[1],),
              ReUsable(title: "ARTIST NAME",value: tracks[2],),
              ReUsable(title: "EXPLICIT",value: tracks[3]==0?'False':'True',),
              ReUsable(title: "RATING",value: tracks[4],),

            ],
          ),
        ),
        Container(
          decoration: dec,
          margin: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Center(child: Text("LYRICS",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900,fontSize: 18,decoration: TextDecoration.underline),),),
        ),
        ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 1200),
            child: Container(child: TrackLyrics(trackId: widget.trackId,))),
      ],
    );
  }
}
/*

 */

class ReUsable extends StatelessWidget {
  ReUsable({this.title,this.value});
  final title;
  final value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
        margin:EdgeInsets.all(10),
        child: Text('$title - $value',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),));
  }
}
