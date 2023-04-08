

import 'package:flutter/material.dart';
import 'package:myapp/DB/functions/functionsfav.dart';
import 'package:myapp/allmusic/Allmusictile.dart';
import 'package:myapp/page-1/art.dart';
import 'package:myapp/recent%20.widget/recent_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:just_audio/just_audio.dart';

import '../settings/settings_screen.dart';


List<SongModel>stmodel=[];

class Allmusic extends StatefulWidget {
  const Allmusic({super.key});

  @override
  State<Allmusic> createState() => _AllmusicState();
}

class _AllmusicState extends State<Allmusic> {
  @override
  void initState() {  
    super.initState();
    requestpermission();
  }

  void requestpermission() async{
    bool status= await _audioQuery.permissionsStatus();
    if (!status){
      await _audioQuery.permissionsRequest();
      setState(() {
        
        Permission.storage.request();
      });
    }

  }
    final OnAudioQuery _audioQuery = OnAudioQuery();  
  final AudioPlayer _audioplayer = AudioPlayer();


  @override
  Widget build(BuildContext context) {
   final screenHight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
            Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(  
                  image:
                      AssetImage('assets/page-1/images/android-large-1.png'),
                  fit: BoxFit.cover,
                ),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Image.asset("assets/page-1/images/logomain.png",width: 50 ,height: 50,),
                       IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context) => const Settingsscreen() , ));

                       }, icon:  const Icon(Icons.settings),
                          color: Colors.white,
                          iconSize: 30,   
                          )
                      ],
                    ),
                  ),
                const  SizedBox(height:10,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:   [
                    const Text(
                          'All musics',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Padding(
                          padding:const EdgeInsets.only(right: 21),
                          child:  IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Recentwidget()));


                          }, icon: const Icon(Icons.history,color: Colors.white,size: 30,))
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<SongModel>>(  
                        future: _audioQuery.querySongs(
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
                          }if(_audioplayer.audioSource==null){
                            _audioplayer.setAudioSource(Getallsongscontroller.createsongslist(items.data!));
                          }
                    List<SongModel> song=items.data!;
                    for(var element in song){
                      if(element.fileExtension.contains("mp3")&&
                      !element.data.contains("/WhatsApp Audio")&&
                      !element.displayName.contains("AUD")
                      ){
                           stmodel.add(element);
                      }
                    }
                        //  listview bulider//
                       
                        FavourateDB.initialized(stmodel);
                          return Allmusictile(songmodel:stmodel);
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
