import 'package:flutter/material.dart';
import 'package:myapp/nowplaying/New_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayArtwork extends StatelessWidget {
  const PlayArtwork({
  super.key,required this.currentIndex,required this.widget});
final int currentIndex;
final Nowplaying widget;

  @override
  Widget build(BuildContext context) {
 
    return  QueryArtworkWidget(
          keepOldArtwork: true,
          artworkHeight: MediaQuery.of(context).size.height*0.35,
          artworkWidth:  MediaQuery.of(context).size.width*0.7,
          artworkBorder: BorderRadius.circular(25),
          id: widget.songsModel[currentIndex].id,
          type: ArtworkType.AUDIO,
          artworkFit: BoxFit.cover,
          nullArtworkWidget: Image.asset(
            'assets/page-1/images/th (1).png',
            height: MediaQuery.of(context).size.height*0.35,
            width: MediaQuery.of(context).size.width*0.7,
          )); 
  }
}