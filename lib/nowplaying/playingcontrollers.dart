import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:myapp/page-1/art.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Playcontrollers extends StatefulWidget {
  const Playcontrollers({
    super.key,
    required this.count,
    required this.songModel,
    required this.firstsong,
    required this.lastsong,
  });
  final int count;
  final SongModel songModel;
  final bool firstsong;
  final bool lastsong;

  @override
  State<Playcontrollers> createState() => _PlaycontrollersState();
}

class _PlaycontrollersState extends State<Playcontrollers> {
  bool isplaying = true;
  bool isShuffling = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              isShuffling == false
                  ? Getallsongscontroller.audioPlayer
                      .setShuffleModeEnabled(true)
                  : Getallsongscontroller.audioPlayer
                      .setShuffleModeEnabled(false);
            });
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
        widget.firstsong
            ? IconButton(
                onPressed: () {
                  setState(() {
                    Getallsongscontroller.currentindexgetallsongs--;
                    if (Getallsongscontroller.currentindexgetallsongs < 0) {
                      Getallsongscontroller.currentindexgetallsongs =
                          widget.songModel.size;
                    }
                  });
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
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      isplaying = !isplaying;
                    });
                    if (Getallsongscontroller.audioPlayer.playing) {
                      Getallsongscontroller.audioPlayer.pause();
                    } else {
                      Getallsongscontroller.audioPlayer.play();
                    }
                  },
                  icon: Icon(
                    isplaying ? Icons.pause : Icons.play_arrow,
                    size: 40,
                    color: Colors.black,
                  )),
            ),
          ),
        ),
        widget.lastsong
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
               setState(() {
                   Getallsongscontroller.audioPlayer.loopMode ==
                                      LoopMode.one
                                  ? Getallsongscontroller.audioPlayer
                                      .setLoopMode(LoopMode.all)
                                  : Getallsongscontroller.audioPlayer
                                      .setLoopMode(LoopMode.one);
                             
                              
               });
           
            },
            
            icon: StreamBuilder<LoopMode>(
              stream: Getallsongscontroller.audioPlayer.loopModeStream,
              builder: (context,snapshot){
              final loopmode=snapshot.data;
              if(LoopMode.one==loopmode){
                return const Icon(
                  Icons.repeat_on_outlined,
                  color: Colors.white,
                );
              }else{
                return const Icon(Icons.repeat,color: Colors.white);
              }
              },
            )
            
            )
      ],
    );
  }
}
