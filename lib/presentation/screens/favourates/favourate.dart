import 'package:flutter/material.dart';
import 'package:myapp/controller/provider/favourite_provider/favourite_provider.dart';
import 'package:myapp/page-1/home.dart';
import 'package:myapp/presentation/screens/allmusic/Allmusictile.dart';
import 'package:provider/provider.dart';

class Favourate extends StatelessWidget {
  const Favourate({super.key});

  @override
  Widget build(BuildContext context) {
        final screenHight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return SafeArea(
          child: Scaffold(
            body: SizedBox(
              width: screenwidth,
              height: screenHight,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/page-1/images/android-large-1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const screenhome() ), (route) => false);

                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Color.fromARGB(255, 138, 126, 126),
                          )),
                   const   Padding(
                        padding: EdgeInsets.only(left: 20, top: 40),
                        child: Text(
                          'Favourites',
                          style: TextStyle(
                              fontSize: 27,
                              color: Color.fromARGB(255, 158, 158, 158)),
                        ),
                      ),
                      Expanded(
                        
                          child: Consumer<Favouriteprovider>(
                            builder: (context, value,Widget? child){
                                 if (value.favouritesong.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No Favourates Found',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            } else {
                              final tempdata = value.favouritesong.toList();
                              value.favouritesong = tempdata.toSet().toList();
                            return Allmusictile(songmodel: value.favouritesong);
                            
                            }
                          },),
                       
                        
                        
                      )
                    ]),
              ),
            ),
          ),
        );
  }
}
