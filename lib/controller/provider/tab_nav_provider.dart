import 'package:flutter/material.dart';

class TabNavProvider extends ChangeNotifier{
  int _currentIndex=0;
  int get currentIndex=>_currentIndex;

  void setTab(int index){
    _currentIndex=index;
    notifyListeners();
  }
}