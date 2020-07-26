import 'package:credicxo_intern/data/models/ApiTrackLyrics.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
abstract class TrackLyricsRepository{
  Future<String> getTracksLyrics();
}

class TrackLyricsRepositoryImp implements TrackLyricsRepository{
  TrackLyricsRepositoryImp(this.id);
  final id;
  @override
  Future<String> getTracksLyrics() async{
    print("lyrics is called");
    print("ccc https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$id&apikey=620e1d85f32dacc2cf5476919da1e255");
    var response= await http.get("https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$id&apikey=620e1d85f32dacc2cf5476919da1e255");
    var data = json.decode(response.body);
    var statusCode =data['message']['header']['status_code'];
    if(statusCode==200){
      var data = json.decode(response.body);
      print(data['message']['header']);
      String lyrics= Lyrics.fromJson(data['message']['body']['lyrics']).lyricsBody;
      print(lyrics);
      return lyrics;
    }else{
      throw Exception("${statusCode.toString()} error");
    }
  }
}