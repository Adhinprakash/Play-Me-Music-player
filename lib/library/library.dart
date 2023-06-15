import 'package:flutter/material.dart';
import 'package:myapp/page-1/home.dart';
import 'package:myapp/presentation/screens/playlist/playlist.dart';

import '../presentation/screens/mostlyplayed/mostlyplayed.dart';

class Libraryscreen extends StatelessWidget {
  const Libraryscreen({super.key});

  @override
  Widget build(BuildContext context) {
     final screenHight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
        width: screenwidth,
        height: screenHight,
        child: DecoratedBox(decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/page-1/images/android-large-1.png'), fit: BoxFit.cover)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(onPressed: (){
                Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const screenhome()),
                          (route) => false);
            }, icon: const Icon(Icons.arrow_back_ios,color: Color.fromARGB(255, 192, 184, 184),size: 25,)),
          const   Center(child: Text('Library',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w600,),)),
            const SizedBox(
              height: 20,
            ),     
           Expanded(
             child: ListView(
              children:  [
                ListTile(
                  onTap: () =>  Navigator.push(context, MaterialPageRoute(builder:(context) =>  Mostlyplayedscreen() ,)) ,
                  title: const Text('Mostly Played',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.white),),
                  leading:SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset('assets/page-1/images/mostlypicture.png',
                  
                    height: 20,
                    width: 20,
                    
                    fit: BoxFit.cover,
                    ),
                  ),
                  
                ),
                const SizedBox(

                  height: 20,
                ),  ListTile(
                   onTap: () =>  Navigator.push(context, MaterialPageRoute(builder:(context) => PLaylistwidget() ,)) ,

                  title: const Text('PlayList',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.white),),
                  leading:SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset('assets/page-1/images/playlist.png',
                  
                    height: 20,
                    width: 20,
                    
                    fit: BoxFit.cover,
                    ),
                  ),
                  
                ),

              ],
             ),
           )
          ],
          
        ) ,
        ),
      )),
    );
  }
}