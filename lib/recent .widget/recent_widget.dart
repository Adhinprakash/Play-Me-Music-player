import 'package:flutter/material.dart';
import 'package:myapp/recent%20.widget/recentlist.dart';


class Recentwidget extends StatefulWidget {
  const Recentwidget({super.key});

  @override
  State<Recentwidget> createState() => _RecentwidgetState();
}

class _RecentwidgetState extends State<Recentwidget> {
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
              image:  DecorationImage(
                  image:
                      AssetImage('assets/page-1/images/android-large-1.png'),fit: BoxFit.cover)),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 320),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.arrow_back_ios,color: Color.fromARGB(255, 141, 128, 128),)),
                  ],
                ),
              ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:   [
                 const  Text('Recently played',style: TextStyle(fontSize: 25,color:Colors.white),),
                   IconButton(onPressed: (){}, icon: const Icon(Icons.history,color: Color.fromARGB(255, 148, 138, 138) ,))
                  ],
                ),
          const   Recentlyplayedlist()  

            ],
          ),
        ),
      )),
    );
  }
}
