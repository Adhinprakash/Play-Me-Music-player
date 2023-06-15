import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';


class Allmusicprovider extends ChangeNotifier{

  void requestpermission() async{
        final OnAudioQuery audioQuery = OnAudioQuery();  

    bool status= await audioQuery.permissionsStatus();
    if (!status){
      await audioQuery.permissionsRequest();
    }
        
        Permission.storage.request();
        notifyListeners();
    
    }

  }


 