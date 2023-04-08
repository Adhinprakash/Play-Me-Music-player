import 'package:flutter/material.dart';
import 'package:myapp/mostlyplayed/musicplayedlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Mostlyplayedscreen extends StatefulWidget {
  const Mostlyplayedscreen({super.key});

  @override
  State<Mostlyplayedscreen> createState() => _MostlyplayedscreenState();
}

class _MostlyplayedscreenState extends State<Mostlyplayedscreen> {
  OnAudioQuery audioQuery = OnAudioQuery();
  List<SongModel> mostly = [];
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
              image: DecorationImage(
                  image: AssetImage('assets/page-1/images/android-large-1.png'),
                  fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color.fromARGB(255, 192, 184, 184),
                        size: 25,
                      )),
               const   Text(
                    ' Mostly Played',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Expanded(child: Mostlyplayedlist())
            ],
          ),
        ),
      )),
    );
  }
}
