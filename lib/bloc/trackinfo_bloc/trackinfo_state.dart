import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:credicxo_intern/data/models/ApiTrackInfo.dart';
abstract class TrackInfoState extends Equatable{}

class TrackInfoInitialState extends TrackInfoState{
  @override
  List<Object> get props=>[];
}

class TrackInfoLoadingState extends TrackInfoState{
  @override
  List<Object> get props=>[];
}

class TrackInfoLoadedState extends TrackInfoState{
  List tracks;
  TrackInfoLoadedState({@required this.tracks});

  @override
  List<Object> get props=>null;
}

class TrackInfoErrorState extends TrackInfoState{
  String error;
  TrackInfoErrorState({@required this.error});
  @override
  List<Object> get props=>null;
}