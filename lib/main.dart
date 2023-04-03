import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myapp/DB/model/model.dart';
import 'package:myapp/page-1/Splashscreen.dart';
import 'package:myapp/provider/songsprovider.dart';
import 'package:myapp/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';


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
	return MaterialApp(
		title: 'Flutter',
		debugShowCheckedModeBanner: false,
		scrollBehavior: MyCustomScrollBehavior(),
		theme: ThemeData(
		primarySwatch: Colors.blue,
     fontFamily: GoogleFonts.inder().fontFamily
		),
    
		home: const Splashscreen()
	);
	}

}