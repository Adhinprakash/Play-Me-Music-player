import 'package:flutter/material.dart';
import 'package:myapp/DB/functions/functionsfav.dart';
import 'package:myapp/allmusic/Allmusictile.dart';
import 'package:myapp/page-1/home.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Favourate extends StatefulWidget {
  const Favourate({super.key});

  @override
  State<Favourate> createState() => _FavourateState();
}

class _FavourateState extends State<Favourate> {


  @override
  void initState() {
     
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
        final screenHight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
      valueListenable: FavourateDB.favoratesongs,
      builder: (context, List<SongModel> favdata, child) {
        return SafeArea(
          child: Scaffold(
            body: SizedBox(
              width: screenwidth,
              height: screenHight,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/page-1/images/android-large-1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const screenhome() ), (route) => false);

                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Color.fromARGB(255, 138, 126, 126),
                          )),
                   const   Padding(
                        padding: EdgeInsets.only(left: 20, top: 40),
                        child: Text(
                          'Favourites',
                          style: TextStyle(
                              fontSize: 27,
                              color: Color.fromARGB(255, 158, 158, 158)),
                        ),
                      ),
                      Expanded(
                        child: ValueListenableBuilder(
                          valueListenable: FavourateDB.favoratesongs,
                          builder: (context, List<SongModel> favoritedata, Widget? child) {
                            if (favoritedata.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No Favourates Found',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            } else {
                              final tempdata = favoritedata.reversed.toList();
                              favoritedata = tempdata.toList();
                            return Allmusictile(songmodel: favoritedata);
                            
                            }
                          },
                        ),
                      )
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
