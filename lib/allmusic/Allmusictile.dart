

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myapp/DB/functions/functionmostlyplayed.dart';
import 'package:myapp/DB/functions/functionsfav.dart';
import 'package:myapp/DB/functions/recently_function.dart';
import 'package:myapp/DB/model/model.dart';
import 'package:myapp/allmusic/All_music.dart';
import 'package:myapp/nowplaying/New_playing.dart';
import 'package:myapp/page-1/art.dart';
import 'package:myapp/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../provider/songsprovider.dart';

// ignore: must_be_immutable
class Allmusictile extends StatefulWidget {
  Allmusictile({super.key, required this.songmodel});
  List<SongModel> songmodel = [];

  @override
  State<Allmusictile> createState() => _AllmusictileState();
}

class _AllmusictileState extends State<Allmusictile> {
  List<SongModel> song = [];
  @override
  Widget build(BuildContext context) {
      final screenHight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemBuilder: (context, index) {
        song.addAll(widget.songmodel);
        return SizedBox(
          height:65 ,
          child: ListTile(
            leading: QueryArtworkWidget(
              artworkBorder: BorderRadius.circular(4),
              id: widget.songmodel[index].id,
              type: ArtworkType.AUDIO,
            
              nullArtworkWidget: const Icon(
                Icons.music_note,
                color: Colors.white,
              ),
            ),
            title: Text(widget.songmodel[index].displayNameWOExt,
                maxLines: 1,  
                style: const TextStyle(fontSize: 14, color: Colors.white)),
            subtitle: Text(
              " ${widget.songmodel[index].artist}",
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),

            trailing:  IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: const Color.fromARGB(179, 7, 29, 31),
                    context: context,
                    builder: (cts) {
                      return SizedBox(
                          height: screenHight*0.3,
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.playlist_add,
                                    color: Color.fromARGB(255, 40, 244, 234)),
                                title: const Text(
                                  'Add playlist',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 40, 244, 234),
                                  ),
                                ),
                                onTap: () {
                                shoplaylistdialog(context, stmodel[index]);
                                },
                              ),
                              //2
                              ValueListenableBuilder(
                                valueListenable: FavourateDB.favoratesongs,
                                builder:
                                    (context, List<SongModel> data, child) {
                                  return ListTile(
                                 
                                    title: Text(
                                      FavourateDB.isfavorate(widget.songmodel[index])
                                          ? 'Remove Favorites'
                                          : 'Add Favorites',
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 40, 244, 234),
                                      ),
                                    ),
                                    onTap: () {
                                      if (FavourateDB.isfavorate(
                                          widget.songmodel[index])) {
                                        FavourateDB.deletesong(
                                            widget.songmodel[index].id);
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
                                        FavourateDB.add(widget.songmodel[index]);
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
                                    },
                                    leading: FavourateDB.isfavorate(
                                            widget.songmodel[index])
                                        ? const Icon(Icons.favorite,
                                            color:
                                                Color.fromARGB(255, 40, 244, 234))
                                        : const Icon(
                                            Icons.favorite_border_outlined,
                                            color: Color.fromARGB(
                                              255, 40, 244, 234)),
                                  );
                                },
                              ),
                              //3
                              ListTile(
                                leading: const Icon(Icons.info_outline,
                                    color: Color.fromARGB(255, 40, 244, 234)),
                                title: const Text(
                                  'Song info',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 40, 244, 234),
                                  ),
                                ),
                                onTap: () {},
                              ),
                              //4
                              ListTile(
                                leading: const Icon(Icons.share,
                                    color: Color.fromARGB(255, 40, 244, 234)),
                                title: const Text(
                                  'Share',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 40, 244, 234),
                                  ),
                                ),
                                onTap: () {},
                              ),
                              //5
                              
                            ],
                          ));
                    },
                  );
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white60,
                )),
            onTap: () {
               FocusScope.of(context).unfocus();
              MostlyplayedDb.addmostlyplayed(widget.songmodel[index].id); 
              Recentfunctions.addrecentlyplayed(widget.songmodel[index].id);
              Getallsongscontroller.audioPlayer.setAudioSource(
                  Getallsongscontroller.createsongslist(widget.songmodel),
                  initialIndex: index);
                  context.read<Songprovider>().setid(widget.songmodel[index].id);

        
              Navigator.push(
                
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => Nowplaying(
                            songsModel: widget.songmodel,
                            count: widget.songmodel.length,
                          )));
            },
          ),
        );
      },
      itemCount: widget.songmodel.length,
    );
  }
}

