import 'package:flutter/material.dart';
import 'package:myapp/controller/provider/search_provider/search_provider.dart';
import 'package:myapp/page-1/home.dart';
import 'package:myapp/presentation/screens/allmusic/Allmusictile.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchWidget extends StatelessWidget {
 const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
 WidgetsBinding.instance.addPostFrameCallback((_) { 
  Provider.of<Searchprovider>(context,listen: false).getalllsongs();
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
                    image:
                        AssetImage('assets/page-1/images/android-large-1.png'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Consumer<Searchprovider>(
                builder: (context, data, _) {
                  return  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const screenhome()),
                              (route) => false);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Color.fromARGB(255, 159, 154, 154),
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Search',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      onChanged: (value) => data.update(value),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(255, 37, 64, 65),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search Your favourite song..',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 182, 180, 189),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 147, 158, 161),
                          )),
                    ),
                   data. stillsongs.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                'No songs',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.white),
                              ),
                            ),
                          )
                        : Expanded(child: Allmusictile(songmodel:data. stillsongs))
                  ],
                );
                },
                
              ),
            ),
          ),
        ),
      ),
    );
  }

}
