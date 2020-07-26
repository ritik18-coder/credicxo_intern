import 'package:credicxo_intern/data/models/ApiTrackDetails.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
abstract class TrackRepository{
  Future<List<TrackList>> getTracks();
}

class TrackRepositoryImp implements TrackRepository{
  @override
  Future<List<TrackList>> getTracks() async{
    print("getting tracks");
    var response= await http.get("https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=620e1d85f32dacc2cf5476919da1e255");
    var data = json.decode(response.body);
    var statusCode =data['message']['header']['status_code'];
    if(statusCode==200){
      List<TrackList> tracks= Body.fromJson(data['message']['body']).trackList;
      print(tracks);
      return tracks;
    }else{
      throw Exception("${statusCode.toString()} error");
    }
  }
}