void showbottomsheet(BuildContext context, SongModel songModel) {
  showModalBottomSheet(
      backgroundColor: Colors.white70,
      context: context,
      builder: (ctx1) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 180,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.playlist_add,
                    color: Color.fromARGB(255, 37, 37, 54),
                  ),
                  title:const Text(
                    'Add Playlist',
                    style: TextStyle(
                      color:  Color.fromARGB(255, 37, 37, 54),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    shoplaylistdialog(context, songModel );
                   
                  },
                ),
                const ListTile(
                  leading: Icon(Icons.info_outline,
                      color: Color.fromARGB(255, 37, 37, 54)),
                  title: Text(
                    'Song Info',
                    style: TextStyle(color: Color.fromARGB(255, 37, 37, 54)),
                  ),
                ),
               const ListTile(
                  leading:
                      Icon(Icons.share, color: Color.fromARGB(255, 37, 37, 54)),
                  title: Text(
                    'Share',
                    style: TextStyle(color: Color.fromARGB(255, 37, 37, 54)),
                  ),
                ),
             
              ],
            ),
          ),
        );
      });
}

shoplaylistdialog(ctx,SongModel songModel,) {
  showDialog(
    context: ctx,
    builder: (context) => AlertDialog(
      backgroundColor: const Color.fromARGB(207, 255, 255, 255),
      title: const Text(
        'Select Your Playlist',
        style: TextStyle(
          color: Color.fromARGB(255, 37, 37, 54),
        ),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height*0.3,
        width:  MediaQuery.of(context).size.height*0.7,
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Playmodel>('playlistdata').listenable(),
          builder: (context, Box<Playmodel> musiclist, child) {
            return Hive.box<Playmodel>('playlistdata').isEmpty
                ? const Center(
                    child: Text(
                    'No Playlist Found',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ))
                : ListView.builder(
                    itemCount: musiclist.length,
                    itemBuilder: (context, index) {
                      final data = musiclist.values.toList()[index];
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[200],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.blue)),
                        child: ListTile(
                          onTap: () {
                            songaddtoplaylist(songModel, data, data.name, ctx);
                            Navigator.pop(context);
                          },
                          title: Text(
                            data.name,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 37, 37, 54),
                                fontWeight: FontWeight.w500),
                          ),
                          trailing:  IconButton(onPressed: (){
                            songaddtoplaylist(songModel, data, data.name, ctx);
                             Navigator.pop(context);
                          }, icon: const Icon(Icons.add))
                        ),
                      );
                    });
          },
        ),
      ),
      actions: [
        Wrap(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  newplaylist(context, formkey);
                  
                },
                child: const Text('New Playlist'))
          ],
        )
      ],
    ),
  );
}

 songaddtoplaylist( SongModel data ,datas,String name,BuildContext context){
  if (!datas.isvalue(data.id)) {
    datas.add(data.id);
    final snake1=SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor:const Color.fromARGB(222, 38, 46, 67),
      content: Center(child: Text('Playlist Add To $name',style:const TextStyle(color: Colors.white60),)));
      ScaffoldMessenger.of(context).showSnackBar(snake1);
    
  }else{
    final snake2=SnackBar(
      duration:const Duration(seconds: 1),
      backgroundColor: Colors.red,
      content: Center(child: Text('Song Alredy Added In $name')));
      ScaffoldMessenger.of(context).showSnackBar(snake2);
  }

}


