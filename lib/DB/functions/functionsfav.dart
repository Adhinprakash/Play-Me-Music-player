


import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';


class FavourateDB {
  static bool isinitialized=false;
 static final musicDatabase=Hive.box<int>('FavouriteDB');
  static  ValueNotifier<List<SongModel>>favoratesongs=ValueNotifier([]);




static initialized(List<SongModel>allsongs){
favoratesongs.value.clear();
  for(SongModel song in allsongs){
    if(isfavorate(song)){
      favoratesongs.value.add(song);
    }
    
  }
  isinitialized=true;
}

  static isfavorate(SongModel song){
    if(musicDatabase.values.contains(song.id)){
      return true;
    }
      return false;
  }

  static add(SongModel song)async{
  musicDatabase.add(song.id);
  favoratesongs.value.add(song);
  FavourateDB.favoratesongs.notifyListeners();
  }

  static deletesong(int id) async{
  int delete=0;
  if(!musicDatabase.values.contains(id)){
    return;
  }
    final Map<dynamic,int>map=musicDatabase.toMap();
    map.forEach((key, value) { 
      if (value==id) {
        delete=key;
      }
    });
    musicDatabase.delete(delete);
    favoratesongs.value.removeWhere((song) => song.id==id);
  }
  static clear(){
    FavourateDB.favoratesongs.value.clear();
  }
  
  
}