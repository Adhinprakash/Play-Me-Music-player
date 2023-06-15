import 'package:flutter/material.dart';
import 'package:myapp/controller/provider/allmusic_provider/allmusic_provider.dart';
import 'package:myapp/controller/provider/favourite_provider/favourite_provider.dart';
import 'package:myapp/page-1/art.dart';
import 'package:myapp/presentation/screens/allmusic/Allmusictile.dart';
import 'package:myapp/presentation/screens/recent%20.widget/recent_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../settings/settings_screen.dart';

List<SongModel> stmodel = [];

// ignore: must_be_immutable
class Allmusic extends StatelessWidget {
  Allmusic({super.key});
  final AudioPlayer audioPlayer = AudioPlayer();
  OnAudioQuery audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Allmusicprovider>(context, listen: false).requestpermission();
    });
    final screenHight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/page-1/images/android-large-1.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/page-1/images/logomain.png",
                          width: 50,
                          height: 50,
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Settingsscreen(),
                                ));
                          },
                          icon: const Icon(Icons.settings),
                          color: Colors.white,
                          iconSize: 30,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'All musics',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 21),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Recentwidget()));
                                },
                                icon: const Icon(
                                  Icons.history,
                                  color: Colors.white,
                                  size: 30,
                                )))
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<SongModel>>(
                        future: audioQuery.querySongs(
                          sortType: null,
                          orderType: OrderType.ASC_OR_SMALLER,
                          uriType: UriType.EXTERNAL,
                          ignoreCase: true,
                        ),
                        builder: (context, items) {
                          if (items.data == null) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (items.data!.isEmpty) {
                            return const Text('no songs found',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20));
                          }
                          if (audioPlayer.audioSource == null) {
                            audioPlayer.setAudioSource(
                                Getallsongscontroller.createsongslist(
                                    items.data!));
                          }
                          List<SongModel> song = items.data!;
                          stmodel.clear();
                          for (var element in song) {
                            if (element.fileExtension.contains("mp3") &&
                                !element.data.contains("/WhatsApp Audio") &&
                                !element.displayName.contains("AUD")) {
                              stmodel.add(element);
                            }
                          }
                          //  listview bulider//
                          if(Provider.of<Favouriteprovider>(context,listen: false).isinitialized){
                      Provider.of<Favouriteprovider>(context, listen: false)
                              .initialized(stmodel);
                          }
                          return Allmusictile(songmodel: stmodel);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
