import 'package:flutter/material.dart';
import 'package:myapp/allmusic/Allmusictile.dart';
import 'package:myapp/page-1/home.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

List<SongModel> totalsongs = [];
List<SongModel> stillsongs = [];
final OnAudioQuery audioQuery = OnAudioQuery();

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
    getalllsongs();
  }

  @override
  Widget build(BuildContext context) {
        final screenHight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: screenwidth,
          height: screenHight,
          child: DecoratedBox(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('assets/page-1/images/android-large-1.png'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const screenhome()),
                        
                            (route) => false);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color.fromARGB(255, 159, 154, 154),
                      )),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'Search',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),

                const  SizedBox(
                  height: 10,
                ),
                  TextField(
                    onChanged: (value) => update(value),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(255, 37, 64, 65),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Search Your favourite song..',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 182, 180, 189),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 147, 158, 161),
                        )),
                  ),
                  stillsongs.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'No songs',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        )
                      : Expanded(child: Allmusictile(songmodel: stillsongs))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  update(String text) {
    List<SongModel> result = [];
    if (text.isEmpty) {
      result = totalsongs;
    } else {
      result = totalsongs
          .where((element) => element.displayNameWOExt
              .toLowerCase()
              .contains(text.toLowerCase())||element.displayNameWOExt.toLowerCase().endsWith(text.toLowerCase()))
          .toList();
    }
    setState(() {
      stillsongs = result;
    });
  }

  Future<void> getalllsongs() async {
    totalsongs = await audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
        path: '/storage/emulated/0/ALLMUSIC');
  }
}
