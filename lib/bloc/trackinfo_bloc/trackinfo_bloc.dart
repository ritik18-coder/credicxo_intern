import 'package:bloc/bloc.dart';
import 'package:credicxo_intern/bloc/trackinfo_bloc/trackinfo_event.dart';
import 'package:credicxo_intern/bloc/trackinfo_bloc/trackinfo_state.dart';
import 'package:credicxo_intern/data/apiCalling/trackInfo_api.dart';
import 'package:meta/meta.dart';
import 'package:credicxo_intern/data/models/ApiTrackDetails.dart';
class TrackInfoBloc extends Bloc<TrackInfoEvent,TrackInfoState>{
  // TrackBloc(TrackState initialState) : super(initialState);
  TrackInfoBloc({@required this.repository});

  TrackInfoRepository repository;


  @override
  TrackInfoState get initialState=>TrackInfoInitialState();

  @override
  Stream<TrackInfoState> mapEventToState(TrackInfoEvent event) async*{
    if(event is FetchTrackInfoEvent){
      yield TrackInfoLoadingState();
      try{
        List tracksinfo =await repository.getTracksInfo();
        yield TrackInfoLoadedState(tracks: tracksinfo);
      }catch(e){
        yield TrackInfoErrorState(error:"Server Not reachable");
      }

    }
  }
}