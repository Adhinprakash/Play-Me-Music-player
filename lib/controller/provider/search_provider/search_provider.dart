
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Searchprovider extends  ChangeNotifier{

  final OnAudioQuery audioQuery = OnAudioQuery();

  List<SongModel> totalsongs = [];
  List<SongModel> stillsongs = [];

  
  update(String text) {
    List<SongModel> result = [];
    if (text.isEmpty) {
      result = totalsongs;
    } else {
      result = totalsongs
          .where((element) =>
              element.displayNameWOExt
                  .toLowerCase()
                  .contains(text.toLowerCase()) ||
              element.displayNameWOExt
                  .toLowerCase()
                  .endsWith(text.toLowerCase()))
          .toList();
    }
    
      stillsongs = result;
  notifyListeners();
  }

  Future<void> getalllsongs() async {
    totalsongs = await audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
        path: '/storage/emulated/0/ALLMUSIC');
  }
}
 