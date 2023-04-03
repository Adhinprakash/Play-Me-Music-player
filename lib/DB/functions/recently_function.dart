
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/allmusic/All_music.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Recentfunctions {
  static ValueNotifier<List<SongModel>> recenlylistnotifier = ValueNotifier([]);
  static List<dynamic> recentlyplayedsong = [];

  static Future<void> addrecentlyplayed(item) async {
    final recentdatabase = await Hive.openBox('recenlylistnotifier');
    recentdatabase.add(item);
    getallrecently();
    recenlylistnotifier.notifyListeners();
  }

  static Future<void> getallrecently() async {
    final recentdatabase = await Hive.openBox('recenlylistnotifier');
    final recentlyplayedsong = recentdatabase.values.toList();
    displaydrecent();
    recenlylistnotifier.notifyListeners();

  }

  static Future<void> displaydrecent() async {
    final recentdatabase = await Hive.openBox('recenlylistnotifier');
    final recentitems = recentdatabase.values.toList();
    recenlylistnotifier.value.clear();
    recentlyplayedsong.clear();
    for (int i = 0; i < recentitems.length; i++) {
      for (int j = 0; j < stmodel.length; j++) {
        if (recentitems[i] == stmodel[j].id) {
          recenlylistnotifier.value.add(stmodel[j]);
          recentlyplayedsong.add(stmodel[j]);
        }
      }
    }
  }
}
