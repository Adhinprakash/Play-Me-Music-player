
import 'package:flutter/material.dart';
import 'package:myapp/controller/provider/splash_provider/splashprovier.dart';
import 'package:provider/provider.dart';


class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
WidgetsBinding.instance.addPostFrameCallback((_) { 
  Provider.of<Splashprovider>(context,listen: false).navigatetoallmusic(context);
});   
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
     const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
           Text("PlayMe",style: TextStyle(fontSize: 43,color: Colors.white),),
            Text('.',style: TextStyle(fontSize:43,color: Color.fromARGB(255, 61, 249, 245) ),),
        ], 
      ),
     
        Consumer<Splashprovider>(
builder: (context, value, _) {
  
       return
           Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: screenwidth*0.2,
              child: LinearProgressIndicator( 
                       
                      backgroundColor:const Color.fromARGB(255, 239, 248, 248),  
                      valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 52, 244, 237)),  
                      value:value.progressValue,  
                    ),
            ),
          );
},
        ),  
     
     ]),
          
        
      )
      
    ],
   ),

    );
   
} 
}

