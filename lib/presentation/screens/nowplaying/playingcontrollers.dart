import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:myapp/controller/provider/nowplaying_provider/nowplaying_provider.dart';
import 'package:myapp/page-1/art.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Playcontrollers extends StatelessWidget {
   Playcontrollers({
    super.key, required this.count, required this.songModel, required this.firstsong, required this.lastsong,
  
  });


final int count;
  final SongModel songModel;
  final bool firstsong;
  final bool lastsong;

 bool isplaying = true;
  bool isShuffling = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<Nowplayingprovider>(
      builder: (context, value, _) {
        return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              
                isShuffling == false
                    ? value.onshufflemode()
                    : value.offshufflemode();
          
            },
            icon: StreamBuilder<bool>(
              stream: Getallsongscontroller.audioPlayer.shuffleModeEnabledStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                isShuffling = snapshot.data ?? false;
                if (isShuffling) {
                  return const Icon(
                    Icons.shuffle_on_outlined,
                    color: Color.fromARGB(255, 248, 246, 248),
                    size: 25,
                  );
                } else {
                  return const Icon(
                    Icons.shuffle_rounded,
                    color: Colors.white,
                    size: 25,
                  );
                }
              },
            ),
          ),
          firstsong
              ? IconButton(
                  onPressed: () { 
                    
                      // Getallsongscontroller.currentindexgetallsongs--;
                      // if (Getallsongscontroller.currentindexgetallsongs < 0) {
                      //   Getallsongscontroller.currentindexgetallsongs =
                      //       widget.songModel.size;
                      // }
                  
                  },
                  icon: const Icon(
                    Icons.skip_previous,
                    size: 40,
                    color: Color.fromARGB(255, 40, 244, 234),
                  ))
              : IconButton( 
                  onPressed: () {
                    if (Getallsongscontroller.audioPlayer.hasPrevious) {
                      Getallsongscontroller.audioPlayer.seekToPrevious();
                    }
                  },
                  icon: const Icon(
                    Icons.skip_previous,
                    size: 40,
                    color: Color.fromARGB(255, 40, 244, 234),
                  )),
          Center(
            child: CircleAvatar(
              radius: 35,
              backgroundColor: const Color.fromARGB(255, 40, 244, 234),
              child: Padding(
                padding: const EdgeInsets.only(right: 7, bottom: 5),
                child: Consumer<Nowplayingprovider>(
                  builder: (context, data, _) {
                    return IconButton(
                      onPressed: () { 
                       
                        if (Getallsongscontroller.audioPlayer.playing) {
                          data.songPause();
                        } else {
                          data.songPlay();
                        }
                        data.playpause();
                      },
                      icon: Icon(
                        value.songplaying ? Icons.pause : Icons.play_arrow,
                        size: 40,
                        color: Colors.black,
                      ));
                  },
                  
                ),
              ),
            ),
          ),
          lastsong
              ? const IconButton(  
                  onPressed: null,
                  icon: Icon(
                    Icons.skip_next,
                    size: 40,
                    color: Color.fromARGB(255, 40, 244, 234),
                  ))
              : IconButton(
                  onPressed: () {
                    if (Getallsongscontroller.audioPlayer.hasNext) {
                      Getallsongscontroller.audioPlayer.seekToNext();
                    }
                  },
                  icon: const Icon(Icons.skip_next,
                      size: 40, color: Color.fromARGB(255, 40, 244, 234))),
          IconButton(
              onPressed: () {
              
                  Getallsongscontroller.audioPlayer.loopMode == LoopMode.one
                      ? Getallsongscontroller.audioPlayer
                          .setLoopMode(LoopMode.all)
                      : Getallsongscontroller.audioPlayer
                          .setLoopMode(LoopMode.one);
            
              },
              icon: StreamBuilder<LoopMode>(
                stream: Getallsongscontroller.audioPlayer.loopModeStream,
                builder: (context, snapshot) {
                  final loopmode = snapshot.data;
                  if (LoopMode.one == loopmode) {
                    return const Icon(
                      Icons.repeat_on_outlined,
                      color: Colors.white,
                    );
                  } else {
                    return const Icon(Icons.repeat, color: Colors.white);
                  }
                },
              ))
        ],
      );
      },
      
    );
  }
}



 