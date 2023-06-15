import 'package:flutter/material.dart';
import 'package:myapp/controller/provider/mostlyplayed_provider/mostly_provider.dart';
import 'package:myapp/page-1/art.dart';
import 'package:myapp/presentation/screens/nowplaying/New_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';


// ignore: must_be_immutable
class Mostlyplayedlist extends StatelessWidget {
   Mostlyplayedlist({super.key, });

  OnAudioQuery audioQuery=OnAudioQuery();
  List<SongModel>mostly=[];
 

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<MostlyProvider>(context,listen: false).getmostlyplayed(),
        builder: (context, item) {
          return Consumer<MostlyProvider>(builder:  (context, value, _) {
             if (value.mostlyplayed.isEmpty) {
                return const Center(
                  child: Text(
                    'Your Mostly Played Is Empty',
                    style: TextStyle(fontSize: 20, color: Colors.white60),
                  ),
                );
              } else {
                final temp = value.mostlyplayed.reversed.toList();
                mostly = temp.toSet().toList();
                return FutureBuilder(
                  future: audioQuery.querySongs(
                      sortType: null,
                      orderType: OrderType.ASC_OR_SMALLER,
                      uriType: UriType.EXTERNAL,
                      ignoreCase: true),
                  builder: (context, item) {
                    if (item.data == null) {
                      const Center(child: CircularProgressIndicator());
                    } else if (item.data!.isEmpty) {
                      const Center(
                        child: Text(
                          'No Songs In Your Internal',
                          style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount:  mostly.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: QueryArtworkWidget(
                            id: mostly[index].id,
                            type: ArtworkType.AUDIO,
                            artworkHeight: 60,
                            artworkWidth: 60,
                            nullArtworkWidget: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.music_note,
                                color: Colors.white60,
                              ),
                            ),
                            artworkBorder: BorderRadius.circular(10),
                            artworkFit: BoxFit.cover,
                          ),
                          title: Text(mostly[index].displayNameWOExt,
                              maxLines: 1,
                              style: const TextStyle(color: Colors.white70)),
                          subtitle: Text(
                            '${mostly[index].artist}',
                            style: const TextStyle(color: Colors.white70),
                            maxLines: 1,
                          ),
                          onTap: () {
                             Provider.of<MostlyProvider>(context,listen: false).addmostlyplayed(mostly[index].id);
                            Getallsongscontroller.audioPlayer.setAudioSource(
                                Getallsongscontroller.createsongslist(mostly));
                            Getallsongscontroller.audioPlayer.play();
                            Navigator.push(     
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Nowplaying(
                                      songsModel: Getallsongscontroller.playsong),
                                ));
                          },
                        );
                        
                      },
                      
                    );
                    
                  },
                );
              }
            
        
          },);
        }      
      );
    
  }
}

