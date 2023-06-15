import 'package:flutter/material.dart';
import 'package:myapp/page-1/art.dart';

class Nowplayingprovider extends ChangeNotifier {
  bool songplaying = true;



  bool isplaying() {
    notifyListeners();
    return songplaying;
  }
 void playpause() {
    songplaying = !songplaying;
  }



 void onshufflemode() {
    Getallsongscontroller.audioPlayer.setShuffleModeEnabled(true);
  }

  void offshufflemode() {
    Getallsongscontroller.audioPlayer.setShuffleModeEnabled(false);
  }

 void songPause() {
    Getallsongscontroller.audioPlayer.pause();
  }

  void songPlay() {
    Getallsongscontroller.audioPlayer.play();
  }

  void changetoseconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    Getallsongscontroller.audioPlayer.seek(duration);
  }

}