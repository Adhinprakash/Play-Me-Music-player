import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
 class Playmodel extends HiveObject{

@HiveField(0)
String name; 

@HiveField(1)
List<int> songId;

Playmodel({required this.name,required this.songId});

 add(int id){
  songId.add(id);
  save();
}
 deletedata(int id){
    songId.remove(id);
    save();
}
 bool isvalue(int id){
  return songId.contains(id);
 }
}




