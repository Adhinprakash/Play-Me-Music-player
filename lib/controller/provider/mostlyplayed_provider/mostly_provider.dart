import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../presentation/screens/allmusic/All_music.dart';

class MostlyProvider extends ChangeNotifier{

  List<SongModel>mostly=[];


  List<SongModel>mostlyplayed=[];



   Future<void>addmostlyplayed(item) async {
    final mostlyDB = await Hive.openBox('mostlyplayeddb');
    mostlyDB.add(item);
    getmostlyplayed();
    notifyListeners();
   
  }



 Future<void>getmostlyplayed()async{
  final mostlyDB = await Hive.openBox('mostlyplayeddb');
   mostlyDB.values.toList();
  displaymostly();
  notifyListeners();

  }


 Future displaymostly()async{
final mostlyDB= await Hive.openBox('mostlyplayeddb');
final mostlyitems=mostlyDB.values.toList();
final mostplay=mostlyDB.values.toSet().toList();
mostlyplayed.clear(); 
mostly.clear();
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
            mostly.add(stmodel[m]);
            mostlyplayed.add(stmodel[m]);
          }
        }
        value=0;

      }
    }
    notifyListeners();
    return  mostlyplayed;
  }


}
 