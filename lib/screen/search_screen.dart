import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController(); //검색위젯 컨트롤
  FocusNode focusNode = FocusNode(); //커서 상태
  String _searchText = ""; //현재 검색어 값 
  
  _SearchScreenState(){
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text; //TextEditingController가 변화를 감지해, _searchText 상태를 변화시키는 코드
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}