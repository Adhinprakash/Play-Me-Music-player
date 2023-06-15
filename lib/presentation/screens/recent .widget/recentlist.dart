import 'package:flutter/material.dart';
import 'package:myapp/controller/provider/recently_provider/recently_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Recentlyplayedlist extends StatelessWidget {
   Recentlyplayedlist({super.key});

final OnAudioQuery audioQuery=OnAudioQuery();
   List<SongModel> recent = [];


  @override
  Widget build(BuildContext context) {
WidgetsBinding.instance.addPostFrameCallback((_) {
  Provider.of<Recentlyprovider>(context,listen: false).getallrecently();
},);
    return  FutureBuilder( 
      future: Provider.of<Recentlyprovider>(context,listen: false).getallrecently(),
      builder: (context, item) {
        return  Consumer<Recentlyprovider>(builder: (context, data, _) {
            if (data.recentlyplayed.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 150.0),
                  child: Text(
                    "Your Recent Is Empty",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white60),
                  ),
                ),
              );
            } else {
              final temp = data.recentlyplayed.reversed.toList();
              recent = data.recentlyplayed.reversed.toSet().toList();
              return FutureBuilder(
                future: audioQuery.querySongs(
                    sortType: null,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                    ignoreCase: true),
                builder: (context, items) {
                    if (items.data==null) {
                      const CircularProgressIndicator();
                    }
                 else if (items.data!.isEmpty) {
                    return const Center(
                      child: Text('No songs in your internal'),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: recent.length>10?10:recent.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: QueryArtworkWidget(
                        id: recent[index].id,
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
                      title: Text(recent[index].displayNameWOExt,
                          maxLines: 1,
                          style: const TextStyle(color: Colors.white70)),
                      subtitle: Text(
                        '${recent[index].artist}',
                        style: const TextStyle(color: Colors.white70),
                        maxLines: 1,
                      ),
                    ),
                  );
                },
              );
            } 
        },); 
           
         
      },
    );
  }
}




