import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../presentation/screens/allmusic/All_music.dart';

class Recentlyprovider extends ChangeNotifier {
  List<SongModel> recentlyplayed = [];

  List<dynamic> recentlyplayedsong = [];

  Future<void> addrecentlyplayed(item) async {
    final recentdatabase = await Hive.openBox('recenlylistnotifier');
    recentdatabase.add(item);
    getallrecently();
    notifyListeners();
  }

  Future<void> getallrecently() async {
    final recentdatabase = await Hive.openBox('recenlylistnotifier');
    recentlyplayedsong = recentdatabase.values.toList();
    displaydrecent();
    notifyListeners();
  }

  Future<void> displaydrecent() async {
    final recentdatabase = await Hive.openBox('recenlylistnotifier');
    final recentitems = recentdatabase.values.toSet().toList();
    recentlyplayed.clear();
    recentlyplayedsong.clear();
    for (int i = 0; i < recentitems.length; i++) {
      for (int j = 0; j < stmodel.length; j++) {
        if (recentitems[i] == stmodel[j].id) {
          recentlyplayed.add(stmodel[j]);
          recentlyplayedsong.add(stmodel[j]);
        }
      }
    }
    notifyListeners();
  }
}
