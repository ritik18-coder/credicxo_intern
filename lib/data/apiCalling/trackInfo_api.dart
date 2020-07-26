import 'package:credicxo_intern/data/models/ApiTrackInfo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
abstract class TrackInfoRepository{
  Future<List> getTracksInfo();
}

class TrackInfoRepositoryImp implements TrackInfoRepository{
  TrackInfoRepositoryImp(this.id);
  final id;
  @override
  Future<List> getTracksInfo() async{
    List tracksInfo=[];
    print("receiing https://api.musixmatch.com/ws/1.1/track.get?track_id=$id&apikey=620e1d85f32dacc2cf5476919da1e255");
    var response= await http.get("https://api.musixmatch.com/ws/1.1/track.get?track_id=$id&apikey=620e1d85f32dacc2cf5476919da1e255");
    var data = json.decode(response.body);
    var statusCode =data['message']['header']['status_code'];
    if(statusCode==200){


      tracksInfo.add( Track.fromJson(data['message']['body']['track']).trackName);
      tracksInfo.add( Track.fromJson(data['message']['body']['track']).albumName);
      tracksInfo.add( Track.fromJson(data['message']['body']['track']).artistName);
      tracksInfo.add( Track.fromJson(data['message']['body']['track']).explicit.toString());
      tracksInfo.add( Track.fromJson(data['message']['body']['track']).trackRating.toString());
      print(tracksInfo);
      return tracksInfo;
    }else{
      throw Exception("${statusCode.toString()} error");
    }

  }
}