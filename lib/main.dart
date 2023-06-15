import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myapp/DB/model/model.dart';
import 'package:myapp/controller/provider/allmusic_provider/allmusic_provider.dart';
import 'package:myapp/controller/provider/favourite_provider/favourite_provider.dart';
import 'package:myapp/controller/provider/mostlyplayed_provider/mostly_provider.dart';
import 'package:myapp/controller/provider/nowplaying_provider/nowplaying_provider.dart';
import 'package:myapp/controller/provider/playlist_provider/playlist_provider.dart';
import 'package:myapp/controller/provider/recently_provider/recently_provider.dart';
import 'package:myapp/controller/provider/search_provider/search_provider.dart';
import 'package:myapp/controller/provider/songsprovider.dart';
import 'package:myapp/controller/provider/splash_provider/splashprovier.dart';
import 'package:myapp/presentation/screens/splash_screen/Splashscreen.dart';
import 'package:myapp/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';



Future <void> main() async{
 WidgetsFlutterBinding.ensureInitialized();
 SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  if (!Hive.isAdapterRegistered(PlaymodelAdapter().typeId)) {
    Hive.registerAdapter(PlaymodelAdapter());
  }
 await Hive.initFlutter();
 await Hive.openBox<int>('FavouriteDB');
 await Hive.openBox<Playmodel>('playlistdata');
 await Hive.openBox('mostlyplayeddb');
 await Hive.openBox('recenlylistnotifier');


runApp(
  ChangeNotifierProvider(create: (context) => Songprovider(),child:  const MyApp(),));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

	@override
	Widget build(BuildContext context) {
	return MultiProvider(providers: [
   ChangeNotifierProvider(create: (context) => Favouriteprovider(),
   ),
   ChangeNotifierProvider(create: (context) => Recentlyprovider(),
   ),
   ChangeNotifierProvider(create: (context) => MostlyProvider(),),
ChangeNotifierProvider(create: (context) => Searchprovider()
,),
   ChangeNotifierProvider(create: (context) => Allmusicprovider(),
   ),
   ChangeNotifierProvider(create: (context) => Splashprovider(),),
   ChangeNotifierProvider(create: (context) => Nowplayingprovider()),
   ChangeNotifierProvider(create: (context) => PlaylistProvider(),)

  ],
  child: MaterialApp(
		title: 'Flutter',
		debugShowCheckedModeBanner: false,
		scrollBehavior: MyCustomScrollBehavior(),
		theme: ThemeData(
		primarySwatch: Colors.blue,
     fontFamily: GoogleFonts.inder().fontFamily
		),
    
		home: const Splashscreen()
	),
   );
	}

}