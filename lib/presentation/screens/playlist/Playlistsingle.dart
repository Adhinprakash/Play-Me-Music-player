import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:myapp/DB/model/model.dart';
import 'package:myapp/page-1/art.dart';
import 'package:myapp/controller/provider/songsprovider.dart';
import 'package:myapp/presentation/screens/nowplaying/New_playing.dart';
import 'package:myapp/presentation/screens/playlist/Playlistaddsongs.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class Playlistsingle extends StatelessWidget {
  const Playlistsingle(
      {super.key, required this.pindex, required this.playlist});

  final int pindex;
  final Playmodel playlist;

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    late List<SongModel> songplaylist;
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: screenwidth,
        height: screenHight,
        child: DecoratedBox(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      AssetImage('assets/page-1/images/android-large-1.png'))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromARGB(255, 180, 179, 179),
                  )),
              Center(
                child: Text(
                  playlist.name,
                  style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: double.infinity,
                      child: ValueListenableBuilder(
                          valueListenable:
                              Hive.box<Playmodel>('playlistdata').listenable(),
                          builder:
                              (BuildContext context, music, Widget? child) {
                            songplaylist = listplaylist(
                                music.values.toList()[pindex].songId);
                            return songplaylist.isEmpty
                                ? const Center(
                                    child: Text(
                                      'Add Songs to To your play list',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : ListView.builder(
                                    itemBuilder: ((context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6, right: 6),
                                        child: Card(
                                          color: const Color.fromARGB(
                                              255, 25, 85, 85),
                                          shadowColor: const Color.fromARGB(
                                              255, 163, 107, 173),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 165, 155, 175))),
                                          child: ListTile(
                                            iconColor: Colors.white,
                                            selectedColor: Colors.purpleAccent,
                                            leading: QueryArtworkWidget(
                                              id: songplaylist[index].id,
                                              type: ArtworkType.AUDIO,
                                              nullArtworkWidget: const Icon(
                                                Icons.music_note,
                                                color: Colors.white,
                                              ),
                                            ),
                                            title: Text(
                                              songplaylist[index].title,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.white),
                                            ),
                                            subtitle: Text(
                                              songplaylist[index].artist!,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.blueGrey),
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {
                                              
                                                playlist.deletedata(
                                                      songplaylist[index].id);
                                          

                                                const removesongplaylistsnake =
                                                    SnackBar(
                                                        backgroundColor:
                                                            Color.fromARGB(222,
                                                                38, 46, 67),
                                                        duration: Duration(
                                                            seconds: 1),
                                                        content: Center(
                                                            child: Text(
                                                                'Music Deleted From Playlist')));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        removesongplaylistsnake);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {
                                              Getallsongscontroller.audioPlayer
                                                  .setAudioSource(
                                                      Getallsongscontroller
                                                          .createsongslist(
                                                              songplaylist),
                                                      initialIndex: index);
                                              context
                                                  .read<Songprovider>()
                                                  .setid(
                                                      songplaylist[index].id);

                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          Nowplaying(
                                                            songsModel:
                                                                songplaylist,
                                                            count: songplaylist
                                                                .length,
                                                          )));
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                                    itemCount: songplaylist.length,
                                  );
                          })),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Playlistsongadd(
                          playlist:playlist,
                        )));
          },
          label: const Text('Add Songs')),
    ));
  }

  List<SongModel> listplaylist(List<int> datas) {
    List<SongModel> data = [];
    for (int i = 0; i < Getallsongscontroller.playsong.length; i++) {
      for (int j = 0; j < datas.length; j++) {
        if (Getallsongscontroller.playsong[i].id == datas[j]) {
          data.add(Getallsongscontroller.playsong[i]);
        }
      }
    }

    return data;
  }
}
