import 'package:credicxo_intern/data/models/ApiTrackDetails.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ApiKey.dart';
abstract class TrackRepository{
  Future<List<TrackList>> getTracks();
}

class TrackRepositoryImp implements TrackRepository{
  @override
  Future<List<TrackList>> getTracks() async{
    var response= await http.get("https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=$key");
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