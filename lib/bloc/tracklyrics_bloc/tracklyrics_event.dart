import 'package:equatable/equatable.dart';

abstract class TrackLyricsEvent extends Equatable{

}

class FetchTrackLyricsEvent extends TrackLyricsEvent{
  @override
  List<Object> get props=>null;
}
