import 'package:flutter/material.dart';
import 'package:myapp/DB/functions/functionsfav.dart';
import 'package:myapp/allmusic/All_music.dart';
import 'package:myapp/allmusic/Allmusictile.dart';
import 'package:myapp/nowplaying/nowartwork.dart';
import 'package:myapp/nowplaying/playingcontrollers.dart';
import 'package:myapp/page-1/art.dart';
import 'package:myapp/page-1/home.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Nowplaying extends StatefulWidget {
  const Nowplaying({super.key, required this.songsModel, this.count = 0});

  final List<SongModel> songsModel;
  final int count;

  @override
  State<Nowplaying> createState() => _NowplayingState();
}

class _NowplayingState extends State<Nowplaying> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  int currentIndex = 0;
  int large = 0;
  bool firstsong = false;
  bool lastsong = false;

  @override
  
  void initState() {
    Getallsongscontroller.audioPlayer.currentIndexStream.listen((ind) {
      if (ind != null) {
        Getallsongscontroller.currentindexgetallsongs = ind;
        if (mounted) {
          setState(() {
            large = widget.count - ind;
            currentIndex = ind;
            ind == 0 ? firstsong = true : firstsong = false;
            ind == large ? lastsong = true : lastsong = false;
          });
        }
      }
    });
    super.initState();
    playsong();
  }
  
  

  playsong() {
    Getallsongscontroller.audioPlayer.play();
    Getallsongscontroller.audioPlayer.durationStream.listen((D) {
      if(mounted){
         setState(() {
        _duration = D!;
      });
      }
     
    });
    Getallsongscontroller.audioPlayer.positionStream.listen((P) {
      if(mounted){
          setState(() {
        _position = P;
      });
      }
    
    });
  }
  


  @override
  Widget build(BuildContext context) {
     final screenHight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
              backgroundColor: const Color.fromARGB(255, 9, 16, 16),

      body: SafeArea(
        child: ListView(
          shrinkWrap: false,
          physics: const NeverScrollableScrollPhysics(),

          children: 
            [SizedBox(
              
              width: screenwidth,
              height: screenHight,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const screenhome()),
                                (route) => false);
                          },
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Color.fromARGB(255, 126, 122, 122))),
                                  PopupMenuButton(                
                                                    color:const Color.fromARGB(255, 126, 214, 214),
                                                    icon: const Icon(
                                                      Icons.more_vert,
                                                      size: 24,
                                                    ),
                                                    itemBuilder: (context) => [
                                                      const PopupMenuItem(
                                                        value: 1,
                                                        child: Text(
                                                          'Add to Playlist',
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              ),
                                                        ),
                                                      ),
                                                       PopupMenuItem(
                                                        value: 2,
                                                        child: Text(
                                                        FavourateDB.isfavorate(widget.songsModel[currentIndex])
                                                            ? 'Remove Favorites'
                                                            : 'Add Favorites',
                                                          style: const TextStyle(
                                                              color:  Colors.white,
                                                             ),
                                                        ),
                                                      )
                                                    ],
                                                    onSelected: (value) {
                                                      if (value == 1) {
                                                 shoplaylistdialog(context, stmodel[currentIndex]);
              
                                                      } else if (value == 2) {
                                                      
                                                     if (FavourateDB.isfavorate(
                                            widget.songsModel[currentIndex])) {
                                          FavourateDB.deletesong(
                                              widget.songsModel[currentIndex].id);
                                          const remove = SnackBar(
                                            backgroundColor:
                                                Color.fromARGB(222, 38, 46, 67),
                                            content: Center(
                                              child: Text(
                                                'Song Removed In Favorate List',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white70),
                                              ),
                                            ),
                                            duration: Duration(seconds: 2),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(remove);
                                        } else {
                                          FavourateDB.add(widget.songsModel[currentIndex]);
                                          const add = SnackBar(  
                                            backgroundColor:
                                                Color.fromARGB(222, 10, 11, 14),
                                            content: Center(
                                                child: Center(
                                              child: Text(
                                                'Song Added In Favorate List',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white70),
                                              ),
                                            )),
                                            duration: Duration(seconds: 2),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(add);
                                        }
                                        FavourateDB.favoratesongs
                                            .notifyListeners();
              
                                        Navigator.pop(context);
              
                                                      }
                                                    },
                                                  )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Playing Now',
                        style: TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 158, 158, 158)),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.play_circle_outline_rounded,
                        color: Color.fromARGB(
                          255,
                          158,
                          158,
                          158,
                        ),
                        size: 23,
                      ),
                    
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child:
                        PlayArtwork(currentIndex: currentIndex, widget: widget),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 36),
                        child: Row(
                          children: [
                            Text(
                              widget.songsModel[currentIndex].displayNameWOExt,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        
                        padding: const EdgeInsets.only(left: 36),
                        child: SizedBox(
                        
                          child: Row(
                            children: [
                              SizedBox(
                                width: 280,
                                child: Text(
                                  widget.songsModel[currentIndex].artist.toString() ==
                                          "unknown"
                                      ? "unknown Artist"
                                      : widget.songsModel[currentIndex].artist
                                          .toString(),
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 173, 169, 169)),
                                ),
                              ),
                                 IconButton(
                        onPressed: () {
                          setState(() {
                            if (FavourateDB.isfavorate(
                                widget.songsModel[currentIndex])) {
                              FavourateDB.deletesong(
                                  widget.songsModel[currentIndex].id);
                              const remove = SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor:
                                    Color.fromARGB(222, 38, 46, 67),
                                content: Center(
                                  child: Text(
                                    'Song Removed In Favourite List',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70),
                                  ),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(remove);
                            } else {
                              FavourateDB.add(
                                  widget.songsModel[currentIndex]);
                              const add = SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor:
                                    Color.fromARGB(222, 38, 46, 67),
                                content: Center(
                                  child: Text(
                                    'Song Added In Favourite List',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70),
                                  ),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(add);
                            }
                            FavourateDB.favoratesongs.notifyListeners();
                          });
                        },
                        icon: Icon(
                            FavourateDB.isfavorate(
                                    widget.songsModel[currentIndex])
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                                size: 28,
                            color: const Color.fromARGB(153, 12, 237, 229)),
                      )
                            ],
                          ),
                        ),
                      ),
                   
                    ],
                  ),
                  Expanded(
                    child: Slider(
                        inactiveColor: const Color.fromARGB(255, 125, 126, 126),
                        activeColor: const Color.fromARGB(255, 40, 244, 234),
                        min: const Duration(microseconds: 0).inSeconds.toDouble(),
                        value: _position.inSeconds.toDouble(),
                        max: _duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            changetoseconds(value.toInt());
                            value = value;
                          });
                        }),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, bottom: 80),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _position.toString().split(".")[0],
                          style: const TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 173, 169, 169)),
                        ),
                        Text(
                          _duration.toString().split(".")[0],
                          style: const TextStyle(
                              fontSize: 11,
                              color: Color.fromARGB(255, 173, 169, 169)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Playcontrollers(
                        count: widget.count,
                        songModel: widget.songsModel[currentIndex],
                        firstsong: firstsong,
                        lastsong: lastsong),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changetoseconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    Getallsongscontroller.audioPlayer.seek(duration);
  }
}
