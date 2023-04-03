import 'dart:async';

import 'package:flutter/material.dart';

import 'package:myapp/page-1/home.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
 double _progressValue=0.0;
void updateProgress() {  
    const oneSec = Duration(seconds: 2);  
    Timer.periodic(oneSec, (Timer t) {  
      setState(() {  
        _progressValue += 0.5;  
        if (_progressValue.toStringAsFixed(1) == '1.0') {  
           
          t.cancel();  
          return;  
        }  
      });  
    });  
  } 
  @override
  void initState() {
    super.initState();
    navigatetoallmusic();
    _progressValue=0.0;
    updateProgress();
                         
  }
navigatetoallmusic()async{
 await Future.delayed(const Duration(seconds: 5),(){});
   // ignore: use_build_context_synchronously
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const  screenhome())); 
}

  @override
  Widget build(BuildContext context) {
      final screenHight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return    Scaffold(
   body:Column(
    children: [
      Container(
        width: screenwidth,
      height:screenHight,
      
       decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin:Alignment.topRight
          ,end:Alignment.topLeft,
          colors:[Color.fromARGB(255, 10, 10, 10),Color.fromARGB(255, 38, 56, 55)] ),
       ),

     child: Column (
      mainAxisAlignment: MainAxisAlignment.center,
      children:[ SizedBox(
        height:screenHight*0.5,width: screenwidth*0.5,
        child: Image.asset('assets/page-1/images/headset.png',height: 200,width:double.infinity,)),
   
     Image.asset('assets/page-1/images/logomain.png',height: 100,width: 100,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
           Text("PlayMe",style: TextStyle(fontSize: 43,color: Colors.white),),
            Text('.',style: TextStyle(fontSize:43,color: Color.fromARGB(255, 61, 249, 245) ),),
        ],
      ),
     
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            width: screenwidth*0.2,
            child: LinearProgressIndicator( 
                     
                    backgroundColor:const Color.fromARGB(255, 239, 248, 248),  
                    valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 52, 244, 237)),  
                    value: _progressValue,  
                  ),
          ),
        ),  
     
     ]),
          
        
      )
      
    ],
   ),

    );
   
} 
  }
