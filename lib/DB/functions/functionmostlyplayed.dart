


import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myapp/allmusic/All_music.dart';
import 'package:on_audio_query/on_audio_query.dart';

  class MostlyplayedDb{

    static ValueNotifier<List<SongModel>> mostlyplayednotifier=ValueNotifier([]);
    static List<SongModel>mostlyplayed=[];


    static Future<void>addmostlyplayed(item) async {
      final mostlyDB = await Hive.openBox('mostlyplayeddb');
      mostlyDB.add(item);
      getmostlyplayed();
      mostlyplayednotifier.notifyListeners();
    }

    static Future<void>getmostlyplayed()async{
    final mostlyDB = await Hive.openBox('mostlyplayeddb');
    mostlyDB.values.toList();
    displaymostly();
    mostlyplayednotifier.notifyListeners();

    }

  static Future displaymostly()async{
  final mostlyDB= await Hive.openBox('mostlyplayeddb');
  final mostlyitems=mostlyDB.values.toList();
  final mostplay=mostlyDB.values.toSet().toList();
  mostlyplayednotifier.value.clear();
  int value = 0;
      for (var i = 0; i < mostlyitems.length; i++) {
        for (var j = 0; j < mostplay.length; j++) {
          if (mostlyitems[i] == mostplay[j]) {
            value++;
          }
        }
        if (value>5) {
          for (var m = 0; m<stmodel.length ; m++) { 
            if (mostlyitems[i]==stmodel[m].id) {
              mostlyplayednotifier.value.add(stmodel[m]);
              mostlyplayed.add(stmodel[m]);
            }
          }
          value=0;

        }
      }
      return  mostlyplayed;
    }

  }

