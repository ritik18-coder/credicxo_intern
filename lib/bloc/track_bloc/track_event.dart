import 'package:equatable/equatable.dart';

abstract class TrackEvent extends Equatable{

}

class FetchTrackEvent extends TrackEvent{
  @override
  List<Object> get props=>null;
}
