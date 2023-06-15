import 'package:flutter/material.dart';
import 'package:myapp/library/library.dart';
import 'package:myapp/page-1/art.dart';
import 'package:myapp/presentation/screens/allmusic/All_music.dart';
import 'package:myapp/presentation/screens/miniplayer/miniplayer.dart';
import 'package:myapp/presentation/screens/search/search.dart';

import '../presentation/screens/favourates/favourate.dart';


// ignore: camel_case_types
class screenhome extends StatefulWidget {
  const screenhome({super.key});

  @override
  State<screenhome> createState() => _screenhomeState();
}

// ignore: camel_case_types
class _screenhomeState extends State<screenhome> {
  int _currentselectedindex=0;
    List  pages =  [ Allmusic(), SearchWidget() ,const  Favourate(), const Libraryscreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body:Stack(
      children: [
        
         pages[_currentselectedindex],
         Positioned(
        bottom:0,
        right: 20,
          child: Column(
          children: [
            Getallsongscontroller.audioPlayer.currentIndex!=null
            ?const Miniplayers()
            :Container()
            

          ],
         ))
      ],
      ),
      
      
      bottomNavigationBar:BottomNavigationBar(
                 currentIndex:_currentselectedindex,
                 onTap: (newindex){
                  setState(() {
                    _currentselectedindex=newindex; 
                  });
                 
                 },
                    elevation: 0, // to get rid of the shadow
                    // currentIndex: NavigationBar._selectedIndex,
                    selectedItemColor: const Color.fromARGB(255, 253, 250, 250),
                    // onTap: _onItemTapped,
                    backgroundColor: const Color.fromARGB(255, 7, 32,
                        47), // transparent, you could use 0x44aaaaff to make it slightly less transparent with a blue hue.
                    type: BottomNavigationBarType.fixed,
                    unselectedItemColor: const Color.fromARGB(255, 248, 247, 247),
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.search),
                          label: 'Search',
                          backgroundColor: Color.fromARGB(255, 59, 179, 32)),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.heart_broken),
                        label: 'Favourates',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.library_music_outlined),
                        label: 'Library',
                      ),
                    ],
                  ),
    );
  }
}