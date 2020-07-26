import 'package:equatable/equatable.dart';

abstract class TrackInfoEvent extends Equatable{

}

class FetchTrackInfoEvent extends TrackInfoEvent{
  @override
  List<Object> get props=>null;
}
