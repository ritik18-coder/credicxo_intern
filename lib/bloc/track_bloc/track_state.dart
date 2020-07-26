import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:credicxo_intern/data/models/ApiTrackDetails.dart';
abstract class TrackState extends Equatable{}

class TrackInitialState extends TrackState{
  @override
  List<Object> get props=>[];
}

class TrackLoadingState extends TrackState{
  @override
  List<Object> get props=>[];
}

class TrackLoadedState extends TrackState{
  List<TrackList> tracks;
  TrackLoadedState({@required this.tracks});

  @override
  List<Object> get props=>null;
}

class TrackErrorState extends TrackState{
  String error;
  TrackErrorState({@required this.error});
  @override
  List<Object> get props=>null;
}