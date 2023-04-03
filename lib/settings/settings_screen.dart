
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/DB/functions/functionmostlyplayed.dart';
import 'package:myapp/DB/functions/functionplaylist.dart';
import 'package:myapp/DB/functions/functionsfav.dart';
import 'package:myapp/DB/functions/recently_function.dart';
import 'package:myapp/DB/model/model.dart';
import 'package:myapp/settings/aboutscreen.dart';
import 'package:myapp/settings/feedback.dart';
import 'package:myapp/settings/privacy_and_policy.dart';
import 'package:myapp/settings/terms_and_contition.dart';


class Settingsscreen extends StatelessWidget {
  const Settingsscreen({super.key});

  @override
  Widget build(BuildContext context) {
        final screenHight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(child: SizedBox(
        width: screenwidth,
        height: screenHight,
        child: DecoratedBox(decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/page-1/images/android-large-1.png'), fit: BoxFit.cover)
        ),
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: const Icon(Icons.arrow_back_ios,color: Color.fromARGB(255, 109, 106, 106),size: 30,)),
           const Padding(
               padding:  EdgeInsets.only(left:100),
               child:    Text('Settings',style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.w700,),),
             )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
             Padding(
               padding: const EdgeInsets.only(left: 8,right: 8),
               child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(154, 104, 232, 246)),
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading:const Icon(
                    Icons.error_outline,
                    color: Colors.white60,
                  ),
                  title:const Text(
                    'About Play Me',
                    style: TextStyle(
                        color: Colors.white60, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>const AboutPlayme(),));
                  },
                ),
                         ),
             ),
         const SizedBox(
            height: 10,
            ),
             Padding(
               padding: const EdgeInsets.only(left: 8,right: 8),
               child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(154, 104, 232, 246)),
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading:const Icon(
                    Icons.build_outlined,
                    color: Colors.white60,
                  ),
                  title:const Text(
                    'Terms and contition',
                    style: TextStyle(
                        color: Colors.white60, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>const TermsandContion(),));
                  },
                ),
                         ),
             ),
            const SizedBox(
            height: 10,
            ),
             Padding(
               padding: const EdgeInsets.only(left: 8,right: 8),
               child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(154, 104, 232, 246)),
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading:const Icon(
                    Icons.gpp_maybe_outlined,
                    color: Colors.white60,
                  ),
                  title:const Text(
                    'Privacy & Policy',
                    style: TextStyle(
                        color: Colors.white60, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>const PrivacyandPolicy(),));
                  },
                ),
                         ),
             ),
             const SizedBox(
              height: 10,
             ),
              Padding(
               padding: const EdgeInsets.only(left: 8,right: 8),
               child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(154, 104, 232, 246)),
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading:const Icon(
                    Icons.restore_from_trash_outlined,
                    color: Colors.white60,
                  ),
                  title:const Text(
                    'Reset All',
                    style: TextStyle(
                        color: Colors.white60, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    resetalldialog(context);
                 
                  },
                ),
                         ),
             ),
               Padding(
               padding: const EdgeInsets.only(left: 8,right: 8),
               child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(154, 104, 232, 246)),
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading:const Icon(
                    Icons.feedback_rounded,
                    color: Colors.white60,
                  ),
                  title:const Text(
                    'FeedBack',
                    style: TextStyle(
                        color: Colors.white60, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => Feedbackscreen()));
                  },
                ),
                         ),
             )
             
          ],
        ) ,
        ),
      )),
    );
  }

  restdata(){
 final fav= Hive.box<int>('FavouriteDB');
 final playlist= Hive.box<Playmodel>('playlistdata');
 final mostlyplay= Hive.box('mostlyplayeddb');
 final recent=Hive.box('recenlylistnotifier');
  
fav.clear();
playlist.clear();
mostlyplay.clear();
recent.clear();

FavourateDB.favoratesongs.value.clear();
PlaylistDB.playlistnotifier.value.clear();
MostlyplayedDb.mostlyplayednotifier.value.clear();
Recentfunctions.recenlylistnotifier.value.clear();





}


Future resetalldialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: const Color.fromARGB(255, 30, 234, 214),
      children: [
        const SimpleDialogOption(
          child: Text(
            'Reset all your songs',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
    const  SimpleDialogOption(
        child: Text(
         'Do you really want to reset all songs',
         style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255) ,
          fontSize: 15
         ),
        ),
       ),
       
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);

              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
              restdata();
              Navigator.pop(context);


        const delete = SnackBar(
                           backgroundColor:
                                       Color.fromARGB(222, 38, 46, 67),
                                          content: Center(
                                            child: Text(
                                              'Reset completed',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white70),
                                            ),
                                          ),
                                          duration: Duration(seconds: 2),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(delete);

              },
              child: const Text(
                'Ok',
                style: TextStyle(
                  
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
}



