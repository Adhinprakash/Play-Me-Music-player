import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapp/DB/model/model.dart';




class PlaylistDB {
  static ValueNotifier<List<Playmodel>> playlistnotifier = ValueNotifier([]);
  static final playlistdata = Hive.box<Playmodel>('playlistdata');

  static Future<void> addplaylist(Playmodel value) async {
    final playlistdata = Hive.box<Playmodel>('playlistdata');
    await playlistdata.add(value);
    playlistnotifier.value.add(value);
  }

  static Future<void> getallplaylist() async {
    final playlistdata = Hive.box<Playmodel>('playlistdata');
    playlistnotifier.value.clear();
    playlistnotifier.value.addAll(playlistdata.values);
    
   
  }

  static Future<void> playlistdelete(int index) async {    
    final playlistdata = Hive.box<Playmodel>('playlistdata');
    playlistdata.deleteAt(index);
    getallplaylist();
  }

  static Future<void> editplaylist(Playmodel value, int index) async {
    final playlistdata = Hive.box<Playmodel>('playlistdata');
    await  playlistdata.putAt(index, value);
    getallplaylist();
  }
}