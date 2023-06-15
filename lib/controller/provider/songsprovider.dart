import 'package:flutter/cupertino.dart';

class Songprovider with ChangeNotifier {
  int ids = 0;
  int get id => ids;

  void setid( int id) {
    ids = id;
    notifyListeners();
  }







  
}
