
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myapp/DB/functions/functionplaylist.dart';
import 'package:myapp/DB/model/model.dart';
import 'package:myapp/page-1/home.dart';
import 'package:myapp/playlist/Playlistsingle.dart';
import 'package:lottie/lottie.dart';

class PLaylistwidget extends StatefulWidget {
  const PLaylistwidget({super.key});

  @override
  State<PLaylistwidget> createState() => _PLaylistwidgetState();
}

final GlobalKey<FormState> formkey = GlobalKey<FormState>();
final playlistnamecontroller = TextEditingController();

class _PLaylistwidgetState extends State<PLaylistwidget> {
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
            decoration:const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage('assets/page-1/images/android-large-1.png'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              color: Color.fromARGB(255, 148, 145, 145),
                              size: 22,
                            )),
                        IconButton(
                            onPressed: () {
                              newplaylist(context, formKey);
                            },
                            icon: const Icon(
                              Icons.playlist_add,
                              color: Color.fromARGB(255, 150, 148, 148),
                              size: 32,
                            )),
                      ]),
                  const Text(
                    'PlayLists',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                        color: Color.fromARGB(255, 252, 249, 249)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: SizedBox(
                          width: double.infinity,
                          child: ValueListenableBuilder(
                            valueListenable: Hive.box<Playmodel>('playlistdata')
                                .listenable(),
                            builder: (BuildContext context, musiclist,
                                Widget? child) {
                              return Hive.box<Playmodel>('playlistdata').isEmpty
                                  ? Center(
                                      child: InkWell(
                                        onTap: () {
                                          newplaylist(context, formKey);
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: screenHight * 0.25,
                                              width: screenwidth * 0.5,
                                              child: Lottie.asset(
                                                  'assets/page-1/Animation/134604-add-money.json',
                                                  repeat: true,
                                                  height: 300,
                                                  fit: BoxFit.cover),
                                            ),
                                            const Text(
                                              'Click to add new Playlist',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  fontFamily: 'poppins'),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: 2 / 2,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20,
                                      ),
                                      itemBuilder: (context, index) {
                                        final data =
                                            musiclist.values.toList()[index];
                                        return Card(
                                          color: const Color.fromARGB(
                                              255, 18, 2, 61),
                                          shadowColor:
                                             const Color.fromARGB(255, 40, 180, 190),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: const BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 146, 207, 226))),
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                'assets/page-1/images/th (1).png',
                                                fit: BoxFit.fill,
                                                width: double.infinity,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Playlistsingle(
                                                                  pindex: index,
                                                                  playlist:
                                                                      data)));
                                                },
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 146),
                                                child: PopupMenuButton(
                                                  color: const Color.fromARGB(
                                                      255, 163, 227, 223),
                                                  icon: const Icon(
                                                    Icons.more_vert,
                                                    size: 20,
                                                  ),
                                                  itemBuilder: (context) => [
                                                    const PopupMenuItem(
                                                      value: 1,
                                                      child: Text(
                                                        'Edit',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'poppins'),
                                                      ),
                                                    ),
                                                    const PopupMenuItem(
                                                      value: 2,
                                                      child: Text(
                                                        'delete',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'poppins'),
                                                      ),
                                                    )
                                                  ],
                                                  onSelected: (value) {
                                                    if (value == 1) {
                                                      editPlaylistName(
                                                          context, data, index,);
                                                    } else if (value == 2) {
                                                      deletePlaylist(context,
                                                          musiclist, index);
                                                    }
                                                  },
                                                ),
                                              ),
                                              Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      data.name,
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(255, 249, 253, 253),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: musiclist.length,
                                    );
                            },
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();

