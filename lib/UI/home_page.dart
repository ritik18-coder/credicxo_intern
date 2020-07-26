import 'package:credicxo_intern/bloc/track_bloc/track_bloc.dart';
import 'package:credicxo_intern/bloc/track_bloc/track_event.dart';
import 'package:credicxo_intern/bloc/track_bloc/track_state.dart';
import 'package:credicxo_intern/data/models/ApiTrackDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:credicxo_intern/UI/trackinfo_page.dart';
import 'package:credicxo_intern/UI/checkConnection.dart';
import 'package:connectivity/connectivity.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TrackBloc trackBloc;
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  @override
  void initState() {
    super.initState();
    trackBloc = BlocProvider.of<TrackBloc>(context);
    trackBloc.add(FetchTrackEvent());
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
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
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Trending"),

              ),
              body: string=="Offline"?Container(
                child: Center(
                  child: Text("No Internet"),
                ),
              ):Container(
                child: BlocListener<TrackBloc, TrackState>(
                  listener: (context, state) {
                    if (state is TrackErrorState) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<TrackBloc, TrackState>(
                    builder: (context, state) {
                      if (state is TrackInitialState) {
                        return buildLoading();
                      } else if (state is TrackLoadingState) {
                        return buildLoading();
                      } else if (state is TrackLoadedState) {
                        return buildArticleList(state.tracks);
                      } else if (state is TrackErrorState) {
                        return buildErrorUi(state.error);
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
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

  Widget buildArticleList(List<TrackList> tracks) {
    return ListView.builder(
      itemCount: tracks.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(tracks[pos].track.trackName),
            subtitle: Text(tracks[pos].track.albumName),
           // trailing: Icon(Icons.bookmark_border),
          ),
        );
      },
    );
  }

}
