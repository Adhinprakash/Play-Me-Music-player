import 'package:flutter/material.dart';
import 'package:myapp/DB/model/model.dart';
import 'package:myapp/controller/provider/playlist_provider/playlist_provider.dart';
import 'package:myapp/page-1/art.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../allmusic/All_music.dart';

class Playlistsongadd extends StatelessWidget {
 const  Playlistsongadd({super.key, required this.playlist});


final Playmodel playlist;  
  @override
  Widget build(BuildContext context) {
      final screenHight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
           width: screenwidth,
            height:screenHight,
       child:    DecoratedBox(decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/page-1/images/android-large-1.png'),
        fit: BoxFit.cover
        )
        
       ),
       child:Column(
       
       children:  [
              Row(
                children:  [
            Padding(
              padding:  const EdgeInsets.only(left: 7),
              child: IconButton(onPressed: (){
                 Navigator.pop(context);
              }, icon: const Icon(Icons.arrow_back_ios,color: Color.fromARGB(255, 139, 136, 136),)),
            ),
         const   Padding(
              padding: EdgeInsets.only(left: 25,top: 35),
              child: Text('Add songs to Your playlist',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: Colors.white),),
            )
         
                ]
              ),
            const  SizedBox(height: 10,),
          Expanded(child: FutureBuilder<List<SongModel>>(
            builder: (context, item) {
              if (stmodel == null) {
                return const CircularProgressIndicator();
              }
              if (stmodel.isEmpty) {
                return const Center(child: Text('No Songs Available'));
              }
              return ListView.builder(
                itemCount: stmodel.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: QueryArtworkWidget(
                      id: stmodel[index].id,
                      type: ArtworkType.AUDIO,
                      artworkHeight: 60,
                      artworkWidth: 60,
                      nullArtworkWidget: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: const Icon(
                            Icons.music_note,
                            color: Colors.white60,
                          )),
                      artworkBorder: BorderRadius.circular(10),
                      artworkFit: BoxFit.cover,
                    ),
                    title: Text(stmodel[index].displayNameWOExt,
                        maxLines: 1,
                        style: const TextStyle(color: Colors.white70)),
                    subtitle: Text(
                      stmodel[index].artist!,
                      style: const TextStyle(color: Colors.white70),
                      maxLines: 1,
                    ),
                    trailing: Consumer<PlaylistProvider>(
                      builder: (context, value, _) {
                        return
                        Wrap(
                        children: [
                          !playlist.isvalue( stmodel [index].id)
                              ? IconButton(
                                  onPressed: () {
                                    Getallsongscontroller.copysong = stmodel;
                                    
                                    value.songaddtoplaylist(stmodel[index],context,playlist);
                                      
                                  
                                  },
                                  icon: const Icon(Icons.add,color: Colors.white60,),
                                )
                              : IconButton(
                                  onPressed: () {
                                    
                                      
                                      playlist.  deletedata(stmodel[index].id);
                                  
                                  
                                    const removesongplaylistsnake = SnackBar(
                                        backgroundColor:
                                            Color.fromARGB(222, 38, 46, 67),
                                        duration: Duration(seconds: 1),
                                        content: Center(
                                            child: Text(
                                                'Music Removed In Playlist')));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(removesongplaylistsnake);
                                  },
                                  icon: const Icon(Icons.remove,color: Colors.white60))
                        ],
                      );
                      },
                      
                    ),
                  );
                },
              );
            }
          )  )
       ],
       
    
       ) ,
       ),
        ),
      ),
    );
  }
}