Future<dynamic> editPlaylistName(
    BuildContext context, Playmodel data, int index) {
  nameController = TextEditingController(text: data.name);
  return showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: const  Color.fromARGB(255, 120, 196, 237),
      children: [
        SimpleDialogOption(
          child: Text(
            "Edit Playlist '${data.name}'",
            style: const TextStyle(
                fontFamily: 'poppins',
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SimpleDialogOption(
          child: Form(
            key: formKey,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: nameController,
              maxLength: 15,
              decoration: InputDecoration(
                  counterStyle: const TextStyle(
                      color: Colors.white, fontFamily: 'poppins'),
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.only(left: 15, top: 5)),
              style: const TextStyle(
                  fontFamily: 'poppins',
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your playlist name";
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
                nameController.clear();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Color.fromARGB(255, 247, 246, 248),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {

                if (formKey.currentState!.validate()) {
                  final name = nameController.text.trim();
                  if (name.isEmpty) {
                    return;
                  } else {
                    final playlistname = Playmodel(name: name, songId: []);
                    PlaylistDB.editplaylist(playlistname, index);
                 
                  }
                  nameController.clear();
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                }
              },
              child: const Text(
                'Update',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Color.fromARGB(255, 248, 246, 248),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

//to create playlist//
Future newplaylist(BuildContext context, formKey) {
  return showDialog(
    context: context,
    builder: (ctx) => SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      backgroundColor: const Color.fromARGB(255, 30, 234, 214),
      children: [
        const SimpleDialogOption(
          child: Text(
            'New to Playlist',
            style: TextStyle(
                fontFamily: 'poppins',
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SimpleDialogOption(
          child: Form(
            key: formKey,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: nameController,
              maxLength: 15,
              decoration: InputDecoration(
                  counterStyle:
                    const  TextStyle(color:  Colors.white, fontFamily: 'poppins'),
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.only(left: 15, top: 5)),
              style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your playlist name";
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(ctx);
                nameController.clear();
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
                if (formKey.currentState!.validate()) {
                 saveButtonPressed(ctx);
             
                }
              },
              child: const Text(
                'Create',
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

//save button and add to database//

Future<void> saveButtonPressed(ctx) async {
  final name = nameController.text.trim();
  final music = Playmodel(name: name, songId: []);
  final datas =PlaylistDB.playlistdata.values.map((e) => e.name.trim()).toList();
  if (name.isEmpty) {
    return;
  } else if (datas.contains(music.name)) {
    const snackbar3 = SnackBar(
        duration: Duration(milliseconds: 750),
        backgroundColor: Colors.black,
        content: Text(
          'playlist already exist',
          style: TextStyle(color: Colors.redAccent),
        ));
    ScaffoldMessenger.of(ctx).showSnackBar(snackbar3);
    Navigator.of(ctx).pop();
  } else {
    PlaylistDB.addplaylist(music);
    const snackbar4 = SnackBar(
        duration: Duration(milliseconds: 750),
        backgroundColor: Colors.black,
        content: Text(
          'playlist created successfully',
          style: TextStyle(color: Colors.white),
        ));
    ScaffoldMessenger.of(ctx).showSnackBar(snackbar4);
    Navigator.pop(ctx);
    nameController.clear();
  }
}

//delete playlist//
Future<dynamic> deletePlaylist(
    BuildContext context, Box<Playmodel> musicList, int index) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 52, 6, 105),
        title: const Text(
          'Delete Playlist',
          style: TextStyle(color: Colors.white, fontFamily: 'poppins'),
        ),
        content: const Text('Are you sure you want to delete this playlist?',
            style: TextStyle(color: Colors.white, fontFamily: 'poppins')),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No',
                style: TextStyle(
                    color: Colors.purpleAccent, fontFamily: 'poppins')),
          ),
          TextButton(
            onPressed: () {
              musicList.deleteAt(index);
              Navigator.pop(context);
              const snackBar = SnackBar(
                backgroundColor: Colors.black,
                content: Text(
                  'Playlist is deleted',
                  style: TextStyle(color: Colors.white),
                ),
                duration: Duration(milliseconds: 350),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Text('Yes',
                style: TextStyle(
                    color: Colors.purpleAccent, fontFamily: 'poppins')),
          ),
        ],
      );
    },
  );
}
