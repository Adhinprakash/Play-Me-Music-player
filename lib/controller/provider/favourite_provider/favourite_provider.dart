import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Favouriteprovider extends ChangeNotifier {
   bool isinitialized = false;
  static final musicDatabase = Hive.box<int>('FavouriteDB');
  List<SongModel> favouritesong = [];

  initialized(List<SongModel> allsongs)async {
    for (SongModel song in allsongs) {
      if (isfavorate(song)) {
        favouritesong.add(song);
      }
    }
    isinitialized = true;
  }

  isfavorate(SongModel song) {
    if (musicDatabase.values.contains(song.id)) {
      return true;
    }
    return false;
  }

  add(SongModel song) async {
    musicDatabase.add(song.id);
    favouritesong.add(song);
    notifyListeners();
  }

  deletesong(int id) async {
    int delete = 0;
    if (!musicDatabase.values.contains(id)) {
      return;
    }
    final Map<dynamic, int> map = musicDatabase.toMap();
    map.forEach((key, value) {
      if (value == id) {
        delete = key;
      }
    });
    musicDatabase.delete(delete);
    favouritesong.removeWhere((song) => song.id == id);
    notifyListeners();
  }

  clear() {
    favouritesong.clear();
  }
}
