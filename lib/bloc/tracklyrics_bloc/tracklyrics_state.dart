import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:credicxo_intern/data/models/ApiTrackLyrics.dart';
abstract class TrackLyricsState extends Equatable{}

class TrackLyricsInitialState extends TrackLyricsState{
  @override
  List<Object> get props=>[];
}

class TrackLyricsLoadingState extends TrackLyricsState{
  @override
  List<Object> get props=>[];
}

class TrackLyricsLoadedState extends TrackLyricsState{
  String lyrics;
  TrackLyricsLoadedState({@required this.lyrics});

  @override
  List<Object> get props=>null;
}

class TrackLyricsErrorState extends TrackLyricsState{
  String error;
  TrackLyricsErrorState({@required this.error});
  @override
  List<Object> get props=>null;
}