import 'package:bloc/bloc.dart';
import 'package:credicxo_intern/bloc/tracklyrics_bloc/tracklyrics_event.dart';
import 'package:credicxo_intern/bloc/tracklyrics_bloc/tracklyrics_state.dart';
import 'package:credicxo_intern/data/apiCalling/trackLyrics_api.dart';
import 'package:meta/meta.dart';
import 'package:credicxo_intern/data/models/ApiTrackDetails.dart';
class TrackLyricsBloc extends Bloc<TrackLyricsEvent,TrackLyricsState>{
  // TrackBloc(TrackState initialState) : super(initialState);
  TrackLyricsBloc({@required this.repository});

  TrackLyricsRepository repository;


  @override
  TrackLyricsState get initialState=>TrackLyricsInitialState();

  @override
  Stream<TrackLyricsState> mapEventToState(TrackLyricsEvent event) async*{
    if(event is FetchTrackLyricsEvent){
      yield TrackLyricsLoadingState();
      try{
        String lyrics =await repository.getTracksLyrics();
        yield TrackLyricsLoadedState(lyrics: lyrics);
      }catch(e){
        yield TrackLyricsErrorState(error:e.toString());
      }

    }
  }
}