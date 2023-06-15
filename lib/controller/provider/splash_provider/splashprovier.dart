import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/page-1/home.dart';

class Splashprovider extends ChangeNotifier {
   double progressValue=0.0;

  
  navigatetoallmusic(ctx) async {
    await Future.delayed(const Duration(seconds: 5), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        ctx, MaterialPageRoute(builder: (context) => const screenhome()));
        notifyListeners();
  }


void updateProgress() {  
    const oneSec = Duration(seconds: 2);  
    Timer.periodic(oneSec, (Timer t) {  
      
        progressValue += 0.5;  
        if (progressValue.toStringAsFixed(1) == '1.0') {  
           
          t.cancel();  
          return;  
        }  
       
    });  
    notifyListeners();
  } 

}
