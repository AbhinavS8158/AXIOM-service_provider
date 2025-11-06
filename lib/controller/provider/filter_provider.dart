import 'package:flutter/material.dart';

class FilterProvider extends ChangeNotifier{
  String _selectedFilter="All";

  String get selectedFilter=>_selectedFilter;


  final List<Map<String,String>>_allProperties=[
    {'type':'Appartment','name':'Appartment'},
    {'type':'Independent House','name':'House'},
    {'type':'Villa','name':'Villa'},
    {'type':'Penthouse','name':'Penthouse'},
    {'type':'Duplex','name':'Duplex'},
  ];
  List<Map<String,String>> get filteredProperties{
    if(_selectedFilter=='All')return _allProperties;
    return _allProperties
    .where((item)=>item['type']==_selectedFilter).toList();

  }
  void updateFilter(String newFilter){
    _selectedFilter=newFilter;
    notifyListeners();
  }
}