import 'package:flutter/material.dart';
import 'package:myapp/controller/provider/mostlyplayed_provider/mostly_provider.dart';
import 'package:myapp/presentation/screens/mostlyplayed/musicplayedlist.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Mostlyplayedscreen extends StatelessWidget {
 Mostlyplayedscreen({super.key});

  OnAudioQuery audioQuery = OnAudioQuery();

  List<SongModel> mostly = [];

  @override
  Widget build(BuildContext context) {
WidgetsBinding.instance.addPostFrameCallback((_) {
  Provider.of<MostlyProvider>(context,listen: false).getmostlyplayed();
});
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
                  image: AssetImage('assets/page-1/images/android-large-1.png',),
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
               Expanded(child: Mostlyplayedlist())
            ],
          ),
        ),
      )),
    );
  }
}
