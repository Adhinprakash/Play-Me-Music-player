
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapp/DB/model/model.dart';
import 'package:on_audio_query/on_audio_query.dart';

List<int>? songid;


class PlaylistProvider extends ChangeNotifier {
  PlaylistProvider(){
    getallplaylist();
  }
  List<Playmodel>playlist=[];
   final playlistdata = Hive.box<Playmodel>('playlistdata');

   Future<void> addplaylist(Playmodel value) async {
    final playlistdata = Hive.box<Playmodel>('playlistdata');
    await playlistdata.add(value);
getallplaylist();  
      notifyListeners();
  }

   Future<void> getallplaylist() async {
    final playlistdata = Hive.box<Playmodel>('playlistdata');
    playlist.clear();
    playlist.addAll(playlistdata.values.toList());
    notifyListeners();
   
  }

  Future<void> playlistdelete(int index) async {    
    final playlistdata = Hive.box<Playmodel>('playlistdata');
    playlistdata.deleteAt(index);
    getallplaylist();
    notifyListeners();
  }

   Future<void> editplaylist(Playmodel value, int index) async {
    final playlistdata = Hive.box<Playmodel>('playlistdata');
    await  playlistdata.putAt(index, value);
    getallplaylist();
    notifyListeners();
  }

   songaddtoplaylist(SongModel data,ctx,Playmodel  playlist){
  playlist.add(data.id);
    const addsongplaylistsnake = SnackBar(
        backgroundColor: Color.fromARGB(222, 38, 46, 67),
        duration: Duration(seconds: 1),
        content: Center(child: Text('Music Added In Playlist')));
    ScaffoldMessenger.of(ctx).showSnackBar(addsongplaylistsnake);

    notifyListeners();
  }
}