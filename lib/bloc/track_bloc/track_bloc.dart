import 'package:bloc/bloc.dart';
import 'package:credicxo_intern/bloc/track_bloc/track_event.dart';
import 'package:credicxo_intern/bloc/track_bloc/track_state.dart';
import 'package:credicxo_intern/data/apiCalling/track_api.dart';
import 'package:meta/meta.dart';
import 'package:credicxo_intern/data/models/ApiTrackDetails.dart';
class TrackBloc extends Bloc<TrackEvent,TrackState>{
 // TrackBloc(TrackState initialState) : super(initialState);
TrackBloc({@required this.repository});

  TrackRepository repository;


  @override
  TrackState get initialState=>TrackInitialState();

  @override
  Stream<TrackState> mapEventToState(TrackEvent event) async*{
    if(event is FetchTrackEvent){
      yield TrackLoadingState();
      try{
        List<TrackList> tracks =await repository.getTracks();
        yield TrackLoadedState(tracks: tracks);
      }catch(e){
        yield TrackErrorState(error:e.toString());
      }

    }
  }
}