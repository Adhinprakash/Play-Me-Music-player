import 'package:flutter/material.dart';

class AboutPlayme extends StatelessWidget {
  const AboutPlayme({super.key});

  @override
  Widget build(BuildContext context) {
        final screenHight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: DecoratedBox(decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/page-1/images/android-large-1.png'), fit: BoxFit.cover)
        ),
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(onPressed: (){
              Navigator.pop(context);
                }, icon: const Icon(Icons.arrow_back_ios,color: Color.fromARGB(255, 192, 184, 184),size: 25,)),
           const  Padding(
               padding:  EdgeInsets.only(left: 70),
               child:   Text('About playMe',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w400,),),
             )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          Flex(
            direction: Axis.horizontal,
            children:[Expanded(
              child: Container(
                height: screenHight*0.9,
                width: screenwidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white10
                ),
                      
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: const [
                      Text('Welcome to Play Me App, make your life more live.We are dedicated to providing you the very best quality of sound and the music varient,with an emphasis on new features. playlists and favourites,and a rich user experience\n\nFounded in 2023 by Adhin prakash . Play Me is our first major project with a basic performance of music hub and creates a better versions in future.Play Me gives you the best music experience that you never had. it includes attractivemode of UI\'s and good practices.\n\nIt gives good quality and had increased the settings to power up the system as well as to provide better music rythms.\n\nWe hope you enjoy our music as much as we enjoy offering them to you.If you have any questions or comments, please don\'t hesitate to contact us.\n\nSincerely,\n\nAdhin prakash',
                      style: TextStyle(
                        color: Color.fromARGB(255, 221, 214, 214),
                        fontSize: 18
                      ),
                      )
                    ],
                            
                  ),
                ),
              ),
            ),
            ]
          )
          ],
          
        ) ,
        ),
      )),
    );  
  }
}