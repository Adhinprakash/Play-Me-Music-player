import 'package:flutter/material.dart';
import 'package:myapp/nowplaying/New_playing.dart';
import 'package:myapp/page-1/art.dart';
import 'package:text_scroll/text_scroll.dart';

class Miniplayers extends StatefulWidget {
  const Miniplayers({super.key});

  @override
  State<Miniplayers> createState() => _MiniplayersState();
}

bool firstsong = false;
bool isplaying = true;
   bool isPlaying=false;
class _MiniplayersState extends State<Miniplayers> {
  int currentIndex=0;
  @override
  void initState() {
    Getallsongscontroller.audioPlayer.currentIndexStream.listen((index) {
     
      if (index == null && mounted) {
        setState(() {
          index == 0 ? firstsong = true : firstsong = false;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        final screenHight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Nowplaying(
              songsModel: Getallsongscontroller.playsong,
            );
          },
        ));
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: screenHight*0.06,
          width: screenwidth*0.9,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 7, 86, 95),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                // const  CircleAvatar(
                //   child: 
                // ),

                  SizedBox(

                    width: 150,
                    child: StreamBuilder<bool>(
                        stream:
                            Getallsongscontroller.audioPlayer.playingStream,
                        builder: (context, snapshot) {
                          bool? playingstage = snapshot.data;
                          if (playingstage != null && playingstage) {
                            return TextScroll(
                              Getallsongscontroller
                                  .playsong[Getallsongscontroller
                                      .audioPlayer.currentIndex!]
                                  .displayNameWOExt,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white60),
                            );
                          } else {
                            return Text(
                              Getallsongscontroller
                                  .playsong[Getallsongscontroller
                                      .audioPlayer.currentIndex!]
                                  .displayNameWOExt,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.white60),
                            );
                          }
                        }),
                  ),
                  firstsong
                      ? IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_previous,
                            color: Colors.white54,
                          ))
                      : IconButton(
                          onPressed: () {
                            
                            if (Getallsongscontroller
                                .audioPlayer.hasPrevious) {
                                  setState(() {
                                    Getallsongscontroller.audioPlayer
                                  .seekToPrevious();
                                  
                                  });
                            
                            }
                          },
                          icon: const Icon(
                            Icons.skip_previous,
                            color: Colors.white54,
                          )),
               ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: const CircleBorder()),
                        onPressed: () async {
                          setState(() {
                          });
                          if (Getallsongscontroller.audioPlayer.playing) {
                            await Getallsongscontroller.audioPlayer.pause();
                            setState(() {});
                          } else {
                            await Getallsongscontroller.audioPlayer.play();
                            setState(() {});
                          }
                        },
                        child: StreamBuilder<bool>(
                          stream: Getallsongscontroller.audioPlayer.playingStream,
                          builder: (context, snapshot) {
                            bool? playingStage = snapshot.data;
                            if (playingStage != null && playingStage) {
                              return const Icon(
                                Icons.pause_circle,
                                color: Color.fromARGB(255, 219, 219, 219),
                                size: 35,
                              );
                            } else {
                              return const Icon(
                                Icons.play_circle,
                                color: Color.fromARGB(255, 219, 219, 219),
                                size: 35,
                              );
                            }
                          },
                        ),
                      ),
                  IconButton(
                      onPressed: () {
                        if (Getallsongscontroller.audioPlayer.hasNext) {
                          setState(() {
                             Getallsongscontroller.audioPlayer.seekToNext();
                          });
                         
                        }
                      },
                      icon: const Icon(Icons.skip_next,
                          color: Colors.white54))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
